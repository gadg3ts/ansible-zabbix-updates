#!/bin/bash
# 2020-02-26 v1 
# takes the top line from /tmp/updates_queue and runs the updateme ansible script from autosec
# plus, checks if it's already updating that host (just in case!)
# NOTE: adjust the path to update-one.sh as appropriate
# and the destination email address!
# This file should live in /usr/local/sbin on your Zabbix machine

UPDATES_FILE=/tmp/updates_queue
UPDATES_RUNNING=/tmp/running_update
RECIPIENT=me@example.com
NEXT_HOST=$(head --lines=1 $UPDATES_FILE)
if [ "$NEXT_HOST" ]; then
        if [ $(grep "$NEXT_HOST" $UPDATES_RUNNING) ]; then
                echo "This host is already running updates"
        else
                echo "$NEXT_HOST" > $UPDATES_RUNNING
                ssh root@autosec /root/ansible/zabbix/update-one.sh $NEXT_HOST | /usr/bin/mailx -s "$NEXT_HOST updated via zabbix scripts!" $RECIPIENT
                sed -i "/$NEXT_HOST/d" $UPDATES_RUNNING
                sed -i "/$NEXT_HOST/d" $UPDATES_FILE
        fi
else
        echo "Value of NEXT_HOST is empty!"
        exit 1
fi

