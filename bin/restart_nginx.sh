#!/bin/sh

#ulimit  -n 65536
pwd=`pwd`
alias nginx=/usr/local/openresty/nginx/sbin/nginx

sed "s|__root__|$pwd|g" conf/nginx.conf  > conf/nginx.conf.running

mkdir -p tmp/logs

if [ -f tmp/logs/nginx.pid ]; then
	nginx -p `pwd`/tmp/ -c `pwd`/conf/nginx.conf.running -s stop
else
	ps ax | grep nginx | grep master | awk '{print $1}' | xargs kill  >& /dev/null
fi

nginx -p `pwd`/tmp/ -c `pwd`/conf/nginx.conf.running

