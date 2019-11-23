FROM httpd:2.4
LABEL maintainer="Noima Solutions Inc."

ARG RUNAS_USER 

COPY entrypoint.sh /my-docker-entrypoint.sh
RUN chmod 755 /my-docker-entrypoint.sh \
    && mkdir /run/lock/apache \
    && chown daemon:daemon /run/lock/apache

WORKDIR /usr/local/apache2
RUN echo "Include conf/extra/webdav.conf" >> conf/httpd.conf

ENTRYPOINT ["/my-docker-entrypoint.sh"]
CMD ["httpd-foreground"]
