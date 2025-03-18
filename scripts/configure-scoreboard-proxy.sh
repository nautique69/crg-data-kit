#! /bin/bash

sudo raspi-config nonint do_boot_behaviour B4
sudo raspi-config nonint do_wayland W1

sudo apt-get update
sudo apt-get install -y nginx libnginx-mod-stream

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

cat > nginx.conf << EOF
user www-data;
worker_processes auto;
pid /run/nginx.pid;
include /etc/nginx/modules-enabled/*.conf;
include /etc/nginx/conf.d/*.conf;

events {
        worker_connections 768;
}
EOF

sudo rm /etc/nginx/nginx.conf
sudo mv ./nginx.conf /etc/nginx/

cat > scoreboard.conf << EOF
stream {
        server {
                listen  80;
                proxy_pass      scoreboard1.local:80;
        }

        server {
                listen  8080;
                proxy_pass      scoreboard2.local:80;
        }
}

http {
        server {
                listen 5000;
                location /live {
                        add_header Content-Type text/plain;
                        return 200 'scoreboard1.local';
                }
                location /staging {
                        add_header Content-Type text/plain;
                        return 200 'scoreboard2.local';

                }
        }
}
EOF

cat > scoreboard.conf.toggle << EOF
stream {
        server {
                listen  80;
                proxy_pass      scoreboard2.local:80;
        }

        server {
                listen  8080;
                proxy_pass      scoreboard1.local:80;
        }
}

http {
        server {
                listen 5000;
                location /live {
                        add_header Content-Type text/plain;
                        return 200 'scoreboard2.local';
                }
                location /staging {
                        add_header Content-Type text/plain;
                        return 200 'scoreboard1.local';

                }
        }
}
EOF

sudo mv ./scoreboard.conf /etc/nginx/conf.d/
sudo mv ./scoreboard.conf.toggle /etc/nginx/conf.d/

mkdir -p /home/pi/.config/lxsession/LXDE-pi/
echo "/home/pi/run-proxy.sh" >> /home/pi/.config/lxsession/LXDE-pi/autostart

sudo reboot
