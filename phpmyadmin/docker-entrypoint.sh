#!/bin/bash
if [ -z "$HOST" ]; then
  echo >&2 'error: database is uninitialized and HOST option is not specified '
	exit 1
fi
# if [ -z "$MYSQL_PASSWORD" ]; then
#   echo >&2 'error: database is uninitialized and password option is not specified '
# 	exit 1
# fi
# if [ -z "$MYSQL_LINK" ]; then
#   echo >&2 'error: database is uninitialized and link option is not specified '
# 	exit 1
# fi
