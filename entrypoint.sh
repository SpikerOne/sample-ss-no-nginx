#!/bin/bash

mkdir /v2raybin
cd /v2raybin
V2RAY_URL="https://github.com/shadowsocks/v2ray-plugin/releases/download/v1.3.2/v2ray-plugin-linux-amd64-v1.3.2.tar.gz"
echo ${V2RAY_URL}
wget --no-check-certificate ${V2RAY_URL}
tar -zxvf v2ray-plugin-linux-amd64-v1.3.2.tar.gz
rm -rf v2ray-plugin-linux-amd64-v1.3.2.tar.gz
mv v2ray-plugin_linux_amd64 /usr/bin/v2ray-plugin
rm -rf /v2raybin

cd /wwwroot
tar xvf wwwroot.tar.gz
rm -rf wwwroot.tar.gz

mv /conf/nginx_ss.conf /etc/nginx/conf.d/ss.conf
mv /conf/shadowsocks-libev_config.json /etc/shadowsocks-libev/config.json

cat /etc/shadowsocks-libev/config.json

ss-server -s 0.0.0.0 -p 443 -k password --plugin "v2ray-plugin" --plugin-opts "server;path=/v2ray" --no-delay --fast-open --reuse-port
