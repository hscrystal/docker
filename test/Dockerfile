FROM ubuntu
MAINTAINER examples@docker.com

RUN apt-get update && apt-get install -y openssh-server apache2 supervisor
RUN mkdir -p /var/lock/apache2 /var/run/apache2 /var/run/sshd /var/log/supervisor

RUN echo 'root:piesoft123' | chpasswd
COPY sshkey /root/.ssh/authorized_keys
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

EXPOSE 22 80
CMD ["/usr/bin/supervisord"]
