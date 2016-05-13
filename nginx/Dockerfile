FROM ubuntu

#nginx
#RUN apt-get update
#RUN DEBIAN_FRONTEND=noninteractive apt-get update && apt-get install -y apt-utils sudo nano curl wget libpcre3 libpcre3-dev libssl-dev make libcurl4-openssl-dev libmcrypt-dev libxml2-dev libjpeg-dev libfreetype6-dev libmysqlclient-dev libt1-dev libgmp-dev libpspell-dev libicu-dev librecode-dev libjpeg62 \
#	psmisc telnet git npm net-tools
#RUN mkdir install && wget http://nginx.org/download/nginx-1.6.0.tar.gz && tar xfz nginx-1.6.0.tar.gz
#RUN NGINX_DEB_ARCHIVE="http://nginx.org/download/nginx-1.6.0.tar.gz" && wget -P /tmp $NGINX_DEB_ARCHIVE && tar xzPf /tmp/nginx-1.6.0.tar.gz -C /tmp/
#WORKDIR /tmp/nginx-1.6.0
#RUN ./configure --user=nginx --group=nginx --prefix=/etc/nginx --sbin-path=/usr/sbin/nginx --conf-path=/etc/nginx/nginx.conf --error-log-path=/var/log/nginx/error.log --http-log-path=/var/log/nginx/access.log --pid-path=/var/run/nginx.pid --lock-path=/var/run/nginx.lock --with-http_ssl_module --with-pcre --with-debug &&\
#    make && make install && useradd -d /etc/nginx/ -s /sbin/nologin nginx && mkdir -p /srv/www/html && mkdir /etc/nginx/logs/
RUN apt-get install -y nginx
COPY nginx.conf /etc/nginx/nginx.conf
COPY fastcgi.conf /etc/nginx/fastcgi.conf
RUN useradd -s /bin/false nginx
RUN mkdir /usr/share/nginx/logs/
WORKDIR /
ENTRYPOINT nginx -g 'daemon off;'