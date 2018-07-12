#!/usr/bin/env bash
#
# Scan mail store for infected mail and move to quarantine
# info: https://www.lisenet.com/2014/automate-clamav-to-perform-daily-system-scan-and-send-email-notifications-on-linux/

# check if we have admin rights
[[ $EUID -ne 0 ]] && echo "root required" && exit 1

DATE="$(date "+%Y-%m-%d %H:%M:%S%z")"
LOG='/var/log/clamav/scan.log'
EMAIL_MSG="ClamAV mail scan finished on $DATE. Infected mail has been quarantined. Please see attached scan log for details."
EMAIL_FROM=clamav@domain.net
EMAIL_TO=admin@domain.net
_MAILSCAN=('/home/vmail')
QUAR='/tmp/clamscan/quarantine'

# Create quarantine directory if it does not exist
[[ -d "$QUAR" ]] || mkdir -p "$QUAR"

# Scan mail store and mail backups
(nice -n 5 clamscan -ri "${_MAILSCAN[@]}" --move="$QUAR" --scan-mail=yes --phishing-sigs=yes --phishing-scan-urls=yes --phishing-cloak=yes --max-filesize=42949672960 &> "$LOG";)

# get the value of "Infected lines"
MALWARE=$( tail "$LOG" | grep -i infected | cut -d" " -f3 );

# if the value is not equal to zero, send an email with the log file attached
[[ "$MALWARE" -ne 0 ]] && \
	echo "$EMAIL_MSG" | mail -a "$LOG" -s "$HOSTNAME Mail Scan: Malware Found" -r "$EMAIL_FROM" "$EMAIL_TO"

exit 0
