#!/usr/bin/env bash

# Generic Test for Unsolicited Bulk Email
# https://spamassassin.apache.org/gtube/
#
# SpamAssassin will flag an email message generated with this script as spam
# and and move it to the Spam/Junk folder if everything is configured appropriately

# Check if swaks is installed
(command -v swaks &>/dev/null)
[[ $? != 0 ]] && printf "%s\n" "Could not find swaks in your PATH" && exit 1

# usage
usage() {
    cat <<EOM
    Usage:
    $(basename $0) <recipient@domain.net>
EOM
    exit 0
}

[ -z $1 ] && { usage; }

swaks --to $1 --server localhost --header "Subject: XJS*C4JDBQADN1.NSBN3*2IDNEN*GTUBE-STANDARD-ANTI-UBE-TEST-EMAIL*C.34X"

exit 0
