#!/bin/bash

# update package list
sudo apt-get update

# upgrade all packages
sudo apt-get upgrade -y

configuremono()
{
	wget -O xamarin.gpg http://download.mono-project.com/repo/xamarin.gpg
	apt-key add xamarin.gpg
	rm -f xamarin.gpg
	
	rm -rf /etc/apt/sources.list.d/mono-xamarin.list
	echo "deb http://download.mono-project.com/repo/debian wheezy main" > /etc/apt/sources.list.d/mono-xamarin.list

	apt-get update
	apt-get install -y mono-complete sqlite3 unzip monodevelop mono-xsp4 mono-vbnc

	echo "configure /etc/mono/registry for use with MVC5"
	rm -rf /etc/mono/registry
	mkdir /etc/mono/registry
	mkdir /etc/mono/registry/LocalMachine
	chmod g+rwx /etc/mono/registry/
	chmod g+rwx /etc/mono/registry/LocalMachine

	mozroots --sync --machine
	# mozroots --import --sync
}

googledrive()
{
  add-apt-repository ppa:alessandro-strada/ppa -y
  apt-get update
  apt-get install google-drive-ocamlfuse -y
}

clem()
{
  add-apt-repository ppa:me-davidsansome/clementine
  apt-get update 
  apt-get install clementine -y
}

gitsetup()
{
  apt-get install -y git git-gui 
  wget https://gist.githubusercontent.com/majorsilence/69e3fd56b07657b2e951/raw/f8fe9185849f85094c3278b8d1c89fa5c4467c28/Git%2520Config -O ~/.gitconfig
  chown peter:peter .gitconfig
}

fluxboxinstall()
{
  apt-get install -y fluxbox 
  git clone https://github.com/majorsilence/FluxBoxConfig.git ~/.fluxbox
  chown peter:peter .fluxbox -R
}

dockerinstall()
{
  apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D	
  touch /etc/apt/sources.list.d/docker.list
  echo "deb https://apt.dockerproject.org/repo ubuntu-wily main" >> /etc/apt/sources.list.d/docker.list
  apt-get update
  apt-get install docker-engine -y
}

configuremono
googledrive
clem
gitsetup
fluxboxinstall
dockerinstall

apt-get install -y p7zip-full gstreamer1.0-plugins-ugly  gstreamer1.0-plugins-bad wine network-manager-vpnc-gnome network-manager-openvpn-gnome

# clean up unused packages
sudo apt-get autoclean -y

 ecryptfs-setup-private



