#!/bin/bash
# http://www.d1sm.net/thread-8-1-1.html
# http://fs.d1sm.net/finalspeed/finalspeed_client1.0.zip
# tail -f /fs/server.log

rm -f install_fs.sh
wget http://fs.d1sm.net/finalspeed/install_fs.sh
chmod +x install_fs.sh
./install_fs.sh 2>&1 | tee install.log

service iptables start
iptables -I INPUT -p tcp --dport 8080 -j ACCEPT
iptables -I OUTPUT -p tcp --sport 8080 -j ACCEPT
iptables -I INPUT -p tcp --dport 666 -j ACCEPT
iptables -I OUTPUT -p tcp --sport 666 -j ACCEPT
iptables -I INPUT -p tcp --dport 999 -j ACCEPT
iptables -I OUTPUT -p tcp --sport 999 -j ACCEPT
service iptables save
