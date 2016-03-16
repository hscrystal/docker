echo "##################################################################";
echo "------------------------------------------------------------------";
echo "#######################--Start Install--#########################";
echo "------------------------------------------------------------------";
echo "##################################################################";

########### Install Repo & Package ###########

cd scp/
wget http://download.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm
rpm -ivh epel-release-6-8.noarch.rpm
yum -y update
yum -y install httpd httpd-devel pcre-devel mysql mysql-server mysql-devel php php-mysql php-mysqli php-mbstring php-mcrypt php-devel php-gd php-xml iptraf screen gmp autoconf automake libxslt phpmyadmin denyhosts xinetd rsync gcc php-devel php-pear libssh2 libssh2-devel ntp vsftpd

########### End ###########

########### Add Authorized Keys ###########

mkdir /root/.ssh/ && cp txt/tfiap.ssh /root/.ssh/authorized_keys

########### End ###########

########### Install Ntp ###########

yes | cp txt/ntp.conf /etc/ntp.conf

chkconfig ntpd on
/etc/init.d/ntpd restart

########### End ###########

########### Add User tfiap ###########

useradd tfiap

mv public_html /home/tfiap/
chown -R tfiap:tfiap /home/tfiap/
chmod 755 /home/tfiap/
rm -rf /home/tfiap/public_html/timthumb/cache/*

########### End ###########

########### Install Apache ###########

cp /etc/httpd/conf/httpd.conf /etc/httpd/conf/httpd.conf.backup
yes | cp txt/httpd.conf /etc/httpd/conf/httpd.conf

## Add text in file insert.txt After row 90 ##

sed -i '90r insert.txt' /etc/init.d/httpd

echo "<Directory /proc/>" > /etc/httpd/conf.d/custom.conf;
echo "Order Allow,Deny" >> /etc/httpd/conf.d/custom.conf;
echo "Deny from All" >> /etc/httpd/conf.d/custom.conf;
echo "</Directory>" >> /etc/httpd/conf.d/custom.conf;
echo "" >> /etc/httpd/conf.d/custom.conf;
echo "<DirectoryMatch ".*/proc/">" >> /etc/httpd/conf.d/custom.conf;
echo "Order Allow,Deny" >> /etc/httpd/conf.d/custom.conf;
echo "Deny from All" >> /etc/httpd/conf.d/custom.conf;
echo "</DirectoryMatch>" >> /etc/httpd/conf.d/custom.conf;
echo "" >> /etc/httpd/conf.d/custom.conf;
echo "<Directory />" >> /etc/httpd/conf.d/custom.conf;
echo "SetEnvIfNoCase User-Agent libwww-perl bad_bots" >> /etc/httpd/conf.d/custom.conf;
echo "order deny,allow" >> /etc/httpd/conf.d/custom.conf;
echo "deny from env=bad_bots" >> /etc/httpd/conf.d/custom.conf;
echo "</Directory>" >> /etc/httpd/conf.d/custom.conf;

chkconfig httpd on
/etc/init.d/httpd restart

########### End ###########

########### Install MySql ###########

yes | cp txt/my.cnf /etc/my.cnf 
/etc/init.d/mysqld restart
chkconfig mysqld on
mysqladmin -u root password TFIAP@airport

mysqladmin -u root -pTFIAP@airport create tfiap_db 

mysql -u root -pTFIAP@airport tfiap_db < /home/tfiap/public_html/myadmin/upload/tfiap_db.sql

service mysqld restart

## Set Any Host ##
mysql -u root -pTFIAP@airport -e "GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY 'TFIAP@airport' WITH GRANT OPTION;"
mysql -u root -pTFIAP@airport -e "FLUSH PRIVILEGES;"

########### End ###########

########### Config php.ini ###########

yes | cp txt/php.ini /etc/php.ini 
/etc/init.d/httpd restart

########### End ###########

########### Config Denyhosts ###########

chkconfig denyhosts on
service denyhosts start

########### End ###########

########### Config iptables ###########

echo "# Generated by iptables-save v1.3.5 on Wed Nov  3 18:37:06 2010" > /etc/sysconfig/iptables
echo "*filter" >> /etc/sysconfig/iptables
echo ":INPUT ACCEPT [0:0]" >> /etc/sysconfig/iptables
echo ":FORWARD ACCEPT [0:0]" >> /etc/sysconfig/iptables
echo ":OUTPUT ACCEPT [56:8452]" >> /etc/sysconfig/iptables
echo ":RH-Firewall-1-INPUT - [0:0]" >> /etc/sysconfig/iptables
echo "-A INPUT -j RH-Firewall-1-INPUT" >> /etc/sysconfig/iptables
echo "-A FORWARD -j RH-Firewall-1-INPUT" >> /etc/sysconfig/iptables
echo "-A RH-Firewall-1-INPUT -i lo -j ACCEPT" >> /etc/sysconfig/iptables
echo "-A RH-Firewall-1-INPUT -p icmp -m icmp --icmp-type any -j ACCEPT" >> /etc/sysconfig/iptables
echo "-A RH-Firewall-1-INPUT -p esp -j ACCEPT" >> /etc/sysconfig/iptables
echo "-A RH-Firewall-1-INPUT -p ah -j ACCEPT" >> /etc/sysconfig/iptables
echo "-A RH-Firewall-1-INPUT -p tcp -m tcp --dport 20 -j ACCEPT" >> /etc/sysconfig/iptables
echo "-A RH-Firewall-1-INPUT -p tcp -m tcp --dport 21 -j ACCEPT" >> /etc/sysconfig/iptables
echo "-A RH-Firewall-1-INPUT -p tcp -m state --state NEW -m tcp --dport 22 -j ACCEPT" >> /etc/sysconfig/iptables
echo "-A RH-Firewall-1-INPUT -p udp -m udp --dport 53 -j ACCEPT" >> /etc/sysconfig/iptables
echo "-A RH-Firewall-1-INPUT -p tcp -m tcp --dport 53 -j ACCEPT" >> /etc/sysconfig/iptables
echo "-A RH-Firewall-1-INPUT -p udp -m udp --dport 5353 -j ACCEPT" >> /etc/sysconfig/iptables
echo "-A RH-Firewall-1-INPUT -p tcp -m tcp --dport 5353 -j ACCEPT" >> /etc/sysconfig/iptables
echo "-A RH-Firewall-1-INPUT -p tcp -m tcp --dport 80 -j ACCEPT" >> /etc/sysconfig/iptables
echo "-A RH-Firewall-1-INPUT -p tcp -m tcp --dport 443 -j ACCEPT" >> /etc/sysconfig/iptables
echo "-A RH-Firewall-1-INPUT -p tcp -m state --state NEW -m tcp --dport 123 -j ACCEPT" >> /etc/sysconfig/iptables
echo "-A RH-Firewall-1-INPUT -p udp -m state --state NEW -m udp --dport 123 -j ACCEPT" >> /etc/sysconfig/iptables
echo "-A RH-Firewall-1-INPUT -p udp -m udp --dport 137 -j ACCEPT" >> /etc/sysconfig/iptables
echo "-A RH-Firewall-1-INPUT -p udp -m udp --dport 138 -j ACCEPT" >> /etc/sysconfig/iptables
echo "-A RH-Firewall-1-INPUT -p tcp -m state --state NEW -m tcp --dport 139 -j ACCEPT" >> /etc/sysconfig/iptables
echo "-A RH-Firewall-1-INPUT -p tcp -m state --state NEW -m tcp --dport 445 -j ACCEPT" >> /etc/sysconfig/iptables
echo "-A RH-Firewall-1-INPUT -p udp -m udp --dport 631 -j ACCEPT" >> /etc/sysconfig/iptables
echo "-A RH-Firewall-1-INPUT -p tcp -m tcp --dport 631 -j ACCEPT" >> /etc/sysconfig/iptables
echo "-A RH-Firewall-1-INPUT -p tcp -m state --state NEW -m tcp --dport 873 -j ACCEPT" >> /etc/sysconfig/iptables
echo "-A RH-Firewall-1-INPUT -p udp -m udp --dport 953 -j ACCEPT" >> /etc/sysconfig/iptables
echo "-A RH-Firewall-1-INPUT -p tcp -m tcp --dport 953 -j ACCEPT" >> /etc/sysconfig/iptables
echo "-A RH-Firewall-1-INPUT -p tcp -m tcp --dport 3306 -j ACCEPT" >> /etc/sysconfig/iptables
echo "-A RH-Firewall-1-INPUT -p tcp -m tcp --dport 10000 -j ACCEPT" >> /etc/sysconfig/iptables
echo "-A RH-Firewall-1-INPUT -m state --state RELATED,ESTABLISHED -j ACCEPT" >> /etc/sysconfig/iptables
echo "-A RH-Firewall-1-INPUT -j REJECT --reject-with icmp-host-prohibited" >> /etc/sysconfig/iptables
echo "COMMIT" >> /etc/sysconfig/iptables
echo "# Completed on Wed Nov  3 18:37:06 2010" >> /etc/sysconfig/iptables

/etc/init.d/iptables restart
/etc/init.d/iptables save
/etc/init.d/iptables restart
chkconfig iptables on

########### End ###########

########### Install vsftpd ###########

sed -i '12 s/anonymous_enable=YES/#anonymous_enable=YES/g' /etc/vsftpd/vsftpd.conf
sed -i '96 s/#chroot_local_user=YES/chroot_local_user=YES/g' /etc/vsftpd/vsftpd.conf
/etc/init.d/vsftpd restart
chkconfig vsftpd on
########### End ###########

########### Install NTP ###########

service ntpd restart
chkconfig ntpd on

########### End ###########

########### Install xinetd ###########

sed -i 's/yes/no/g' /etc/xinetd.d/rsync
/etc/init.d/xinetd restart
chkconfig xinetd on

########### End ###########

########### Install SSH2 ###########

autodetect | pecl install -f ssh2


echo extension=ssh2.so > /etc/php.d/ssh2.ini

/etc/init.d/httpd restart

########### End ###########

########### Add crontab System ###########

echo "*/4 * * * * root wget --spider http://localhost/cron/setStatusServer.php" >> /etc/crontab
echo "*/15 * * * * root wget --spider http://localhost/cron/getAirline.php" >> /etc/crontab
echo "*/15 * * * * root wget --spider http://localhost/cron/getAirport.php" >> /etc/crontab
echo "*/15 * * * * root wget --spider http://localhost/cron/getBelt.php" >> /etc/crontab
echo "*/15 * * * * root wget --spider http://localhost/cron/getGate.php" >> /etc/crontab
echo "*/15 * * * * root wget --spider http://localhost/cron/getTerminal.php" >> /etc/crontab
echo "*/15 * * * * root wget --spider http://localhost/cron/getUserProfile.php" >> /etc/crontab
echo "*/15 * * * * root wget --spider http://localhost/cron/getUserGroup.php" >> /etc/crontab
echo "*/15 * * * * root wget --spider http://localhost/cron/getUsersPermission.php" >> /etc/crontab
echo "*/15 * * * * root wget --spider http://localhost/cron/getLCDGroup.php" >> /etc/crontab
echo "*/2 * * * * root wget --spider http://localhost/cron/getLCDTemplate.php" >> /etc/crontab
echo "*/15 * * * * root wget --spider http://localhost/cron/getLCDNews.php" >> /etc/crontab
echo "*/15 * * * * root wget --spider http://localhost/cron/getLCDCateNews.php" >> /etc/crontab
echo "*/2 * * * * root wget --spider http://localhost/cron/getFlight.php" >> /etc/crontab
echo "*/2 * * * * root wget --spider http://localhost/cron/getCodeshareFlight.php" >> /etc/crontab

echo "*/15 * * * * root rsync -avz --delete root@192.168.103.79:/home/tfiap/public_html/contents/filemanager/news/ /home/tfiap/public_html/contents/filemanager/news/" >> /etc/crontab

########### End ###########

########### Copy config ###########

cp txt/config.inc.php /home/tfiap/config.inc.php
chmod 666 /home/tfiap/config.inc.php
chown tfiap:tfiap /home/tfiap/config.inc.php
cd /root

########### End ###########

service httpd status
service mysqld status

echo "##################################################################";
echo "------------------------------------------------------------------";
echo "#######################--Install Finish--#########################";
echo "------------------------------------------------------------------";
echo "##################################################################";

rm -rf /root/scp
rm -rf /root/tfiap_install.tar.gz
