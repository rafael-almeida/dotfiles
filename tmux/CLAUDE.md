# Tmux Configuration

A minimal, modern, professional tmux configuration. Assumes tmux 3.2+ with XDG config support (`~/.config/tmux/`).

## Principles

- Simple and readable — single-file config, no clever abstractions
- Modern but stable — use current tmux features, avoid deprecated options
- Only popular, well-maintained plugins from reputable authors (tmux-plugins org, christoomey, etc.)
- No gimmicks — every plugin must serve a clear, practical purpose
- Minimal dependencies — only add a plugin when it provides significant value over native functionality; evaluate the security risk of each dependency against its benefit
- No session persistence plugins (resurrect/continuum) — keep it lightweight
