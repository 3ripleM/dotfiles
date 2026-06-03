# dotfiles

Personal dotfiles for macOS and Linux, managed with [chezmoi](https://chezmoi.io).

## What's included

| Config | Details |
|--------|---------|
| **Neovim** | LazyVim-based setup, 38 plugins |
| **Fish** | config, custom functions (`memory`, `watch`), tide prompt |
| **Tmux** | catppuccin theme, TPM plugins |
| **AeroSpace** | Tiling window manager (macOS only) |
| **Ghostty** | Terminal emulator config |

### Fish plugins (via Fisher)
- [tide](https://github.com/IlanCosman/tide) — prompt
- [nvm.fish](https://github.com/jorgebucaran/nvm.fish) — Node version manager
- [gitnow](https://github.com/joseluisq/gitnow) — git shortcuts

### Brew packages
`neovim` · `tmux` · `fish` · `git` · `fzf` · `ripgrep` · `fd` · `lazygit` · `ruby` · `uv`

macOS only: `zulu@17` · `orbstack` · `ghostty` · `aerospace`

---

## Bootstrap a new machine

```bash
# 1. Install chezmoi
sh -c "$(curl -fsLS get.chezmoi.io)"

# 2. Apply dotfiles (replace with your repo URL once on GitHub)
chezmoi init --apply /path/to/this/repo
```

If you want to skip package/tool installation and just apply dotfiles, use:

```bash
SKIP_INSTALL_TOOLS=1 chezmoi init --apply /path/to/this/repo
```

or after init:

```bash
SKIP_INSTALL_TOOLS=1 chezmoi apply
```

chezmoi will:
1. Prompt for your name, email, and whether this is a work machine
2. Prompt for any API keys you want injected into config
3. Install all tools (Homebrew + packages, TPM, catppuccin, Fisher + plugins)
4. Apply all configs to `$HOME`
5. Set fish as your default shell

---

## Machine identity & secrets

Answers to the setup prompts are stored locally in `~/.config/chezmoi/chezmoi.toml` — never committed. Each machine has its own private values.

Secrets (e.g. API keys) are injected into `conf.d/secrets.fish` via templates at apply time.

---

## Daily workflow

```bash
# Edit a config through chezmoi
chezmoi edit ~/.config/fish/config.fish

# See what would change
chezmoi diff

# Apply changes to home dir
chezmoi apply

# Commit and push
chezmoi cd
git add -A && git commit -m "..." && git push
```

To pull updates on another machine:
```bash
chezmoi update
```
