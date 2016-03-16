FROM centos:6.7
MAINTAINER Husen Malee

###############install package###############
RUN yum install -y epel-release
RUN yum install -y openssh-server httpd supervisor
RUN mkdir -p /var/lock/httpd /var/run/httpd /var/run/sshd /var/log/supervisor

################Config SSH##################
RUN echo 'root:piesoft123' | chpasswd
COPY sshkey /root/.ssh/authorized_keys

##############Restart Service###############
#COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf
ADD supervisord.conf /etc/supervisord.conf
RUN chmod 600 /etc/supervisord.conf

###########################################
EXPOSE 22 80  
CMD ["/usr/bin/supervisord"]
