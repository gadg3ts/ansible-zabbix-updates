#!/bin/bash
# 2020-02-26 v1 for adding to file to queue running updates on that host
# This file should live in /usr/local/bin on your Zabbix machine

UPDATES_FILE=/tmp/updates_queue
if [ ! -e $UPDATES_FILE ]; then
        touch $UPDATES_FILE
fi
# bash 4.x+ will lowercase variables!
UHOST=${1,,}
if [ "$UHOST" ]; then
                if [ "$(grep $UHOST $UPDATES_FILE)" ]; then
                        echo "host $UHOST is already queued for updates"!
                else
                        echo "$UHOST" >> $UPDATES_FILE
                        echo "Adding $UHOST to updates queue"
                fi
else
        echo "No host provided as \$1!"
fi

