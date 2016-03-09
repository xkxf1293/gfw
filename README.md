番茄记录

1 setup
```
# shadowsocks
wget --no-check-certificate https://raw.githubusercontent.com/teddysun/shadowsocks_install/master/shadowsocks.sh
chmod +x shadowsocks.sh
./shadowsocks.sh 2>&1 | tee shadowsocks.log
```
```
# netspeeder on debian
wget --no-check-certificate https://raw.githubusercontent.com/tennfy/debian_netspeeder_tennfy/master/debian_netspeeder_tennfy.sh
chmod a+x debian_netspeeder_tennfy.sh
bash debian_netspeeder_tennfy.sh

echo "Asia/Shanghai" >/etc/timezone
echo '0 4 * * * root nohup /root/net_speeder venet0 "ip" >/dev/null 2>&1 &' >>/etc/crontab
echo "0 3 * * * root killall net_speeder" >>/etc/crontab
/etc/init.d/cron restart
```

# 查看虚拟技术

```
wget http://people.redhat.com/~rjones/virt-what/files/virt-what-1.15.tar.gz
tar zxvf virt-what-1.15.tar.gz
cd virt-what-1.15/
./configure
make && make install
```

再运行 virt-what ，脚本就会判断出当前环境所使用的虚拟技术

```
# serverSpeeder 锐速
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
- [hybla算法](https://github.com/weaming/gfw/blob/master/使用tcp_hybla算法提高国外VPS访问速度.md)
- [isetsuna 教程参考](http://www.isetsuna.com/shadowsocks/deploy-optimizer-usage/)

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
ifconfig #查看网卡
nohup /root/net_speeder venet0 "ip" >/dev/null 2>&1 &   # net_speeder要根据具体网卡和架构来运行
```

-------

# net-speeder
[net-speeder](https://github.com/snooda/net-speeder) 在高延迟不稳定链路上优化单线程下载速度 

项目由https://code.google.com/p/net-speeder/  迁入

A program to speed up single thread download upon long delay and unstable network

在高延迟不稳定链路上优化单线程下载速度

注1：开启了net-speeder的服务器上对外ping时看到的是4倍，实际网络上是2倍流量。另外两倍是内部dup出来的，不占用带宽。另外，内部dup包并非是偷懒未判断。。。是为了更快触发快速重传的。
注2：net-speeder不依赖ttl的大小，ttl的大小跟流量无比例关系。不存在windows的ttl大，发包就多的情况。

## debian/ubuntu：

运行时依赖的库：libnet， libpcap

    安装libnet：apt-get install libnet1
    安装libpcap： apt-get install libpcap0.8 

编译需要安装libnet和libpcap对应的dev包。

    安装libnet-dev：apt-get install libnet1-dev
    安装libpcap-dev： apt-get install libpcap0.8-dev 

## centos：

下载epel：https://fedoraproject.org/wiki/EPEL/zh-cn 例：CentOS6 64位：

    wget http://dl.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm

如果是centos5，则在epel/5/下。

然后安装epel：`rpm -ivh epel-release-X-Y.noarch.rpm`

然后即可使用yum安装：`yum install libnet libpcap libnet-devel libpcap-devel`

## 编译：

Linux Cooked interface使用编译（venetX，OpenVZ）： `sh build.sh -DCOOKED` 已测试

普通网卡使用编译（Xen，KVM，物理机）： `sh build.sh` 待测试

## 使用方法(需要root权限启动）：

参数：`./net_speeder 网卡名 加速规则（bpf规则）`

最简单用法： `# ./net_speeder venet0 "ip"` 加速所有ip协议数据

centOS 懒人脚本
---
```
wget --no-check-certificate https://gist.githubusercontent.com/LazyZhu/dc3f2f84c336a08fd6a5/raw/d8aa4bcf955409e28a262ccf52921a65fe49da99/net_speeder_lazyinstall.sh
sh net_speeder_lazyinstall.sh
```

Usage: `nohup /usr/local/net_speeder/net_speeder eth0 "ip" >/dev/null 2>&1 &`
