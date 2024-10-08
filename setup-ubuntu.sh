#!/bin/bash

# update package list
apt-get update

# upgrade all packages
apt-get upgrade -y

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

apt install -y p7zip-full curl docker.io flatpak gnome-software-plugin-flatpak synaptic flameshot pan dotnet-sdk-6.0 dotnet-sdk-8.0 build-essential cockpit cockpit-machines cockpit-pcp

groupadd docker
usermod -aG docker $USER
chown root:docker /var/run/docker.sock
chown -R root:docker /var/run/docker
# this works but the group does not?  Why?
chown $USER /var/run/docker.sock
newgrp docker 


# avoid unresponsive state due memory use, see https://github.com/rfjakob/earlyoom
# this may not want to be installed on machines with plenty of memory
# apt install -y earlyoom

gitsetup
fluxboxinstall

snap install code --classic
snap install rider --classic
# if remmina does not work in wayland sessions use krdc
#snap install krdc
snap install powershell --classic

 
 # reboot before doing flatpak stuff?
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
 
flatpak install flathub -y --noninteractive us.zoom.Zoom
flatpak install flathub -y --noninteractive com.valvesoftware.Steam
flatpak install flathub -y --noninteractive org.gnome.meld
flatpak install flathub -y --noninteractive org.libreoffice.LibreOffice
flatpak install flathub -y --noninteractive io.mrarm.mcpelauncher
flatpak install flathub -y --noninteractive io.github.shiftey.Desktop
flatpak install flathub -y --noninteractive com.obsproject.Studio
flatpak install flathub -y --noninteractive com.getpostman.Postman
flatpak install flathub -y --noninteractive org.remmina.Remmina
flatpak install flathub -y --noninteractive org.kde.kolourpaint
flatpak install flathub -y --noninteractive app.resp.RESP
flatpak install flathub -y --noninteractive io.github.peazip.PeaZip

apt remove -y remmina libreoffice
# clean up unused packages
apt-get autoclean -y

