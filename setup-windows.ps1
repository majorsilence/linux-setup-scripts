

Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))

choco install visualstudio2022community -y
choco install jetbrains-rider -y
choco install vscode -y
choco install github-desktop -y
choco install steam-client -y
choco install winmerge -y
choco install 7zip.install -y
choco install greenshot -y
choco install docker-desktop -y
choco install firefox -y
choco install libreoffice-fresh -y
choco install zoom -y

