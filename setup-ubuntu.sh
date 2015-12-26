#!/bin/bash

# update package list
sudo apt-get update

# upgrade all packages
sudo apt-get upgrade -y

getubuntuversion()
{
	b=$(cat /etc/issue)

	if [[ $b == *14.04* ]]; 
		then 
		echo '14.04'
	fi

	if [[ $b == *15.10* ]]; 
		then 
		echo '15.10'
	fi
}

read ubuntuversion junk <<< $(getubuntuversion; echo $?)
echo "ubuntu version is: $ubuntuversion"

configuremono()
{
	wget -O xamarin.gpg http://download.mono-project.com/repo/xamarin.gpg
	apt-key add xamarin.gpg
	rm -f xamarin.gpg
	
	rm -rf /etc/apt/sources.list.d/mono-xamarin.list
	echo "deb http://download.mono-project.com/repo/debian wheezy main" > /etc/apt/sources.list.d/mono-xamarin.list

	apt-get update
	apt-get install -y mono-complete sqlite3 unzip monodevelop mono-xsp4 mono-vbnc nuget

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
  if [ "$ubuntuversion" == '14.04' ];
  then
    add-apt-repository ppa:me-davidsansome/clementine
    apt-get update 
    apt-get install clementine -y
  else
    apt-get install clementine -y
  fi
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
  if [ "$ubuntuversion" == '14.04' ];
  then
    echo "deb https://apt.dockerproject.org/repo ubuntu-trusty main" >> /etc/apt/sources.list.d/docker.list
  fi
  if [ "$ubuntuversion" == '15.10' ];
  then
    echo "deb https://apt.dockerproject.org/repo ubuntu-wily main" >> /etc/apt/sources.list.d/docker.list
  fi
  
  apt-get update
  apt-get install docker-engine -y
}

virtualboxinstall()
{
  	
  touch /etc/apt/sources.list.d/virtualbox.list
  if [ "$ubuntuversion" == '14.04' ];
  then
    echo "deb http://download.virtualbox.org/virtualbox/debian trusty contrib" >> /etc/apt/sources.list.d/virtualbox.list
  fi
  if [ "$ubuntuversion" == '15.10' ];
  then
    echo "deb http://download.virtualbox.org/virtualbox/debian wily contrib" >> /etc/apt/sources.list.d/virtualbox.list
  fi
  wget -q https://www.virtualbox.org/download/oracle_vbox.asc -O- | apt-key add -
  
  apt-get update
  apt-get install virtualbox-5.0 -y
}

vagrantinstall()
{
	wget https://releases.hashicorp.com/vagrant/1.7.4/vagrant_1.7.4_x86_64.deb
	dpkg -i vagrant_1.7.4_x86_64.deb
	rm -rf vagrant_1.7.4_x86_64.deb
}

configuremono
googledrive
clem
gitsetup
fluxboxinstall
dockerinstall
virtualboxinstall
vagrantinstall

apt-get install -y p7zip-full gstreamer1.0-fluendo-mp3 gstreamer1.0-plugins-bad wine network-manager-vpnc-gnome network-manager-openvpn-gnome

# clean up unused packages
sudo apt-get autoclean -y

ecryptfs-setup-private
 
mkdir ~/bin
chown peter:peter ~/bin -R



