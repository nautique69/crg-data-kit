#! /bin/bash

sudo raspi-config nonint do_boot_behaviour B4
sudo raspi-config nonint do_wayland W1

sudo apt-get update
sudo apt-get install -y unclutter xdotool

cat > run-penaltydisplay.sh <<EOF
#!/bin/bash

xset s noblank
xset s off
xset -dpms

unclutter -idle 0.5 -root &

sed -i 's/"exited_cleanly":false/"exited_cleanly":true/' /home/pi/.config/chromium/Default/Preferences
sed -i 's/"exit_type": "Crashed"/"exit_type": "Normal"/' /home/pi/.config/chromium/Default/Preferences

DISPLAY=:0.0 /usr/bin/chromium-browser --noerrdialogs --disable-infobars --no-sandbox --kiosk http://scoreboard.local/views/wb/?
EOF
chmod +x ./run-penaltydisplay.sh

mkdir -p /home/pi/.config/lxsession/LXDE-pi/
echo "/home/pi/run-penaltydisplay.sh" >> /home/pi/.config/lxsession/LXDE-pi/autostart

sudo reboot
