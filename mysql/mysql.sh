#!/bin/bash

chown -R mysql:mysql /var/lib/mysql
mysql_install_db --user mysql > /dev/null
mysqld_safe --user mysql &
sleep 5s
mysqladmin -u root password TFIAP@airport
mysqladmin -u root -pTFIAP@airport create tfiap_db
mysql -u root -pTFIAP@airport tfiap_db < /upload/tfiap_db.sql
sleep 5s
ps -wef | grep mysql | grep -v grep | awk '{print $2}' | xargs kill -9
mysqld_safe --user mysql
