# FROM tomcat:9.0.72-jre11
# ADD ./target/mycalcwebapp.war /usr/local/tomcat/webapps/
FROM ubuntu:20.04
RUN apt update
RUN apt install git -y
RUN DEBIAN_FRONTEND=noninteractive apt-get install maven -y
WORKDIR /tmp/
RUN git clone https://github.com/kekcment/sertification.git
WORKDIR  /tmp/sertification/
RUN mvn package