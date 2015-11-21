番茄记录

1 setup
```
wget --no-check-certificate https://raw.githubusercontent.com/teddysun/shadowsocks_install/master/shadowsocks.sh
chmod +x shadowsocks.sh
./shadowsocks.sh 2>&1 | tee shadowsocks.log


wget --no-check-certificate https://raw.githubusercontent.com/tennfy/debian_netspeeder_tennfy/master/debian_netspeeder_tennfy.sh
chmod a+x debian_netspeeder_tennfy.sh
bash debian_netspeeder_tennfy.sh

echo "Asia/Shanghai" >/etc/timezone
echo '0 4 * * * root nohup /root/net_speeder venet0 "ip" >/dev/null 2>&1 &' >>/etc/crontab
echo "0 3 * * * root killall net_speeder" >>/etc/crontab
/etc/init.d/cron restart


wget http://my.serverspeeder.com/d/ls/serverSpeederInstaller.tar.gz
tar xzvf serverSpeederInstaller.tar.gz
bash serverSpeederInstaller.sh

vi /serverspeeder/etc/config
advinacc="1" #高级入向加速开关；设为 1 表示开启，设为 0 表示关闭；开启此功能可以得到更好的流入方向流量加速效果；
maxmode="1" #最大传输模式；设为 1 表示开启；设为 0 表示关闭；开启后会进一步提高加速效果，但是可能会降低有效数据率。
rsc="1" #网卡接收端合并开关；设为 1 表示开启，设为 0 表示关闭；在有些较新的网卡驱动中，带有 RSC 算法的，需要打开该功能。

/serverspeeder/bin/serverSpeeder.sh reload
/serverspeeder/bin/serverSpeeder.sh stats
/serverspeeder/bin/serverSpeeder.sh help
```
[hybla算法](https://github.com/weaming/CodeCourses/blob/master/FuckGFW/使用tcp_hybla算法提高国外VPS访问速度.md)
[isetsuna](http://www.isetsuna.com/shadowsocks/deploy-optimizer-usage/)

2 /etc/shadowsocks.json
```
{
    "server":"0.0.0.0",
    "server_port":8989,
    "local_address":"127.0.0.1",
    "local_port":1080,
    "password":"yourpassword",
    "timeout":300,
    "method":"aes-256-cfb",
    "fast_open": false
}

{
    "server":"0.0.0.0",
    "local_address":"127.0.0.1",
    "local_port":1080,
    "port_password":{
         "8989":"password0",
         "9001":"password1",
         "9002":"password2",
         "9003":"password3",
         "9004":"password4"
    },
    "timeout":300,
    "method":"aes-256-cfb",
    "fast_open": false
}
```

3 manage
```
启动：/etc/init.d/shadowsocks start
停止：/etc/init.d/shadowsocks stop
重启：/etc/init.d/shadowsocks restart
状态：/etc/init.d/shadowsocks status

ps aux|grep net_speeder|grep -v grep
killall net_speeder
nohup /root/net_speeder venet0 "ip" >/dev/null 2>&1 &
```
