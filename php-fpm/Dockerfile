FROM pvlltvk/ubuntu-trusty-php-fpm-5.6
RUN mkdir /tmp/xdebug
WORKDIR /tmp/xdebug
RUN apt-get install -y wget && wget http://xdebug.org/files/xdebug-2.3.3.tgz && tar -xvzf xdebug-2.3.3.tgz
WORKDIR /tmp/xdebug/xdebug-2.3.3
RUN echo "Dpkg::Options {\
   "--force-confdef";\
   "--force-confold";\
}" >  /etc/apt/apt.conf.d/local 

RUN DEBIAN_FRONTEND=noninteractive apt-get update && apt-get install -y --force-yes libc6=2.19-0ubuntu6 libtool libssl1.0.0=1.0.1f-1ubuntu2 php5-dev && DEBIAN_FRONTEND=noninteractive phpize && \
		./configure && make && cp modules/xdebug.so /usr/lib/php5/20131226 && echo "zend_extension = /usr/lib/php5/20131226/xdebug.so" > /etc/php5/cli/php.ini && \
		echo "zend_extension = /usr/lib/php5/20131226/xdebug.so" > /etc/php5/fpm/php.ini
		
# Configure xdebug
RUN echo "xdebug.remote_enable=1" >> /etc/php5/mods-available/xdebug.ini
RUN echo "xdebug.idekey=PHPSTORM" >> /etc/php5/mods-available/xdebug.ini
RUN echo "xdebug.remote_connect_back=1" >> /etc/php5/mods-available/xdebug.ini
RUN echo "xdebug.remote_host=172.17.42.1" >> /etc/php5/mods-available/xdebug.ini		
RUN echo "xdebug.remote_autostart=1" >> /etc/php5/mods-available/xdebug.ini
RUN echo "xdebug.remote_port=9001" >> /etc/php5/mods-available/xdebug.ini
RUN cp /etc/php5/mods-available/xdebug.ini /etc/php5/fpm/conf.d/20-xdebug.ini
RUN cp /etc/php5/mods-available/xdebug.ini /etc/php5/cli/conf.d/20-xdebug.ini
EXPOSE 9001

#configure SSH
RUN apt-get update && apt-get install -y openssh-server
RUN mkdir /var/run/sshd
RUN echo 'root:screencast' | chpasswd
RUN sed -i 's/PermitRootLogin without-password/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd
ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile

EXPOSE 22

#supervisor
RUN apt-get -y install gettext libgettextpo-dev supervisor 
ADD supervisord.conf /etc/supervisor/conf.d/supervisord.conf

#composer
RUN wget http://getcomposer.org/installer && php installer && mv composer.phar /usr/local/bin/composer && rm installer

#git
RUN apt-get install -y git && apt-get install php5-mongo && apt-get install curl && curl --silent --location https://deb.nodesource.com/setup_4.x | sudo bash - && \
  apt-get install -y nodejs && npm install -g bower

ENTRYPOINT ["/bin/sh","-c"]

CMD ["/usr/bin/supervisord", "-n"]
