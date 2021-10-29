#!/bin/bash
echo "install"
cd 
dpkg --configure -a
apt-get update
apt-get -y install vim
apt-get -y install build-essential gcc make perl dkms
apt-get -y install geany
usermod -G vboxsf -a $USER
echo "Si il n'y a pas de message d'erreur vous pouvez fermer le terminal"
