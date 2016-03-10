```
cd ~;mkdir github conf /keys /www /dload 下载;
yum install git vim tmux wget -y;
yum install -y vixie-cron;
cd github;git clone https://github.com/weaming/vimrc;cd vimrc;sh install.sh;. ~/.bashrc;vim;

# kvm?
dload
wget http://people.redhat.com/~rjones/virt-what/files/virt-what-1.15.tar.gz
tar zxvf virt-what-1.15.tar.gz
cd virt-what-1.15/
./configure
make && make install
virt-what

# shadowsocks
dload;
wget --no-check-certificate https://raw.githubusercontent.com/teddysun/shadowsocks_install/master/shadowsocks.sh
chmod +x shadowsocks.sh
./shadowsocks.sh 2>&1 | tee shadowsocks.log
ln -s /etc/init.d/shadowsocks /usr/local/bin/shadowsocks;
ln -s /etc/shadowsocks.json /root/conf/ss.json;

wget --no-check-certificate https://gist.githubusercontent.com/LazyZhu/dc3f2f84c336a08fd6a5/raw/d8aa4bcf955409e28a262ccf52921a65fe49da99/net_speeder_lazyinstall.sh
sh net_speeder_lazyinstall.sh
nohup /usr/local/net_speeder/net_speeder eth0 "ip" >/dev/null 2>&1 &

#supervisor
pip install supervisor;supervisord;
echo_supervisord_conf > /etc/supervisord.conf;
ln -s /etc/supervisord.conf ~/conf/supervisord.conf;

#tmux
wget -c http://soft.vpser.net/lnmp/lnmp1.2-full.tar.gz && tar zxf lnmp1.2-full.tar.gz && cd lnmp1.2-full && ./install.sh lnmp

#www
cd /www/;
#wget https://github.com/gogits/gogs/releases/download/v0.8.43/linux_386.tar.gz;
wget https://github.com/gogits/gogs/releases/download/v0.8.43/linux_amd64.tar.gz
#wget https://github.com/spf13/hugo/releases/download/v0.15/hugo_0.15_linux_386.tar.gz
wget https://github.com/spf13/hugo/releases/download/v0.15/hugo_0.15_linux_amd64.tar.gz

#shell
echo "alias www='cd /www/'" >> ~/.bashrc;
echo "alias conf='cd /root/conf'" >> ~/.bashrc;
echo "alias www='cd /www'" >> ~/.bashrc;
echo "alias upblog='cd /www/blogger;git pull;hugo;cd -'" >> ~/.bashrc;
echo "alias svr='supervisorctl reload'" >> ~/.bashrc;
echo "alias svs='supervisorctl status'" >> ~/.bashrc;

#githhub
cd ~/github/
git clone https://github.com/weaming/inav;
git clone https://github.com/weaming/idocs;
git clone https://weaming:tianxu28@bitbucket.org/weaming/iwechat.git
git clone https://weaming:tianxu28@bitbucket.org/weaming/api.git

#rss
cd /www/
wget https://tt-rss.org/gitlab/fox/tt-rss/repository/archive.zip
unzip archive.zip && sudo rm -f archive.zip
mv tt-rss* ttrss
cd ttrss/themes/
wget https://github.com/levito/tt-rss-feedly-theme/archive/master.zip;unzip master.zip;rm -f master.zip;cd tt-rss-feedly-theme-master;
rm -rf README.md feedly-screenshots/;mv * ../;cd ..;rm -rf tt-rss-feedly-theme-master/;
cd /www/;chmod 755 -R *;chown www:www -R *;
```
