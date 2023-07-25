IS SUPPORTED BY ANSIBLE CI http://sfo-cvdevopsmain.sjclab.exigengroup.com:8080/view/ANSIBLE_CI/

Role Name
=========

This playbook install and manage apache-ant-1.8.4

Requirements
------------

None

Role Variables
--------------

defaults/main.yml
 ant: apache-ant-1.8.4 # version for install
 ant_download_url: http://archive.apache.org/dist/ant/binaries/{{ant}-bin.tar.gz # URL for download
 download_folder: /opt
 ant_name: "{{download_folder}}/{{ant}}"  # folder where install
 ant_archive: "{{download_folder}}/{{ant}}-bin.tar.gz" # full path for archive

vars/CentOS.yml
 packages: # Packages needed for playbook
  - wget


Dependencies
------------

None

Example Playbook
----------------

Clone playbook from repository. In folder where clone playbook:

1. Make file hosts.yml with code:

[hosts]
servername1.domain.com
servername2.domain.com
servername3.domain.com

2. Make file start.yml with code:
   
---
- hosts: hosts
  roles:
    - ant

3. Run playbook with command: 

ansible-playbook -i hosts.yml -u root -k start.yml

License
-------

GPLv2

Author Information
------------------

Alexandr Oransky 
email:<ooranskyi@eisgroup.com>
skype:<alexandr.d.oransky>
