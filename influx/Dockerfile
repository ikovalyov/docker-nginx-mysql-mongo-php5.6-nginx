FROM ubuntu
RUN apt-get update && apt-get install curl apt-transport-https nano -y 
RUN curl -sL https://repos.influxdata.com/influxdb.key | apt-key add - 
RUN /bin/bash -c 'source /etc/lsb-release; echo "deb https://repos.influxdata.com/${DISTRIB_ID,,} ${DISTRIB_CODENAME} stable" | tee /etc/apt/sources.list.d/influxdb.list'
RUN apt-get update && apt-get install influxdb -y 
COPY init.sh /etc/init.d/influxd
RUN chmod +x /etc/init.d/influxd 
CMD influxd