# Dotfiles

Public repo, branch `macos`, used by a Mac and an Arch devbox (`ssh devbox`). `src/` mirrors `$HOME`;
`install/x/macos.sh` and `install/x/arch.sh` clone, init submodules and symlink it (rerun them after changes).
Packages: `install/packages/macos/Brewfile`, `install/packages/arch/{pacman,aur}.list`.

## Before committing

- `git diff` first. Tools write into these files: the Vercel app / `vercel ai-gateway setup` append an
  `AI_GATEWAY_API_KEY` export block to `.zshrc` and rewrite `opencode.json` and Zed settings; Claude writes toggles
  like `fastMode` and absolute paths into `src/.claude/settings.json`. Don't commit tool-written or machine-specific
  config, secrets, or private project details (the repo is public).
- `src/.claude/settings.json` is the live `~/.claude/settings.json`. Read it fully before writing; never
  `open(path, "w")` before reading it. Stage only your own hunks.

## Secrets

- One AI Gateway key per machine, read only by `src/.local/bin/ai-gateway-key` (macOS Keychain
  `Vercel AI Gateway`/`vercel-desktop-key`, Linux `systemd-creds`). Never export it from the shell or write it to a file.
- Claude: `apiKeyHelper`. pi: `auth.json` key `!$HOME/.local/bin/ai-gateway-key`. opencode, fx: zsh wrappers in
  `config/scripts.sh`. Codex: its `auth.command` (managed by the Vercel app).
- opencode 2.x also stores credentials in `~/.local/share/opencode/opencode.db` (`opencode auth list`), which win
  over the environment, and runs a long-lived `opencode serve --service` that keeps its old env.

## Agents

- `src/.agents/AGENTS.md` is linked as each agent's global instructions; fx refuses symlinks there, so it gets a copy.
- Vendored skills are pinned submodules in `src/.agents/vendor/` (pstack = `cursor-plugins`). Claude installs pstack
  as a plugin from that marketplace (keep the `~/...` path in settings portable); other agents get
  `~/.agents/skills/<vendor>` (nested), and fx flat links in `~/.claw/skills` (it ignores symlinks in `~/.fx` and
  only scans one level). Own skills live in `src/.agents/skills/`. Update vendors with
  `git submodule update --remote <path>`, review, commit, rerun the install script.

## Neovim

- Neovim 0.12 natives: `vim.pack` (lockfile committed), `vim.lsp.config/enable`, `vim.lsp.completion`. No Mason.
- Language servers come from brew/pacman; TypeScript (TS 7 `tsc --lsp`) and oxfmt only from the project's
  `node_modules` (see `after/lsp/`). There is no global install of either; don't add one.
- Over ssh the clipboard needs `vim.g.clipboard = "osc52"` (nvim won't pick it while `clipboard` is set).

## Devbox

- Keep parity: pull and rerun `install/x/arch.sh` there. `sudo` needs a real TTY, so run it in a terminal pane.
