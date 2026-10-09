"""Launch one headless Blender at below-normal priority. No window."""
import subprocess
import sys

BLENDER = r"C:\Program Files\Blender Foundation\Blender 5.2\blender.exe"
BELOW_NORMAL = 0x00004000
CREATE_NO_WINDOW = 0x08000000
TIMEOUT = 300


def main() -> int:
    args = sys.argv[1:]
    script = __file__.replace("run_blender.py", "blender_render.py")
    if args and args[0] == "--script":
        script = args[1]
        args = args[2:]
    if args and args[0] == "--":
        args = args[1:]
    cmd = [BLENDER, "-b", "--factory-startup", "-P", script, "--", *args]
    print("CMD", " ".join(cmd), flush=True)
    proc = subprocess.Popen(
        cmd,
        creationflags=BELOW_NORMAL | CREATE_NO_WINDOW,
        stdout=subprocess.PIPE,
        stderr=subprocess.STDOUT,
    )
    try:
        out, _ = proc.communicate(timeout=TIMEOUT)
    except subprocess.TimeoutExpired:
        proc.kill()
        out, _ = proc.communicate()
        sys.stdout.buffer.write(out or b"")
        print("\nTIMEOUT %ss" % TIMEOUT, flush=True)
        return 2
    sys.stdout.buffer.write(out or b"")
    return proc.returncode or 0


if __name__ == "__main__":
    raise SystemExit(main())
