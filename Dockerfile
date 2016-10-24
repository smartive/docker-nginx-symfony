FROM debian:jessie

MAINTAINER smartive AG <hello@smartive.ch>

RUN sed -i "s/httpredir.debian.org/debian.ethz.ch/g" /etc/apt/sources.list
RUN find /etc/apt/sources.list.d/ -type f -exec sed -i 's/httpredir.debian.org/debian.ethz.ch/g' {} \;

RUN apt-get update && apt-get install -y nginx && apt-get install -y vim

ADD nginx.conf /etc/nginx/
ADD symfony.conf /etc/nginx/sites-available/

RUN rm -f /etc/nginx/sites-enabled/*
RUN ln -s /etc/nginx/sites-available/symfony.conf /etc/nginx/sites-enabled/symfony

RUN echo "upstream php-upstream { server application:9000; }" > /etc/nginx/conf.d/upstream.conf

CMD ["nginx"]

EXPOSE 80
EXPOSE 443
