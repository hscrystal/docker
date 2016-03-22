FROM centos:6.7
MAINTAINER Husen Malee

###############install package###############
RUN yum -y install epel-release
RUN yum -y update; yum clean all
RUN yum -y install httpd  mysql phpmyadmin php php-mysql php-mysqli php-mbstring php-mcrypt php-devel php-gd php-xml; yum clean all

#################ADD Config##################

#####################End#####################
EXPOSE 3306
CMD ["/root/mysql.sh"]
