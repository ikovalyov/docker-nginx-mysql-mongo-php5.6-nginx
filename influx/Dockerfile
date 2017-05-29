FROM ubuntu
RUN apt-get update && apt-get install -y wget
RUN wget https://dl.influxdata.com/influxdb/releases/influxdb_1.2.0_amd64.deb
RUN dpkg -i influxdb_1.2.0_amd64.deb
COPY init.sh /etc/init.d/influxd
RUN chmod +x /etc/init.d/influxd 
CMD influxd