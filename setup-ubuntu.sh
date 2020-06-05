#!/bin/bash

# update package list
sudo apt-get update

# upgrade all packages
sudo apt-get upgrade -y


configuremono()
{
	apt install gnupg ca-certificates
	apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF
	echo "deb https://download.mono-project.com/repo/ubuntu stable-bionic main" | tee /etc/apt/sources.list.d/mono-official-stable.list
	apt update

	apt-get install -y mono-complete sqlite3 unzip nuget

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

podmaninstall()
{
	. /etc/os-release
	sh -c "echo 'deb https://download.opensuse.org/repositories/devel:/kubic:/libcontainers:/stable/xUbuntu_${VERSION_ID}/ /' > /etc/apt/sources.list.d/devel:kubic:libcontainers:stable.list"
	curl -L https://download.opensuse.org/repositories/devel:/kubic:/libcontainers:/stable/xUbuntu_${VERSION_ID}/Release.key | apt-key add -
	apt-get update -qq
	apt-get -qq -y install podman
	alias docker=podman
}

apt install -y 7zip-full curl flatpak gnome-software-plugin-flatpak network-manager-openvpn openvpn network-manager-openvpn-gnome synaptic flameshot nautilus-extension-open-terminal gthumb

# avoid unresponsive state due memory use, see https://github.com/rfjakob/earlyoom
# this may not want to be installed on machines with plenty of memory
# apt install -y earlyoom

configuremono
gitsetup
fluxboxinstall
podmaninstall

apt remove -y remmina firefox libreoffice
# clean up unused packages
sudo apt-get autoclean -y


snap install firefox
snap install slack --classic
snap install code --classic
snap install dotnet-sdk --classic
snap install rider --classic
snap install skype --classic
snap install remmina
snap install libreoffice
sudo snap install powershell --classic
sudo snap install postman
 
 # reboot before doing flatpak stuff?
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
 
flatpak install flathub us.zoom.Zoom
flatpak install flathub com.valvesoftware.Steam
flatpak install flathub org.gnome.meld


