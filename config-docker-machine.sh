docker pull ikovalyov/influx
docker pull ikovalyov/php-xdebug
docker network create --subnet=172.18.0.0/16 --gateway=172.18.0.1 prospect-one-network
docker run --network=prospect-one-network --ip=172.18.0.6 --name mongo -p 27017:27017 -d mongo
docker run --network=prospect-one-network --ip=172.18.0.3 --name mysql -p 3306:3306 -e MYSQL_ROOT_PASSWORD=rootPass -d mysql:5.7
docker run --network=prospect-one-network --ip=172.18.0.4 --name memcache -d memcached
docker run --network=prospect-one-network --ip=172.18.0.5 --name influxdb -p 8083:8083 -p 8086:8086 -v //D/docker/webapp/://opt/webapp/ -d ikovalyov/influx
docker run --network=prospect-one-network --ip=172.18.0.2 --net-alias php --name php-xdebug -p 9000:9000 -p 10022:22 -v //D/docker/webapp/://opt/webapp/ -dt ikovalyov/php-xdebug
docker run --network=prospect-one-network --ip=172.18.0.7 --net-alias api.perfstack.int --net-alias admin.dnsperf.int --net-alias admin.perfstack.int --name nginx -p 80:80 -p 443:443 -v //D/work/websites://opt/webapp/ -v //D/work/docker/nginx.conf:/etc/nginx/nginx.conf:ro -v //D/work/docker/fastcgi.conf:/etc/nginx/fastcgi.conf:ro -d nginx
docker run --network=prospect-one-network --ip=172.18.0.8 --name redis -e REDIS_PASSWORD=password123 bitnami/redis:latest
docker run --network=prospect-one-network --ip=172.18.0.9 --name ichi -v //D/docker/webapp/://opt/webapp/ -dt ikovalyov/php-xdebug