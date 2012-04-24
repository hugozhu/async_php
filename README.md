async_php
====
Test performance benefit by moving blocking I/O calls out of PHP.

DEPENDENCY
====
ngx_lua module - http://openresty.org latest stable release	
php_fpm        - http://php.net latest stable release
php_curl       - built-in
php_apc		   - pecl install apc


DUMMY BACKEND
====
	1ms latency: http://hsf1.test.cnz.alimama.com/1ms.php
	10ms latency: http://hsf1.test.cnz.alimama.com/10ms.php
	30ms latency: http://hsf1.test.cnz.alimama.com/30ms.php
	<?php
	     usleep(1000 * 30);
	     for ($i=0;$i<1000;$i++)
	        echo $i;
	
TEST
====
**启动 nginx：**   bin/restart_nginx.sh
**启动 php_fpm: ** /usr/local/sbin/php_fpm
	
RESULT
====	
**backend with 1ms latency**	
	QPS: PHP with curl - 800, async PHP - 900   

**backend with 10ms latency**	
	QPS: PHP with curl - 300, async PHP - 500  

**backend with 30ms latency**	
	QPS: PHP with curl - 150, async PHP - 300   
		
**backend with 10ms latency in detail**
	
	ab -n 1000 -c 100 http://kmaster2.sds.cnz.alimama.com/curl.php
	
	Server Software:        ngx_openresty
	Server Hostname:        kmaster2.sds.cnz.alimama.com
	Server Port:            80

	Document Path:          /curl.php
	Document Length:        2919 bytes

	Concurrency Level:      100
	Time taken for tests:   3.192 seconds
	Complete requests:      1000
	Failed requests:        0
	Write errors:           0
	Total transferred:      3067000 bytes
	HTML transferred:       2919000 bytes
	Requests per second:    313.28 [#/sec] (mean)
	Time per request:       319.206 [ms] (mean)
	Time per request:       3.192 [ms] (mean, across all concurrent requests)
	Transfer rate:          938.30 [Kbytes/sec] received

	Connection Times (ms)
	              min  mean[+/-sd] median   max
	Connect:        3    6   4.2      5      24
	Processing:    27  299  55.9    284     427
	Waiting:       27  298  56.0    284     426
	Total:         33  305  55.4    290     450

	Percentage of the requests served within a certain time (ms)
	  50%    290
	  66%    301
	  75%    354
	  80%    357
	  90%    373
	  95%    390
	  98%    419
	  99%    422
	 100%    450 (longest request)	
	
	ab -n 1000 -c 100 http://kmaster2.sds.cnz.alimama.com/lua
	 
	Server Software:        ngx_openresty
	Server Hostname:        kmaster2.sds.cnz.alimama.com
	Server Port:            80

	Document Path:          /lua
	Document Length:        3126 bytes

	Concurrency Level:      100
	Time taken for tests:   1.975 seconds
	Complete requests:      1000
	Failed requests:        0
	Write errors:           0
	Total transferred:      3272000 bytes
	HTML transferred:       3126000 bytes
	Requests per second:    506.41 [#/sec] (mean)
	Time per request:       197.469 [ms] (mean)
	Time per request:       1.975 [ms] (mean, across all concurrent requests)
	Transfer rate:          1618.13 [Kbytes/sec] received

	Connection Times (ms)
	              min  mean[+/-sd] median   max
	Connect:        3    7   4.4      5      24
	Processing:    22  180  29.9    188     217
	Waiting:       22  179  29.9    188     217
	Total:         30  187  28.2    194     241

	Percentage of the requests served within a certain time (ms)
	  50%    194
	  66%    197
	  75%    200
	  80%    203
	  90%    206
	  95%    213
	  98%    219
	  99%    224
	 100%    241 (longest request)