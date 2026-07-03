#!/bin/sh
# Prints the Vercel AI Gateway API key from the per-machine secret store.
# zsh/config/scripts.sh exports it as AI_GATEWAY_API_KEY (codex) and
# ANTHROPIC_AUTH_TOKEN (Claude Code) at shell startup.
# macOS stores it in the Keychain; Linux in a systemd-creds encrypted file
# (bound to the machine's host key, so the .cred file is useless off-box).
#
# To store/update the token (get one at https://vercel.com/d?to=%2F%5Bteam%5D%2F%7E%2Fai%2Fapi-keys):
#   macOS: security add-generic-password -U -a "$USER" -s ANTHROPIC_AUTH_TOKEN -w '<token>'
#   Linux: mkdir -p ~/.config/claude && printf '%s' '<token>' | systemd-creds encrypt --user \
#            --name=anthropic_auth_token - ~/.config/claude/anthropic_auth_token.cred
#          (the .cred file is safe at rest but machine-bound: re-run this after a reinstall)
#
# First-time setup on a new machine:
#   1. Store the token as above.
#   2. Make sure ANTHROPIC_BASE_URL points where you want (exported from .zshrc;
#      override per-machine in zsh/config/local.sh, e.g. https://ai-gateway.vercel.sh).
#   3. Run `claude /logout` once so Claude Code stops using an OAuth login and
#      picks up ANTHROPIC_AUTH_TOKEN from the environment.

if [ "$(uname)" = "Darwin" ]; then
  security find-generic-password -a "$USER" -s "ANTHROPIC_AUTH_TOKEN" -w
else
  systemd-creds decrypt --user --name=anthropic_auth_token \
    "$HOME/.config/claude/anthropic_auth_token.cred" -
fi
