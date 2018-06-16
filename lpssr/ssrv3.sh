#!/bin/bash
#此脚本为修改版
#版权为：https://github.com/mmmwhy/ss-panel-and-ss-py-mu
#原版bug甚多 已经优化与修复
#最新更新7.12
#更新修复自启问题 兼容7.x系统
[ $(id -u) != "0" ] && { echo "错误：你必须使用root用户登录"; exit 1; }
install_ss_panel_mod_v3(){
	yum -y remove httpd
	yum install -y unzip zip
    wget --no-check-certificate https://git.oschina.net/marisn/ssr_v3/raw/master/lnmp1.3.zip && unzip lnmp1.3.zip && cd lnmp1.3 && chmod +x install.sh && ./install.sh 
	lnmp	
	cd /home/wwwroot/default/
	yum install git -y
	rm -rf index.html
	wget --no-check-certificate https://marisn-1252874932.file.myqcloud.com/ss.panel_mod.zip && unzip ss.panel_mod.zip
	chattr -i .user.ini
	mv .user.ini public
	chown -R root:root *
	chmod -R 777 *
	chown -R www:www storage
	chattr +i public/.user.ini
	wget -N -P  /usr/local/nginx/conf/ http://home.ustc.edu.cn/~mmmwhy/nginx.conf 
	wget -N -P /home/wwwroot/default/sql/ http://git.oschina.net/marisn/ssr_v3/raw/master/all.sql
	service nginx restart
	yum install perl-DBI freeradius freeradius-mysql freeradius-utils -y
	mysql -uroot -proot -e"CREATE USER 'radius'@'%' IDENTIFIED BY 'root';" 
	mysql -uroot -proot -e"GRANT ALL ON *.* TO 'radius'@'%';" 
	mysql -uroot -proot -e"create database radius;" 
	mysql -uroot -proot -e"use radius;" 
	mysql -uroot -proot radius < /home/wwwroot/default/sql/all.sql
	mysql -uroot -proot -e"CREATE USER 'ss-panel-radius'@'%' IDENTIFIED BY 'root';" 
	mysql -uroot -proot -e"GRANT ALL ON *.* TO 'ss-panel-radius'@'%';" 
	mysql -uroot -proot -e"CREATE USER 'sspanel'@'%' IDENTIFIED BY 'root';" 
	mysql -uroot -proot -e"GRANT ALL ON *.* TO 'sspanel'@'%';" 
	mysql -uroot -proot -e"create database sspanel;" 
	mysql -uroot -proot -e"use sspanel;" 
	mysql -uroot -proot sspanel < /home/wwwroot/default/sql/sspanel.sql
	\cp /home/wwwroot/default/sql/sql.conf /etc/raddb/sql.conf
	wget http://git.oschina.net/marisn/ssr_v3/raw/master/radiusd.conf -O /etc/raddb/radiusd.conf
	wget http://git.oschina.net/marisn/ssr_v3/raw/master/default -O /etc/raddb/sites-enabled/default
	wget http://git.oschina.net/marisn/ssr_v3/raw/master/dialup.conf -O /etc/raddb/sql/mysql/dialup.conf
	wget http://git.oschina.net/marisn/ssr_v3/raw/master/dictionary -O /etc/raddb/dictionary
	wget http://git.oschina.net/marisn/ssr_v3/raw/master/counter.conf -O /etc/raddb/sql/mysql/counter.conf
	service radiusd start && chkconfig radiusd on
	cd /home/wwwroot/default
	php composer.phar install
	yum -y install vixie-cron crontabs
	rm -rf /var/spool/cron/root
	echo 'SHELL=/bin/bash' >> /var/spool/cron/root
	echo 'PATH=/sbin:/bin:/usr/sbin:/usr/bin' >> /var/spool/cron/root
	echo "30 22 * * * php /home/wwwroot/default/xcat sendDiaryMail" >> /var/spool/cron/root
	echo "*/1 * * * * php /home/wwwroot/default/xcat synclogin" >> /var/spool/cron/root
	echo "*/1 * * * * php /home/wwwroot/default/xcat syncvpn" >> /var/spool/cron/root
	echo "0 0 * * * php -n /home/wwwroot/default/xcat dailyjob" >> /var/spool/cron/root
	echo "*/1 * * * * php /home/wwwroot/default/xcat checkjob" >> /var/spool/cron/root
	echo "*/1 * * * * php -n /home/wwwroot/default/xcat syncnas" >> /var/spool/cron/root
	service crond restart
	IPAddress=`wget http://members.3322.org/dyndns/getip -O - -q ; echo`;
	echo -e "\033[31m#############################################################\033[0m"
	echo -e "\033[32m# 一键搭建成功，登录http://${IPAddress}看看吧~              #\033[0m"
	echo -e "\033[33m# 欢迎使用一键SS-panel v3 mod魔改版                         #\033[0m"
	echo -e "\033[34m# Author: Feiyang.li & 修改 by：marisn                      #\033[0m"
	echo -e "\033[35m# Blog: http://blog.67cc.cn/                                #\033[0m"
	echo -e "\033[31m#############################################################\033[0m"
}
install_centos_ssr(){
	yum -y update
	yum -y install git 
	yum -y install python-setuptools && easy_install pip 
	yum -y groupinstall "Development Tools" 
	#512M的小鸡增加1G的Swap分区
	dd if=/dev/zero of=/var/swap bs=1024 count=1048576
	mkswap /var/swap
	chmod 0644 /var/swap
	swapon /var/swap
	echo '/var/swap   swap   swap   default 0 0' >> /etc/fstab
	wget https://github.com/jedisct1/libsodium/releases/download/1.0.13/libsodium-1.0.13.tar.gz
	tar xf libsodium-1.0.13.tar.gz && cd libsodium-1.0.13
	./configure && make -j2 && make install
	echo /usr/local/lib > /etc/ld.so.conf.d/usr_local_lib.conf
	ldconfig
	yum -y install python-setuptools
	easy_install supervisor
	#clone shadowsocks
	cd /root
	git clone -b manyuser https://git.oschina.net/marisn/shadowsocks.git "/root/shadowsocks"
	#install devel
	cd /root/shadowsocks
	yum -y install lsof lrzsz
	yum -y install python-devel
	yum -y install libffi-devel
	yum -y install openssl-devel
	pip install -r requirements.txt
	cp apiconfig.py userapiconfig.py
	cp config.json user-config.json
	#iptables
	iptables -I INPUT -p tcp -m tcp --dport 104 -j ACCEPT
	iptables -I INPUT -p udp -m udp --dport 104 -j ACCEPT
	iptables -I INPUT -p tcp -m tcp --dport 1024: -j ACCEPT
	iptables -I INPUT -p udp -m udp --dport 1024: -j ACCEPT
	iptables-save >/etc/sysconfig/iptables
}
install_ubuntu_ssr(){
	apt-get update -y
	apt-get install supervisor lsof -y
	apt-get install build-essential wget -y
	apt-get install iptables git -y
	wget https://github.com/jedisct1/libsodium/releases/download/1.0.13/libsodium-1.0.13.tar.gz
	tar xf libsodium-1.0.13.tar.gz && cd libsodium-1.0.13
	./configure && make -j2 && make install
	echo /usr/local/lib > /etc/ld.so.conf.d/usr_local_lib.conf
	ldconfig
	apt-get install python-pip git -y
	pip install cymysql
	cd /root
	git clone -b manyuser https://git.oschina.net/marisn/shadowsocks.git "/root/shadowsocks"
	cd shadowsocks
	pip install -r requirements.txt
	chmod +x *.sh
	# 配置程序
	cp apiconfig.py userapiconfig.py
	cp config.json user-config.json
	#iptables
	iptables -I INPUT -p tcp -m tcp --dport 104 -j ACCEPT
	iptables -I INPUT -p udp -m udp --dport 104 -j ACCEPT
	iptables -I INPUT -p tcp -m tcp --dport 1024: -j ACCEPT
	iptables -I INPUT -p udp -m udp --dport 1024: -j ACCEPT
	iptables-save >/etc/sysconfig/iptables
}
install_node(){
	clear
	echo
    echo -e "\033[31m#############################################################\033[0m"
    echo -e "\033[32m# 一键添加SS-panel v3 节点                                  #\033[0m"
    echo -e "\033[33m#                                                           #\033[0m"
    echo -e "\033[34m# Author: 91VPS.CLUB & 修改 by：marisn                      #\033[0m"
    echo -e "\033[35m#                                                           #\033[0m"
    echo -e "\033[31m#############################################################\033[0m"
	echo
	#Check Root
	[ $(id -u) != "0" ] && { echo "错误：你必须使用root用户登录"; exit 1; }
	#check OS version
	check_sys(){
		if [[ -f /etc/redhat-release ]]; then
			release="centos"
		elif cat /etc/issue | grep -q -E -i "debian"; then
			release="debian"
		elif cat /etc/issue | grep -q -E -i "ubuntu"; then
			release="ubuntu"
		elif cat /etc/issue | grep -q -E -i "centos|red hat|redhat"; then
			release="centos"
		elif cat /proc/version | grep -q -E -i "debian"; then
			release="debian"
		elif cat /proc/version | grep -q -E -i "ubuntu"; then
			release="ubuntu"
		elif cat /proc/version | grep -q -E -i "centos|red hat|redhat"; then
			release="centos"
	    fi
		bit=`uname -m`
	}
	install_ssr_for_each(){
		check_sys
		if [[ ${release} = "centos" ]]; then
			install_centos_ssr
		else
			install_ubuntu_ssr
		fi
	}
	# 取消文件数量限制
	sed -i '$a * hard nofile 512000\n* soft nofile 512000' /etc/security/limits.conf
	[ $(id -u) != "0" ] && { echo "错误：你必须使用root用户登录"; exit 1; }
	read -p "请输入你的域名(请加上http:// 如果是本机请直接回车): " Userdomain
	read -p "请输入muKey(在你的配置文件中 如果是本机请直接回车):" Usermukey
	read -p "请输入你的节点编号(非常重要，必须填):  " UserNODE_ID
	install_ssr_for_each
	IPAddress=`wget http://members.3322.org/dyndns/getip -O - -q ; echo`;
	cd /root/shadowsocks
	echo -e "modify Config.py...\n"
	Userdomain=${Userdomain:-"http://${IPAddress}"}
	sed -i "s#https://zhaoj.in#${Userdomain}#" /root/shadowsocks/userapiconfig.py
	Usermukey=${Usermukey:-"mupass"}
	sed -i "s#glzjin#${Usermukey}#" /root/shadowsocks/userapiconfig.py
	UserNODE_ID=${UserNODE_ID:-"3"}
	sed -i '2d' /root/shadowsocks/userapiconfig.py
	sed -i "2a\NODE_ID = ${UserNODE_ID}" /root/shadowsocks/userapiconfig.py
	# 启用supervisord
	echo_supervisord_conf > /etc/supervisord.conf
  sed -i '$a [program:ssr]\ncommand = python /root/shadowsocks/server.py\nuser = root\nautostart = true\nautorestart = true' /etc/supervisord.conf
	supervisord
	echo 'iptables-restore /etc/sysconfig/iptables' >> /etc/rc.local
	echo "/usr/bin/supervisord -c /etc/supervisord.conf" >> /etc/rc.local
	chmod +x /etc/rc.d/rc.local
	echo -e "\033[31m#############################################################\033[0m"
	echo -e "\033[33m# 节点添加成功，登录前端站点看看吧                          #\033[0m"
	echo -e "\033[34m#                                                           #\033[0m"
	echo -e "\033[35m# Author: Feiyang.li      & 修改 By：marisn                 #\033[0m"
	echo -e "\033[36m#                                                           #\033[0m"
	echo -e "\033[31m#############################################################\033[0m"
	reboot now
}
install_BBR(){
     wget --no-check-certificate https://github.com/teddysun/across/raw/master/bbr.sh&&chmod +x bbr.sh&&./bbr.sh
}
install_RS(){
     wget -N --no-check-certificate https://github.com/91yun/serverspeeder/raw/master/serverspeeder.sh && bash serverspeeder.sh
}
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
export PATH
ulimit -c 0
rm -rf ssr*
clear
echo
echo -e "脚本已由阿里云/腾讯云等正规vps测试通过";
echo
pass='blog.67cc.cn';
echo -e "请输入Marisn'blog地址:[\033[32m $pass \033[0m] "
read inputPass
if [ "$inputPass" != "$pass" ];then
    #网址验证
     echo -e "\033[31m很抱歉,输入错误\033[0m";
     exit 1;
fi;
echo
echo -e "\033[31m#############################################################\033[0m"
echo -e "\033[32m#欢迎使用一键SS-panel V3_mod_panel搭建脚本 and 节点添加     #\033[0m"
echo -e "\033[33m#Author: 91VPS.club     &        修改 by：marisn            #\033[0m"
echo -e "\033[34m#Blog: http://blog.67cc.cn/                                 #\033[0m"
echo -e "\033[35m#请选择你要搭建的脚本：                                     #\033[0m"
echo -e "\033[36m#1.  一键SS-panel V3_mod_panel搭建                          #\033[0m"
echo -e "\033[37m#2.  一键添加SS-panel节点                                   #\033[0m"
echo -e "\033[36m#3.  一键  BBR加速  搭建                                    #\033[0m"
echo -e "\033[35m#4.  一键锐速破解版搭建                                     #\033[0m"
echo -e "\033[34m#                              PS:建议先搭建加速再搭建SSR-V3#\033[0m"
echo -e "\033[33m#                                   已兼容Centos 6.x 7.x系统#\033[0m"
echo -e "\033[31m#############################################################\033[0m"
echo
stty erase '^H' && read -p " 请输入数字 [1-4]:" num
case "$num" in
	1)
	install_ss_panel_mod_v3
	;;
	2)
	install_node
	;;
	3)
	install_BBR
	;;
	4)
	install_RS
	;;
	*)
	echo "请输入正确数字 [1-4]"
	;;
esac
