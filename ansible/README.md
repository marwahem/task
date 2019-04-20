Ansible Version : 2.7.10

add user with this command on host machine:
============================================
useradd -s /bin//bash -md /home/ibtikar_usr -g sudo ibtikar_usr
install python:
==============
apt install python
to sudo without password:
=========================
ibtikar_usr     ALL=(ALL)       NOPASSWD:ALL
OR --> can put it in visudo but when run ansible add:
==================================================
--extra-vars "ansible_sudo_pass=yourPassword"
like as ansible-playbook -i hosts playbook/install_lemp.yml --extra-vars "ansible_sudo_pass=marwa"

from ansible machine try to ssh without password:
==================================================
ssh-copy-id -i ~/.ssh/id_rsa.pub ibtikar_usr@192.168.244.138

and add in hosts file on ansible machine
========================================
[ibtkar-task]
alias ansible_host=192.168.224.138 ansible_ssh_port=22 ansible_ssh_user=ibtikar_usr

Run ansible:
============ in path ansible folder
ansible-playbook -i hosts playbook/install_lemp.yml
