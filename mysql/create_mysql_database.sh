#!/bin/bash

chown -R mysql:mysql /var/lib/mysql
mysqladmin -u root password TFIAP@airport
mysqladmin -u root -pTFIAP@airport create tfiap_db
mysql -u root -pTFIAP@airport tfiap_db < /upload/tfiap_db.sql
mysql -u root -pTFIAP@airport -e "GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY 'TFIAP@airport' WITH GRANT OPTION;"
mysql -u root -pTFIAP@airport -e "FLUSH PRIVILEGES;"
sleep 5s
