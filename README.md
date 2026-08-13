# zsh-like-bash

A small collection of Bash scripts that bring some of the quality-of-life features
people love about Zsh — an informative multi-line prompt, a `z`-style directory
jumper, better history handling, and handy aliases — to plain Bash.

## Features

- **`prompt.sh`** — A two-line, color-coded prompt showing:
  - The current working directory (`~` shortened, truncated when too long)
  - Git branch, dirty/clean status (`✓`/`✗`), and ahead/behind counts vs. upstream
  - Last command duration (shown when ≥ 1s) and exit status (shown on failure)
- **`z.sh`** — A lightweight `z` command for jumping to frequently/recently used
  directories by partial name, without any external dependencies. Tracks visited
  directories in a plain text database.
- **`history.sh`** — Saner Bash history defaults (dedup, larger history, append
  instead of overwrite, multi-line command support).
- **`completion.sh`** — Loads system Bash completion and enables Zsh-like
  conveniences (`autocd`, `cdspell`).
- **`aliases.sh`** — Common shortcuts for navigation (`..`, `...`), `ls`
  variants (`ll`, `la`, `l`), and Git (`gs`, `ga`, `gc`, `gp`, `gl`, etc.).

## Installation

Clone the repo and source the scripts you want from your `~/.bashrc`:

```bash
git clone <this-repo-url> ~/.zsh-like-bash

for f in history completion aliases prompt z; do
    source "$HOME/.zsh-like-bash/$f.sh"
done
```

Reload your shell:

```bash
source ~/.bashrc
```

You can pick and choose which files to source — each one is independent.

## Usage

### Prompt

Sourcing `prompt.sh` immediately replaces `PS1` and hooks into `PROMPT_COMMAND`.
No further configuration is needed.

### `z` — directory jumper

`z.sh` records every directory you visit (via a hook in `prompt.sh`'s
`PROMPT_COMMAND`) into a database at `~/.bash/z-data/directories`.

```bash
z foo        # jump to the best-matching visited directory containing "foo"
z foo bar    # match a directory containing both "foo" and "bar"
z            # go home
z -          # go to the previous directory (like `cd -`)
z /abs/path  # behaves like `cd /abs/path`
```

> Note: `z.sh` needs `prompt.sh` sourced as well, since directory tracking
> happens in `__prompt_update`. The `z-data/` folder in this repo is just a
> placeholder for the data directory structure and isn't used at runtime.

### Aliases

See [`aliases.sh`](aliases.sh) for the full list of navigation and Git shortcuts.

## Requirements

- Bash 4+ (uses `shopt` and standard Bash builtins)
- Git (for prompt Git status and Git aliases)
- `bash-completion` package (optional, for `completion.sh`)

## License

No license specified.
