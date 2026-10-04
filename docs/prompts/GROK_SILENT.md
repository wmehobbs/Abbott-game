# Grok Build — silent, or not at all

Ernie is at the machine. A visible Godot window or `dist\Abbott.exe` locks the
desktop: mouse dead, keyboard dead, work stopped. That is a failed run even
if the code is right.

## Allowed

One binary, one flag, in this order:

`Godot_v4.7.2-stable_win64_console.exe --headless --path E:\Workspace\Madison\game`

Then the rest (`-- --playtest`, `-- --ridecert`, a `-s` script). `--headless`
is the first argument after the exe. If it is not, do not run the command.

Stdout is the evidence. Playtest prints clear / refuse / rail. Ridecert
prints the board. Read the log.

## Forbidden

- `dist\Abbott.exe`, `Start-Process` on it, double-click, or "just to see."
- Godot with no `--headless`. The editor. A debug window. F5. F6.
- `--artshot`, `--artshot-rider`, or any screenshot pass. Those open a
  window. Skip them while Ernie is at the desk. Verify with headless
  playtest only.
- Export that you then launch. Do not pack today unless the prompt you
  were given says pack, and even then do not run the exe.
- A second Godot of any kind if one is already running.

If a window appears anyway, close it immediately and do not retry that
command. Write the command in `dist/STATUS.md` so it is not run again.

Work in `E:\Workspace\Madison` on disk. The game stays closed.
