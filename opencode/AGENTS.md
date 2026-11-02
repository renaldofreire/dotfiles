# Global rules

## Language
- Reply in Brazilian Portuguese. Keep technical terms, code, comments,
  commit messages and identifiers in English.

## Environment
- OS: Arch Linux (pacman/yay), Qtile, PipeWire. Shell: bash/zsh.
- Main language: Python. Use `uv` or `python -m venv` per project;
  never `pip install` globally.
- Homelab: Proxmox (LXC + Docker). Prefer docker compose files over
  `docker run` one-liners.

## Style
- Be direct. No preamble, no repeated disclaimers.
- Show the command or the diff first, explanation after, only if needed.
- Prefer small, reviewable changes over large rewrites.

## Safety
- Never print, log or commit secrets (.env, API keys, auth.json).
- Ask before: `rm -rf`, `sudo`, `git push`, `git reset --hard`,
  installing system packages, editing files outside the project directory.
- Do not run `git push` or create remote repos unless explicitly asked.
- If unsure about a command's effect, explain it before running it.
