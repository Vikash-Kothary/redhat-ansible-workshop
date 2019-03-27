#!make
#@ Makefile for Ansible Playbook

INVENTORY=~/lightbulb/lessons/lab_inventory/student7-instances.txt
PLAYBOOK=site.yml

#@ Commands:
#@ - help: Show all commands.
help:
	@fgrep -h "#@" $(MAKEFILE_LIST) | fgrep -v fgrep | sed -e 's/\\$$//' | sed -e 's/#@ //'

run-command:
	@echo "Run one-off ansible command"
	@ansible ${GROUP} \
		--module-name ${COMMAND} 

run-command-example:
	@${MAKE} run-command \
		GROUP="-i ${INVENTORY} node3" \
		COMMAND="command -a \"cat /etc/motd\""

lint:
	@ansible-lint ${PLAYBOOK}
# 	@ansible-playbook \
# 		--syntax-check \
# 		${PLAYBOOK}

run: lint
	@ansible-playbook \
		${PLAYBOOK} \
		--ask-vault-pass

open:
	@

import-inventory:
	sudo tower-manage inventory_import --source=${INVENTORY} --inventory-name=${name}

new-role:
	@cd roles && \
		ansible-galaxy init ${NAME}

new-secret:
	@mkdir vault
	@cd vault && \
		ansible-vault create vault.yml
# 	ansible-vault edit vault.yml
# 	ansible-vault view vault.yml