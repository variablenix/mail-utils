#! /bin/sh
echo "$3" | mail -s "$HOSTNAME - Warning (program : $2)" -r noreply@example.com root
