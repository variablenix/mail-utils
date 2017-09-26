 #!/bin/sh
 BOUNDARY="$1"
 USER="$2"
 MSG=""
 if [[ "$BOUNDARY" = "+100" ]]; then
    MSG="Your mailbox is now overfull (>100%). In order for your account to continue functioning properly, you need to remove some emails NOW."
 elif [[ "$BOUNDARY" = "+95" ]]; then
    MSG="Your mailbox is now over 95% full. Please remove some emails ASAP."
 elif [[ "$BOUNDARY" = "+80" ]]; then
    MSG="Your mailbox is now over 80% full. Please consider removing some emails to save space."
 elif [[ "$BOUNDARY" = "-100" ]]; then
    MSG="Your mailbox is now back to normal (<100%)."
 fi

 cat << EOF | /usr/lib/dovecot/dovecot-lda -d $USER -o "plugin/quota=maildir:User quota:noenforcing"
 From: postmaster@example.com
 Subject: Email Account Quota Warning

 Dear User,

 $MSG

 Cheers,
 Staff
EOF
