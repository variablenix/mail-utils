#!/usr/bin/env bash

# Expunge old Trash mail after 4 weeks
# https://wiki2.dovecot.org/Tools/Doveadm/Expunge

[[ $EUID -ne 0 ]] && echo "I need permission to run" && exit 1

$(command -v doveadm) expunge -u "*" mailbox "Trash*" savedbefore 4w 2>/dev/null
