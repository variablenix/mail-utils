#!/bin/sh

# Get the last login of a mail user
# Perl source: https://stackoverflow.com/a/3178341/5575161

maillog='/var/log/mail/mail.log'

#perl -ne '$l{$2}=$1 if /^(.{15}) .* imap-login: Login: user=<([^>]+)>/; END { print "$_ last imap-login: $l{$_}\n" for keys %l }' "$maillog"
perl -ne '$l{$2}=$1 if /^(.{15}) .* Login: user=<([^>]+)>/; END { print "$_ last imap-login: $l{$_}\n" for keys %l }' "$maillog" | sort -h
