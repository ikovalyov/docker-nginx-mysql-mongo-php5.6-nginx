REM docker-machine start dev
REM docker-machine ssh dev "mkdir /home/docker/docker"
REM docker-machine ssh dev "mkdir /home/docker/documentRoot"
REM docker-machine ssh dev "sudo mount -t vboxsf -o rw,uid=1000,gid=1000 /home/docker56 /home/docker/docker"
REM docker-machine ssh dev "sudo mount -t vboxsf -o rw,uid=1000,gid=1000 /documentRoot /home/docker/documentRoot"
REM docker-machine ssh dev "docker build -t ikovalyov/nginx:latest /home/docker/docker/nginx/"
REM docker-machine ssh dev "docker build -t ikovalyov/php-xdebug:latest /home/docker/docker/php-fpm/"
REM docker-machine ssh dev "docker build -t ikovalyov/influx:latest /home/docker/docker/influx/"
REM docker-machine ssh dev "docker run -dt --name=websites -v /home/docker/documentRoot://opt/webapp ubuntu"
REM docker-machine ssh dev "docker run -p 27017:27017 --name mongo -d mongo"
REM docker-machine ssh dev "docker run -p 3306:3306 --name mysql -e MYSQL_ROOT_PASSWORD=rootPass -d mysql:5.7"
REM docker-machine ssh dev "docker run --name memcache -d memcached"
REM docker-machine ssh dev "docker run --name influxdb -d -p 8083:8083 -p 8086:8086 ikovalyov/influx"
REM docker-machine ssh dev "docker run -dt -p 9000:9000 -p 9001:9001 -p 10022:22 --name=php-xdebug --volumes-from websites --link mongo --link mysql --link memcache --link influxdb --add-host admin.dnsperf.int:192.168.99.100 --add-host node1.dnsperf.int:192.168.99.100  ikovalyov/php-xdebug"
REM docker-machine ssh dev "docker run -dt -p 80:80 -p 443:443 --name=nginx --volumes-from websites --link php-xdebug:php ikovalyov/nginx"

docker pull ikovalyov/influx
docker pull ikovalyov/php-xdebug
docker network create prospect-one-network
docker run --network=prospect-one-network --name mongo -p 27017:27017 -d mongo
docker run --network=prospect-one-network --name mysql -p 3306:3306 -e MYSQL_ROOT_PASSWORD=rootPass -d mysql:5.7
docker run --network=prospect-one-network --name memcache -d memcached
docker run --network=prospect-one-network --name influxdb -p 8083:8083 -p 8086:8086 -v //D/docker/webapp/://opt/webapp/ -d ikovalyov/influx
docker run --network=prospect-one-network --net-alias php --name php-xdebug -p 9000:9000 -p 10022:22 -v //D/docker/webapp/://opt/webapp/ -dt ikovalyov/php-xdebug
docker run --network=prospect-one-network --net-alias admin.dnsperf.int --net-alias cdnperf.int --name nginx -p 80:80 -p 443:443 -v //D/docker/webapp/://opt/webapp/ -v //D/docker5.6/nginx/nginx.conf:/etc/nginx/nginx.conf:ro -v //D/docker5.6/nginx/fastcgi.conf:/etc/nginx/fastcgi.conf:ro -d nginx