# Custom Binary Tools

This document tracks binaries and scripts installed in `~/bin` that are not managed by package managers.

## Installation Commands

### download-secure-files
A tool for downloading secure files (7MB binary).

**Installation:**
```bash
# Add the actual installation command here
# Example:
# curl -fsSL https://example.com/install.sh | bash
```

**Source:** [Add URL or description]

**Version:** [Add version info if known]

### subl (Sublime Text CLI)
Symlink to Sublime Text command-line tool.

**Installation:**
```bash
ln -s "/Applications/Sublime Text.app/Contents/SharedSupport/bin/subl" ~/bin/subl
```

**Note:** Requires Sublime Text to be installed first.

## Adding New Tools

When you install a new tool in `~/bin`:

1. Document the installation command above
2. Update this file in your dotfiles:
   ```bash
   chezmoi cd
   # Edit bin-installs.md
   git add bin-installs.md
   git commit -m "Add [tool-name] installation docs"
   git push
   ```

## Automated Installation

Some tools can be automatically installed via the `run_once_install-bin-tools.sh` script.
Others may require manual installation due to interactive prompts or authentication.
