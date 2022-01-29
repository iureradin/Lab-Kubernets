#!/bin/bash

yum install epel-release -y
yum update -y
yum install nginx -y
systemctl enable --now nginx.service
