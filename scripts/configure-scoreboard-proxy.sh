#! /bin/bash

sudo raspi-config nonint do_boot_behaviour B4
sudo raspi-config nonint do_wayland W1

sudo apt-get update
sudo apt-get install -y nginx

cat > run-proxy.sh <<EOF
sudo nginx
EOF
chmod +x ./run-proxy.sh

cat > toggle.sh <<EOF
sudo nginx -s stop
sudo mv /etc/nginx/conf.d/scoreboard.conf /etc/nginx/conf.d/scoreboard.conf.tmp
sudo mv /etc/nginx/conf.d/scoreboard.conf.toggle /etc/nginx/conf.d/scoreboard.conf
sudo mv /etc/nginx/conf.d/scoreboard.conf.tmp /etc/nginx/conf.d/scoreboard.conf.toggle
sudo nginx
EOF
chmod +x ./toggle.sh

cat > scoreboard.conf << EOF
stream {
        server {
                listen  80;
                proxy_pass      scoreboard1:80;
        }

        server {
                listen  8080;
                proxy_pass      scoreboard2:80;
        }
}

http {
        server {
                listen 5000;
                location /live {
                        add_header Content-Type text/plain;
                        return 200 'scoreboard1';
                }
                location /staging {
                        add_header Content-Type text/plain;
                        return 200 'scoreboard2';

                }
        }
}
EOF

cat > scoreboard.conf.toggle << EOF
stream {
        server {
                listen  80;
                proxy_pass      scoreboard2:80;
        }

        server {
                listen  8080;
                proxy_pass      scoreboard1:80;
        }
}

http {
        server {
                listen 5000;
                location /live {
                        add_header Content-Type text/plain;
                        return 200 'scoreboard2';
                }
                location /staging {
                        add_header Content-Type text/plain;
                        return 200 'scoreboard1';

                }
        }
}
EOF

sudo mv ./scoreboard.conf /etc/nginx/conf.d/
sudo mv ./scoreboard.conf.toggle /etc/nginx/conf.d/

mkdir -p /home/pi/.config/lxsession/LXDE-pi/
echo "/home/pi/run-proxy.sh" >> /home/pi/.config/lxsession/LXDE-pi/autostart

sudo reboot
