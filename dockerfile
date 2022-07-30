# creating docker image for Prod environment
FROM ubuntu:18.04
LABEL author="Murali"
LABEL Organization="DevOps Forum"
RUN apt-get update
RUN apt-get install apache2 -y
VOLUME [ "/var/www/html" ]
CMD [ "apache2ctl", "-D", "FOREGROUND" ]
