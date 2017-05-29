FROM ubuntu:latest
RUN sudo apt-get update && apt-get upgrade -y
RUN apt-get install curl nano -y
RUN curl -O https://storage.googleapis.com/golang/go1.6.linux-amd64.tar.gz
RUN tar -xvf go1.6.linux-amd64.tar.gz && mv go /usr/local
RUN echo "PATH=\$PATH:/usr/local/go/bin" >> ~/.profile
RUN export GOPATH=$HOME/work
RUN apt-get install git -y
RUN /usr/local/go/bin/go get -v github.com/jpillora/csv-to-influxdb