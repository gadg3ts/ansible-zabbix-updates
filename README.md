This repo contains the files required for automatically updating your Ubuntu/Debian machines using Ansible and Zabbix (triggers and actions).

zabbix_template_linux-updates.xml should be imported to your Zabbix instance and provides the appropriate items and triggers. This was exported from Zabbix 4.4.6.
process_updates_queue.sh should live on your Zabbix machine in /usr/local/sbin
queue_updates.sh should live on your Zabbix maching in /usr/local/bin
update-one.sh and the update-notifier directory should live on your Ansible host.

The update-notifier directory contains the neccessary Ansible playbooks and associated files for deploying to your hosts.

Full instructions should be available at
https://gadg3ts.com/automatically-updating-ubuntu-debian-with-ansible-and-zabbix/

