"""Build the Day 15 morning report page with before/after pictures embedded.
usage: python dist/day15/build_report.py <out.html>"""
import base64
import io
import sys

from PIL import Image

ROOT = "E:/Workspace/Madison/dist/day15/shots/"


def data_uri(path, width=880, crop=None):
    im = Image.open(ROOT + path).convert("RGB")
    if crop:
        W, H = im.size
        im = im.crop((int(W * crop[0]), int(H * crop[1]), int(W * crop[2]), int(H * crop[3])))
    h = int(im.height * width / im.width)
    im = im.resize((width, h), Image.LANCZOS)
    buf = io.BytesIO()
    im.save(buf, "JPEG", quality=78, optimize=True)
    return "data:image/jpeg;base64," + base64.b64encode(buf.getvalue()).decode()


PAIRS = [
    ("abbott", "Abbott is back in the game",
     "The new horse model from Day 14 loaded at the wrong size: 100 times too big and lying on its side, out past the farm. "
     "In the ring you saw Madison floating in the air with no horse under her. The model file is rebuilt so Godot reads it "
     "the way it reads the original horse, and his painted chestnut coat is switched on.",
     ("baseline/halt_side.png", None), ("final2/halt_side.png", None)),
    ("seat", "Madison sits like a rider",
     "She sat on his loins, her shin bones were stretched to reach the stirrups, her arms reached for his ears, and her "
     "whole body tipped as one block. Now she sits in the dip behind his withers. Her legs hang at full length to the "
     "stirrups on his sides, with her knees on the knee rolls. Her hands are on the reins over his withers, and she wears a helmet. "
     "At the canter she sits a little forward with her hands low, like a hunter rider.",
     ("rider1/halt_lside.png", None), ("rb1/halt_lside.png", None)),
    ("ridecam", "From the saddle camera",
     "The view you ride with, at the start of a round.",
     ("baseline/play_cam.png", None), ("final2/play_cam.png", None)),
    ("bridle", "A real bridle",
     "The model only had two bit rings. A bridle was built to fit his head: headpiece, browband, cheekpieces, noseband, "
     "and rings at the bit. The reins now start at the bit.",
     ("head1/halt_headL.png", None), ("head2/halt_headL.png", None)),
    ("jump", "Over a fence",
     "Abbott stretches his neck out and down over the top, and Madison folds with him with her hands up his crest.",
     ("m1/apex.png", (0.15, 0.0, 0.85, 1.0)), ("rider7/apex_lside.png", None)),
    ("fences", "Fences that look like show fences",
     "The brush and flower boxes were sticks with balls on top. They are now a packed hedge and beds of blooms, each "
     "drawn as one piece, which also helped the frame rate.",
     ("m3/fence.png", None), ("fence1/halt_f0.png", None)),
    ("trees", "Green trees",
     "A third of the trees had brown tops because their colours were painted in the wrong order, and a few old "
     "disc-on-pole trees were left by the house. All of them are fixed.",
     ("m1/barn.png", None), ("final2/barn.png", None)),
    ("title", "The title screen",
     "Lesson is now a gold button so a new rider knows where to start, and the small lines are larger and easier to read.",
     ("baseline/title.png", None), ("final2/title.png", None)),
]


LATER = [
    ("reins2/halt_side.png", None, "The reins run along his neck to the bit and drape when he stands. They used to run straight through his neck."),
    ("wave/wave_stands.png", None, "The crowd faces the ring, watches him, and waves when she goes clear. They were six copies of Michelle with clipboards, facing the field."),
    ("score/score_board.png", None, "The arena board shows the running time and faults during a round."),
    ("walkmove/walkmove_02.png", (0.25, 0.30, 0.75, 1.0), "Walking the course, Madison faces the way she walks and uses her own walk. She used to walk backwards, frozen."),
    ("refuse/refuse_lside.png", None, "When he stops at a fence, she is thrown forward and sits back as he settles."),
    ("pat/pat_rside.png", None, "After a clear round, once he walks or stands, she pats his neck."),
    ("rosette4/ribbon_head.png", None, "When she wins a ribbon at a show, the rosette is pinned on his bridle in that colour until the next round."),
    ("titlezoom/title_8000.png", None, "The title photo slowly drifts in and out, so the first screen is not a still picture."),
    ("tail2/tail_compare.png", None, "His tail flows down from a raised dock at the canter. The animation held it straight out like a flag. Standing, he swishes it now and then instead of every 3.3 seconds, and his ears flick back to listen to her."),
    ("braids1/braids_compare.png", None, "On show day his mane is braided: a row of button braids down the crest, the way hunters go in the ring. In lessons and schooling it stays loose. The braids ride his neck, so they go with him over a fence."),
    ("final5/results.png", (0.298, 0.222, 0.698, 0.772), "After a round, the way on is a gold button: Next after a clear round, Retry otherwise, the jump-off when it is offered. A gamepad starts on it."),
]


def main():
    out = sys.argv[1]
    figs = []
    for key, head, text, before, after in PAIRS:
        b = data_uri(before[0], crop=before[1])
        a = data_uri(after[0], crop=after[1])
        figs.append(f"""
    <section class="pair" id="{key}">
      <div class="pair-text">
        <h3>{head}</h3>
        <p>{text}</p>
      </div>
      <div class="shots">
        <figure><img src="{b}" alt="{head}: before" loading="lazy"><figcaption><span class="tag before">Before</span> start of the night</figcaption></figure>
        <figure><img src="{a}" alt="{head}: after" loading="lazy"><figcaption><span class="tag after">After</span> this morning</figcaption></figure>
      </div>
    </section>""")
    later = []
    for path, crop, cap in LATER:
        later.append(f"""
      <figure class="single"><img src="{data_uri(path, width=640, crop=crop)}" alt="{cap}" loading="lazy"><figcaption>{cap}</figcaption></figure>""")
    html = open("E:/Workspace/Madison/dist/day15/report_template.html", encoding="utf-8").read()
    html = html.replace("<!--PAIRS-->", "\n".join(figs))
    html = html.replace("<!--LATER-->", "\n".join(later))
    open(out, "w", encoding="utf-8").write(html)
    print("wrote", out, len(html) // 1024, "KB")


main()
