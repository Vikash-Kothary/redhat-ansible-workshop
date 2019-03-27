#!make
#@ Makefile for Ansible Host Connection

MACHINE_IP=35.157.32.76
USERNAME=student7
PASSWORD=ansible
SSH_MACHINE=${USERNAME}@${MACHINE_IP}
PROJECT_FOLDER=ansible-workshop/

.PHONY: all help create-secure-connection ssh-command requirements sync-folder ssh run ansible-command

#@ Commands:
#@ - help: Show all commands.
help:
	@fgrep -h "#@" $(MAKEFILE_LIST) | fgrep -v fgrep | sed -e 's/\\$$//' | sed -e 's/#@ //'

#@ - create-secure-connection: Setup ssh without password
create-secure-connection:
	@echo "Setup ssh without password"
	ssh-keygen
	ssh-copy-id ${SSH_MACHINE}

#@ - ssh-command: Run ad-hoc command on server
ssh-command:
	@echo "Run ad-hoc command on server"
	@ssh ${SSH_MACHINE} $${command}

#@ - requirements: Install requirements on server
requirements:
	@echo "Install requirements on server"
	@${MAKE} ssh-command command="sudo pip install ansible-lint"
	@${MAKE} ssh-command command="cd /tmp && curl -O https://releases.ansible.com/ansible-tower/setup/ansible-tower-setup-latest.tar.gz && tar xvfz /tmp/ansible-tower-setup-latest.tar.gz && cd /tmp/ansible-tower-setup-*/"	

sync-folder:
	@echo 'Changes synced'
	@scp -r ${PROJECT_FOLDER} ${SSH_MACHINE}:~/. 1> /dev/null

ssh: sync-folder
	@${MAKE} ssh-command

run:
	@${MAKE} ansible-command command=run

ansible-command: 
	@${MAKE} ssh-command command="cd ~/ansible-workshop && make ${command} ${options}"
# 	 1> /dev/null