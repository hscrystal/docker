FROM centos:6.7
MAINTAINER Husen Malee

###############install package###############
RUN yum -y install epel-release
RUN yum -y update; yum clean all
RUN yum -y install vim  supervisor mysql-server; yum clean all

##############ADD Database###############
ADD upload /upload/

###############ADD Config################
RUN mkdir -p /var/log/supervisor
ADD create_mysql_database.sh /create_mysql_database.sh
ADD supervisord-mysqld.conf /etc/supervisord.conf
ADD my.cnf /etc/my.cnf
ADD run.sh /run.sh
RUN chmod 755 /*.sh

EXPOSE 3306
ENTRYPOINT ["/run.sh"]
