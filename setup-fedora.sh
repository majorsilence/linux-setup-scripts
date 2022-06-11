#!/bin/bash


configuremono()
{
	dnf install -y mono-devel

}


gitsetup()
{
  dnf install -y git-all
  wget https://gist.githubusercontent.com/majorsilence/69e3fd56b07657b2e951/raw/f8fe9185849f85094c3278b8d1c89fa5c4467c28/Git%2520Config -O ~/.gitconfig
  chown peter:peter .gitconfig
}

fluxboxinstall()
{
  dnf install -y fluxbox 
  git clone https://github.com/majorsilence/FluxBoxConfig.git ~/.fluxbox
  chown peter:peter .fluxbox -R
}

dnf install -y p7zip curl docker-ce docker-ce-cli containerd.io flameshot
systemctl start docker

dnf install https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm
dnf install https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
dnf install ffmpeg libva libva-utils

# avoid unresponsive state due memory use, see https://github.com/rfjakob/earlyoom
# this may not want to be installed on machines with plenty of memory
# apt install -y earlyoom

configuremono
gitsetup
# fluxboxinstall

dnf install snapd
ln -s /var/lib/snapd/snap /snap
echo "At this point the system needs to be restarted for snaps to properly install.  See https://snapcraft.io/docs/installing-snap-on-fedora"

#snap install slack --classic
snap install code --classic
snap install dotnet-sdk --classic
snap install rider --classic
#snap install skype --classic
# if remmina does not work in wayland sessions use krdc
#snap install krdc
sudo snap install powershell --classic

 
 # reboot before doing flatpak stuff?
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
 
flatpak install flathub -y --noninteractive us.zoom.Zoom
flatpak install flathub -y --noninteractive com.valvesoftware.Steam
flatpak install flathub -y --noninteractive org.gnome.meld
flatpak install flathub -y --noninteractive org.mozilla.firefox
flatpak install flathub -y --noninteractive org.libreoffice.LibreOffice
flatpak install flathub -y --noninteractive io.mrarm.mcpelauncher
flatpak install flathub -y --noninteractive io.github.shiftey.Desktop
flatpak install flathub -y --noninteractive com.obsproject.Studio
flatpak install flathub -y --noninteractive com.getpostman.Postman
flatpak install flathub -y --noninteractive org.remmina.Remmina
flatpak install flathub -y --noninteractive org.kde.kolourpaint
flatpak install flathub -y --noninteractive app.resp.RESP

dnf remove -y remmina firefox libreoffice


