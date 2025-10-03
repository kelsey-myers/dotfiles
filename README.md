# My Dotfiles

Personal configuration files for GitHub Codespaces.

## What's included

- Git configuration (auto push remote, pull rebase, auto stash)
- Bash aliases for common git operations
- `tatt` function for running tests with multiple configurations

## Usage

GitHub Codespaces will automatically:
1. Clone this repo when creating a new Codespace
2. Run `install.sh` to set up your environment

No manual setup needed! 🎉

## Testing locally

You can test the install script manually:

```bash
bash install.sh
source ~/.bashrc
```
