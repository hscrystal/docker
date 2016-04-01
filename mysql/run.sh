#!/bin/bash
service mysqld start
/create_mysql_database.sh
/usr/bin/supervisord
