FROM ubuntu

RUN apt-get install -y nginx
COPY nginx.conf /etc/nginx/nginx.conf
COPY fastcgi.conf /etc/nginx/fastcgi.conf
RUN useradd -s /bin/false nginx
RUN mkdir /usr/share/nginx/logs/
WORKDIR /
ENTRYPOINT nginx -g 'daemon off;'