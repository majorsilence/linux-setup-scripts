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
	apt-get install -y mono-complete sqlite3 unzip

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

configuremono
googledrive
clem

sudo apt-get install -y git fluxbox p7zip-full gstreamer1.0-plugins-ugly gstreamer1.0-ffmpeg gstreamer1.0-plugins-bad wine

# clean up unused packages
sudo apt-get autoclean -y





