#!/bin/bash
# 2020-02-26 v1 takes the top line from /tmp/updates_queue and runs the updatme ansible script from autosec
# 2020-05-15 updated to just notify on "FAILED!" - actually to start with we just want to know from the subject line...
UPDATES_FILE=/tmp/updates_queue
UPDATES_RUNNING=/tmp/running_update
RECIPIENT=me@example.com
NEXT_HOST=$(head --lines=1 $UPDATES_FILE)
OUTPUT=/tmp/$NEXT_HOST.out
if [ "$NEXT_HOST" ]; then
	if [ $(grep "$NEXT_HOST" $UPDATES_RUNNING) ]; then
		echo "This host is already running updates"
	else
		echo "$NEXT_HOST" > $UPDATES_RUNNING
		# ssh root@autosec /root/ansible/zabbix/update-one.sh $NEXT_HOST | /usr/bin/mailx -s "$NEXT_HOST updated via zabbix scripts!" $RECIPIENT

		ssh root@autosec /root/ansible/zabbix/update-one.sh $NEXT_HOST > $OUTPUT
		RESULT=$( grep "FAILED" $OUTPUT ) 
		if [ "$RESULT" ];  then
			cat $OUTPUT | /usr/bin/mailx -s "$NEXT_HOST FAILED update via zabbix scripts!" $RECIPIENT
		else
			cat $OUTPUT | /usr/bin/mailx -s "$NEXT_HOST updated OK via zabbix scripts!" $RECIPIENT
		fi
		sed -i "/$NEXT_HOST/d" $UPDATES_RUNNING
		sed -i "/$NEXT_HOST/d" $UPDATES_FILE
	fi
else
	echo "Value of NEXT_HOST is empty!"
	exit 1
fi

