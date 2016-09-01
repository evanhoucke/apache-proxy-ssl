FROM debian:wheezy
MAINTAINER Emmanuel Vanhoucke <evanhoucke@unix-fr.org>

RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get -yq install \
        curl \
        apache2 && \
    	rm -rf /var/lib/apt/lists/*

RUN a2enmod ssl proxy_http proxy_ajp proxy_balancer rewrite headers

RUN echo "ServerName localhost" >> /etc/apache2/apache2.conf
ADD vhost-default.conf /etc/apache2/sites-available/default

RUN mkdir -p /var/run/apache2 
RUN mkdir /app /conf
ADD run.sh /run.sh
RUN chmod 755 /*.sh


EXPOSE 80
WORKDIR /app
CMD ["/run.sh"]
