FROM centos:6.6
MAINTAINER Husen Malee

# -----------------------------------------------------------------------------
# Setup Middle Ware Add and enable remi repo
# -----------------------------------------------------------------------------
RUN echo "nameserver 8.8.8.8" > /etc/resolv.conf
RUN echo "nameserver 8.8.4.4" > /etc/resolv.conf

################### TOOLS#####################
RUN yum install -y curl git wget unzip
ADD public_html ./public_html/
ADD txt ./txt/

########### Install Repo & Package ###########
RUN wget http://download.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm
RUN rpm -ivh epel-release-6-8.noarch.rpm
RUN yum -y update
RUN yum -y install httpd httpd-devel pcre-devel mysql mysql-server mysql-devel php php-mysql php-mysqli php-mbstring php-mcrypt php-devel php-gd php-xml iptraf screen gmp autoconf automake libxslt phpmyadmin denyhosts xinetd rsync gcc php-devel php-pear libssh2 libssh2-devel ntp vsftpd

############ Add Authorized Keys ##############
mkdir /root/.ssh/ && cp txt/tfiap.ssh /root/.ssh/authorized_keys

################# Install Ntp #################
yes | cp txt/ntp.conf /etc/ntp.conf

chkconfig ntpd on
/etc/init.d/ntpd restart







## CLEAN UP
#RUN yum install -y yum-utils
#RUN yum clean all

EXPOSE 80
# Start services
CMD ["/usr/sbin/apachectl", "-D", "FOREGROUND"]

