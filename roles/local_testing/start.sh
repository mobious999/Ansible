#!/bin/bash
ansible-playbook -i hosts start.yml -u root -e "ansible_become_password=Password123"
