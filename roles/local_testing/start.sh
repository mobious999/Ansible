#!/bin/bash
ansible-playbook -i hosts.yml start.yml -b  --extra-vars "@vars.json"
