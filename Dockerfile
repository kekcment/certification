FROM ubuntu:20.04
RUN apt update
RUN apt install git -y
RUN DEBIAN_FRONTEND=noninteractive apt-get install maven -y
WORKDIR /tmp/
RUN git clone https://github.com/kekcment/App44.git
WORKDIR  /tmp/App44/
RUN mvn package