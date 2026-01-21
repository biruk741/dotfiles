# Dotfiles

Personal dotfiles managed with [chezmoi](https://www.chezmoi.io/).

## Features

- Cross-platform support (macOS & Linux)
- Secure secret management with 1Password CLI
- Automated package installation with Homebrew Bundle
- Global package tracking (bun, npm, pnpm)
- Custom Catppuccin-themed shell environment
- Custom bin tools documentation

## Quick Start

### New Machine Setup

```bash
# Install chezmoi and apply dotfiles
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply biruk741
```

### Prerequisites

- **macOS**: Xcode Command Line Tools (`xcode-select --install`)
- **Linux**: curl, git
- **1Password**: Sign in to 1Password CLI for secrets (`op signin`)

### What Gets Installed

- 180+ CLI tools via Homebrew
- oh-my-zsh with custom Catppuccin theme
- 10 bun global packages
- 3 npm global packages
- Git, tmux, starship configurations
- And much more!

## Manual Steps After Installation

1. **Sign in to 1Password CLI**:
   ```bash
   op signin
   chezmoi apply  # Re-apply to populate secrets
   ```

2. **Install custom bin tools**:
   See `bin-installs.md` for installation commands

3. **Configure Git user** (if needed):
   ```bash
   git config --global user.email "your.email@example.com"
   git config --global user.name "Your Name"
   ```

## Updating Dotfiles

### After modifying configs

```bash
chezmoi add ~/.zshrc
chezmoi cd
git add .
git commit -m "Update zsh config"
git push
```

### After installing new Homebrew packages

```bash
chezmoi cd
./scripts/update-brewfile.sh
git add Brewfile
git commit -m "Update Brewfile"
git push
```

### After installing new global packages

```bash
chezmoi cd
./scripts/update-global-packages.sh
git add *-globals.txt
git commit -m "Update global packages"
git push
```

### Pull updates from remote

```bash
chezmoi update
```

## Repository Structure

```
~/.local/share/chezmoi/
├── Brewfile                              # Common Homebrew packages
├── Brewfile.darwin                       # macOS-specific packages
├── Brewfile.linux                        # Linux-specific packages
├── bun-globals.txt                       # Bun global packages
├── npm-globals.txt                       # npm global packages
├── pnpm-globals.txt                      # pnpm global packages
├── bin-installs.md                       # Custom bin tools documentation
├── dot_zshrc.tmpl                       # Shell config (with secrets)
├── dot_aliases                          # Shell aliases
├── dot_gitconfig                        # Git configuration
├── dot_tmux.conf                        # Tmux configuration
├── dot_ssh/config                       # SSH configuration
├── dot_config/
│   ├── starship.toml                   # Starship prompt
│   ├── eza/                            # eza config
│   └── atuin/                          # atuin config
├── dot_oh-my-zsh/themes/
│   ├── refined-catppuccin.zsh-theme   # Custom theme
│   └── catppuccin-flavors/            # Theme colors
├── scripts/
│   ├── update-global-packages.sh      # Update global package lists
│   └── update-brewfile.sh             # Update Brewfile
├── run_once_before_install-packages.sh.tmpl
├── run_once_after_install-global-packages.sh.tmpl
├── run_once_after_setup-shell.sh.tmpl
└── run_once_after_setup-1password.sh.tmpl
```

## Secrets Management

Secrets are managed via 1Password CLI. The following environment variables are populated from 1Password:

- `GITLAB_TOKEN`
- `GITLAB_TOKEN_MCP`
- `NPM_TOKEN`
- `ACCERTIFY_NPM_TOKEN`
- `NIFT_NPM_TOKEN`
- `NIFT_GITHUB_TOKEN`
- `OPENAIAPIKEY`
- `TEMPO_API_KEY`
- `JIRA_TOKEN`

## Troubleshooting

### Secrets not loading

```bash
op signin
eval $(op signin)
chezmoi apply
```

### Permission errors on scripts

```bash
chezmoi cd
chmod +x run_*.sh scripts/*.sh
```

### Homebrew not in PATH

```bash
# macOS (Apple Silicon)
eval "$(/opt/homebrew/bin/brew shellenv)"

# macOS (Intel)
eval "$(/usr/local/bin/brew shellenv)"

# Linux
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
```

## License

MIT
