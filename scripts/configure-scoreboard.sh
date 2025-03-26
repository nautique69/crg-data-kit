#! /bin/bash

CRG_VERSION="${1:-v2025.5}"

sudo raspi-config nonint do_boot_behaviour B4
sudo raspi-config nonint do_wayland W1

sudo apt-get update
sudo apt-get install -y default-jdk

mkdir ~/scoreboard
cd scoreboard
wget https://github.com/rollerderby/scoreboard/releases/download/$CRG_VERSION/crg-scoreboard_$CRG_VERSION.zip
unzip ./crg-scoreboard_$CRG_VERSION.zip
cd ..

cat > run-scoreboard.sh <<EOF
#! /bin/bash
sudo /home/pi/scoreboard/crg-scoreboard_$CRG_VERSION/scoreboard.sh --port=80
EOF
chmod +x ./run-scoreboard.sh

mkdir -p /home/pi/.config/lxsession/LXDE-pi/
echo "/home/pi/run-scoreboard.sh" >> /home/pi/.config/lxsession/LXDE-pi/autostart

sudo reboot
