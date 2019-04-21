task:
=====
Install LEMP stack using docker compose, and make sure all services are connected to each
other.
Prerequisites
1- Ubuntu 16.04

install docker and docker compose with ansible:
===============================================
ansible-playbook -i hosts playbook/install_docker.yml

installation od lemp:
=====================
from docker-compose folder:
docker-compose build; docker-compose up -d
