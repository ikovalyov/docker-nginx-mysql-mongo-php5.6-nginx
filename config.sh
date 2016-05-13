#docker-machine create --driver virtualbox dev
docker-machine start dev
docker-machine ssh dev "mkdir /home/docker/docker"
docker-machine ssh dev "mkdir /home/docker/documentRoot"
docker-machine ssh dev "sudo mount -t vboxsf -o rw,uid=1000,gid=1000 /home/docker56 /home/docker/docker"
docker-machine ssh dev "sudo mount -t vboxsf -o rw,uid=1000,gid=1000 /documentRoot /home/docker/documentRoot"
docker-machine ssh dev "docker build -t ikovalyov/nginx:latest /home/docker/docker/nginx/"
docker-machine ssh dev "docker build -t ikovalyov/php-xdebug:latest /home/docker/docker/php-fpm/"
docker-machine ssh dev "docker run -dt --name=websites -v /home/docker/documentRoot://opt/webapp ubuntu"
docker-machine ssh dev "docker run -p 27017:27017 --name mongo -d mongo"
docker-machine ssh dev "docker run -p 3306:3306 --name mysql -e MYSQL_ROOT_PASSWORD=rootPass -d mysql:5.7"
docker-machine ssh dev "docker run --name memcache -d memcached"
docker-machine ssh dev "docker run -dt -p 9000:9000 -p 9001:9001 -p 10022:22 --name=php-xdebug --volumes-from websites --link mongo --link mysql --link memcache --add-host master.dnsperf.int:192.168.99.100 ikovalyov/php-xdebug"
docker-machine ssh dev "docker run -dt -p 80:80 -p 443:443 --name=nginx --volumes-from websites --link php-xdebug:php ikovalyov/nginx"
