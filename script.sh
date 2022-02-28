#!/bin/bash
echo -e "test\ntest" | passwd ubuntu
apt-get update
apt-get -y install apache2 php  libapache2-mod-php 