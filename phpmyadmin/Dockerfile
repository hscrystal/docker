FROM centos:6.7
MAINTAINER Husen Malee

###############install package###############
RUN yum -y install epel-release
RUN yum -y update; yum clean all
RUN yum -y install vim supervisor httpd mysql phpmyadmin php php-mysql php-mysqli php-mbstring php-mcrypt php-devel php-gd php-xml; yum clean all
RUN mkdir -p /var/lock/httpd /var/run/httpd /var/log/supervisor

#################ADD Config##################
ADD phpmyadmin_default /etc/httpd/conf.d/phpMyAdmin.conf
ADD config.inc.php /etc/phpMyAdmin/config.inc.php
ADD httpd.conf /etc/httpd/conf/httpd.conf
ADD my.cnf /etc/my.cnf
ADD start-httpd.sh /start-httpd.sh
ADD supervisord-httpd.conf /etc/supervisord.conf
#ADD run.sh /run.sh
RUN chmod 600 /etc/supervisord.conf
RUN chmod 755 /start-httpd.sh
#RUN chmod 755 /run.sh

#####################End#####################
ENV PHP_UPLOAD_MAX_FILESIZE=64M \
    PHP_MAX_INPUT_VARS=2000
EXPOSE 80
CMD ["/usr/bin/supervisord"]
