docker pull ikovalyov/influx
docker pull ikovalyov/php-xdebug
docker network create prospect-one-network
docker run --network=prospect-one-network --name mongo -p 27017:27017 -d mongo
docker run --network=prospect-one-network --name mysql -p 3306:3306 -e MYSQL_ROOT_PASSWORD=rootPass -d mysql
docker run --network=prospect-one-network --name memcache -d memcached
docker run --network=prospect-one-network --name influxdb -p 8083:8083 -p 8086:8086 -v //D/docker/webapp/://opt/webapp/ -d ikovalyov/influx
docker run --network=prospect-one-network --net-alias php --name php-xdebug -p 9000:9000 -p 10022:22 -v //D/docker/webapp/://opt/webapp/ -dt ikovalyov/php-xdebug
docker run --network=prospect-one-network --net-alias cdnperf.int --net-alias admin.dnsperf.int --name nginx -p 80:80 -p 443:443 -v //D/docker/webapp/://opt/webapp/ -v //D/docker5.6/nginx/nginx.conf:/etc/nginx/nginx.conf:ro -v //D/docker5.6/nginx/fastcgi.conf:/etc/nginx/fastcgi.conf:ro -d nginx