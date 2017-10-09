#!/usr/bin/env bash
#
# Scan mail store and backups for dirty files

# check if we have admin rights
[[ $EUID -ne 0 ]] && echo "I need permission to run" && exit 1

DATE="$(date "+%Y-%m-%d %H:%M:%S%z")"
LOG='/var/log/clamav/scan.log'
EMAIL_MSG="ClamAV mail scan finished at $DATE. Please see attached scan log."
EMAIL_FROM=clamav@example.net
EMAIL_TO=admin@example.net
_MAILSCAN=('/home/vmail' '/mnt/backups/mail')

# Scan mail store and mail backups
(nice -n 5 clamscan -ri "${_MAILSCAN[@]}" --scan-mail=yes --phishing-sigs=yes --phishing-scan-urls=yes --max-filesize=42949672960 &> "$LOG";)

# get the value of "Infected lines"
MALWARE=$( tail "$LOG" | grep -i infected | cut -d" " -f3 );

# if the value is not equal to zero, send an email with the log file attached
[[ "$MALWARE" -ne 0 ]] && \
	echo "$EMAIL_MSG" | mail -a "$LOG" -s "Malware Found" -r "$EMAIL_FROM" "$EMAIL_TO"

exit 0
