"""Rewrite a skinned horse glb so its skinned meshes use the original Quaternius
layout: vertices in AnimalArmature-local space (Z up, 1/100 scale) and the mesh
node carrying the armature's transform (scale 100, -90 deg about X).

Blender's current exporter bakes the armature transform into world-space
vertices. Godot then reads those vertices in the skeleton's own space, so the
horse came out 100x too big and lying on its side. Positions, normals and the
inverse bind matrices are rewritten together, so skinning is unchanged.

usage: python glb_to_quaternius_layout.py <src.glb> <dst.glb> <reference.glb>
"""
import json
import struct
import sys

import numpy as np

COMP = {5126: ("<f4", 4)}


def read_glb(path):
    b = open(path, "rb").read()
    assert b[:4] == b"glTF"
    n = struct.unpack("<I", b[12:16])[0]
    j = json.loads(b[20:20 + n])
    off = 20 + n
    bn = struct.unpack("<I", b[off:off + 4])[0]
    assert b[off + 4:off + 8] == b"BIN\x00"
    binary = bytearray(b[off + 8:off + 8 + bn])
    return j, binary


def write_glb(path, j, binary):
    js = json.dumps(j, separators=(",", ":")).encode("utf-8")
    js += b" " * ((4 - len(js) % 4) % 4)
    binary = bytes(binary) + b"\x00" * ((4 - len(binary) % 4) % 4)
    total = 12 + 8 + len(js) + 8 + len(binary)
    out = b"glTF" + struct.pack("<II", 2, total)
    out += struct.pack("<I", len(js)) + b"JSON" + js
    out += struct.pack("<I", len(binary)) + b"BIN\x00" + binary
    open(path, "wb").write(out)


def view(j, binary, acc_i, ncomp):
    acc = j["accessors"][acc_i]
    bv = j["bufferViews"][acc["bufferView"]]
    assert acc["componentType"] == 5126
    stride = bv.get("byteStride", 4 * ncomp)
    start = bv.get("byteOffset", 0) + acc.get("byteOffset", 0)
    count = acc["count"]
    arr = np.zeros((count, ncomp), np.float32)
    for k in range(count):
        o = start + k * stride
        arr[k] = np.frombuffer(binary, "<f4", ncomp, o)
    return arr, start, stride


def store(binary, arr, start, stride):
    for k in range(arr.shape[0]):
        o = start + k * stride
        binary[o:o + 4 * arr.shape[1]] = arr[k].astype("<f4").tobytes()


def main():
    src, dst, ref = sys.argv[1], sys.argv[2], sys.argv[3]
    j, binary = read_glb(src)
    rj, _ = read_glb(ref)
    names = [n.get("name") for n in j["nodes"]]
    arm_i = names.index("AnimalArmature")
    arm = j["nodes"][arm_i]
    s = np.array(arm.get("scale", [1, 1, 1]), np.float64)
    q = arm.get("rotation", [0, 0, 0, 1])
    x, y, z, w = q
    R = np.array([
        [1 - 2 * (y * y + z * z), 2 * (x * y - z * w), 2 * (x * z + y * w)],
        [2 * (x * y + z * w), 1 - 2 * (x * x + z * z), 2 * (y * z - x * w)],
        [2 * (x * z - y * w), 2 * (y * z + x * w), 1 - 2 * (x * x + y * y)],
    ])
    A = np.eye(4)
    A[:3, :3] = R @ np.diag(s)
    Ainv = np.linalg.inv(A)
    print("armature scale", s, "rot", q)
    done = set()
    for ni, node in enumerate(j["nodes"]):
        if "mesh" not in node or "skin" not in node:
            continue
        assert not node.get("scale") and not node.get("rotation") and not node.get("translation"), "mesh node already has a transform"
        for prim in j["meshes"][node["mesh"]]["primitives"]:
            for key, mode in (("POSITION", "p"), ("NORMAL", "n")):
                ai = prim["attributes"].get(key)
                if ai is None or ai in done:
                    continue
                done.add(ai)
                arr, start, stride = view(j, binary, ai, 3)
                if mode == "p":
                    h = np.c_[arr.astype(np.float64), np.ones(len(arr))]
                    out = (h @ Ainv.T)[:, :3]
                    j["accessors"][ai]["min"] = [float(v) for v in out.min(axis=0)]
                    j["accessors"][ai]["max"] = [float(v) for v in out.max(axis=0)]
                else:
                    out = arr.astype(np.float64) @ R  # R^T applied to row vectors
                    out /= np.maximum(np.linalg.norm(out, axis=1, keepdims=True), 1e-9)
                store(binary, out.astype(np.float32), start, stride)
        node["scale"] = [float(v) for v in s]
        node["rotation"] = [float(v) for v in q]
        print("node", node.get("name"), "now carries the armature transform")
    for sk in j["skins"]:
        ai = sk["inverseBindMatrices"]
        arr, start, stride = view(j, binary, ai, 16)
        out = np.zeros_like(arr)
        for k in range(len(arr)):
            m = arr[k].astype(np.float64).reshape(4, 4).T  # column-major
            out[k] = (m @ A).T.reshape(16)
        store(binary, out.astype(np.float32), start, stride)
        # Same skeleton root as the reference file, by joint name.
        rsk = rj["skins"][0]
        if "skeleton" in rsk:
            want = rj["nodes"][rsk["skeleton"]].get("name")
            if want in names:
                sk["skeleton"] = names.index(want)
                print("skin skeleton root", want)
    write_glb(dst, j, binary)
    print("wrote", dst)


main()
