#!/bin/bash
# 2020-02-11 for running the updateme playbook against one machine
if [ $1 ]; then
cd /root/ansible/zabbix
ansible-playbook update-notifier/updateme.yml --limit="$1"
else 
	echo "no host given!"
fi
