#!/usr/bin/env bash

# Expunge old stale Spam/Junk mail daily
# https://wiki2.dovecot.org/Tools/Doveadm/Expunge

[[ $EUID -ne 0 ]] && echo "I need permission to run" && exit 1

$(command -v doveadm) expunge -u "*" mailbox Junk savedbefore 1d 2>/dev/null
$(command -v doveadm) expunge -u "*" mailbox Spam savedbefore 1d 2>/dev/null
