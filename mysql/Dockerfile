FROM centos:6.7
MAINTAINER Husen Malee

###############install package###############
RUN yum -y install epel-release
RUN yum -y update; yum clean all
RUN yum -y install mysql-server; yum clean all

###############ADD Config################
ADD upload /upload/
ADD my.cnf /etc/my.cnf
ADD mysql.sh /root/mysql.sh

RUN chmod +x /root/mysql.sh
EXPOSE 3306
CMD ["/root/mysql.sh"]
