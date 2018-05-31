FROM jenkins/jenkins:lts-alpine
COPY plugins.txt /usr/share/jenkins/ref/plugins.txt
RUN /usr/local/bin/install-plugins.sh < /usr/share/jenkins/ref/plugins.txt
RUN touch /tmp/koko
RUN cd /usr/share/jenkins/ref && tar -zczf plugins.tar.gz plugins

FROM kpsimoulis/fileserver
COPY --from=0 /usr/share/jenkins/ref/plugins.tar.gz /usr/share/nginx/html/repo/