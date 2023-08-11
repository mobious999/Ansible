IS SUPPORTED BY ANSIBLE CI http://sfo-cvdevopsmain.sjclab.exigengroup.com:8080/view/ANSIBLE_CI/

Environment
=========

### Features
This playbook provides possibility to create and delete users with lots of options.
Using this playbook you can also manage security limits (ulimit).

### Instructions
There are two ways to use this playbook - from shell and from jenkins.

From shell:

Get playbook (download or clone from repository).

In playbook root (directory contains environment, hosts.yml and start.yml) directory run:
* Add user eis4 with default options:
```sh
ansible-playbook -i hosts.yml -u root -t user -e '{"user":[{"username":"eis4"}]}' start.yml
```
* Remove user eis16 without deleting its home directory:
```sh
ansible-playbook -i hosts.yml -u root -t user -e '{"user":[{"username":"eis16","state":"absent"}]}' start.yml
```

* Remove users eis15 and eis16 without deleting its home directory:
```sh
ansible-playbook -i hosts.yml -u root -t user -e '{"user":[{"username":"eis16","state":"absent"},{"username":"eis15","state":"absent"}]}' start.yml
```

* Remove user eis7 with its home directory:
```sh
ansible-playbook -i hosts.yml -u root -t user -e '{"user":[{"username":"eis7","state":"absent","remove":"yes"}]}' start.yml
```

* Add sucirity limit "* soft nofile 3072" to file /etc/security/limits.d/test.conf:
```sh
ansible-playbook -i hosts.yml -u root -t limit -e 'limit_filename=test.conf' -e '{"limit":[{"domain":"*","type":"soft","item":"nofile","value":"3072"}]}' start.yml
```
Note: Specifying file (-e 'limit filename=test.conf') is necessary, because you will overwrite existing limits without this.

In hosts.yml should be all servers where you want to apply this playbook.
You can specify variables for this playbook in defaults/main.yml or pass it from shell, but preferred way is to use start.yml for this:
```sh
$ cat start.yml
---
- hosts: sfotest
  roles:
    - environment
  vars:
    limit:
      - domain: "eis"
        type: hard
        item: nofile
        value: 16384
      - domain: "eis"
        type: soft
        item: nofile
        value: 3072
    user:
      - username: eis4
        remove: yes
        state: absent
      - username: eis5
        remove: yes
        state: absent
```

From jenkins:
https://wiki.jenkins-ci.org/display/JENKINS/Ansible+Plugin

### Requirements
* Ansible 1.6

### Dependencies
* None

### Limitations
* None

### Variables

Variable          | Default value     | Description
----------------- | ----------------- | -------------
user              | "username":"eis"  | User to add
user_home         | /home             | User's home directory
user_shell        | /bin/bash         | User's shell
user_system       | no                | Purpose of the account (system or regular user)
user_force        | no                | Force user deletion
user_remove       | no                | Remove user's home directory when deleting account
user_state        | present           | User state (present - add user, absent - remove user)
----------------- | ----------------- |
limit             | see in playbook   | Limit to add
limit_filename    | limit.conf        | File name with limit
limit_user        | root              | Limit file owner
limit_group       | root              | Limit file group
limit_chmod       | 0644              | Limit file permisions
limit_backup      | no                | Limit file backup (create file backup or not)
limit_check       | True              | Check that 'session required pam_limits.so' is present in files
limit_check_state | present           | Check running mode (present - insert string, absent - remove string)
limit_check_files |                   | Files to check (defined in OS variables)

### License

* GPLv2

### Author Information
* Vladimir Pavljuchenkov (email:<vpavljuchenkov@eisgroup.com>, skype:<spiderx_web>)
