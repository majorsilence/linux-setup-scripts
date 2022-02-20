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
 
flatpak install flathub us.zoom.Zoom
flatpak install flathub com.valvesoftware.Steam
flatpak install flathub org.gnome.meld
flatpak install flathub org.mozilla.firefox
flatpak install flathub org.libreoffice.LibreOffice
flatpak install flathub io.mrarm.mcpelauncher
flatpak install flathub io.github.shiftey.Desktop
flatpak install flathub com.obsproject.Studio
flatpak install flathub com.getpostman.Postman
flatpak install flathub org.remmina.Remmina

dnf remove -y remmina firefox libreoffice


