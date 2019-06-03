FROM tomcat:9-jdk11 as build-stage

ENV DB_HOSTNAME 127.0.0.1
ENV DB_PORT 5421
ENV DB_USERNAME aggregate
ARG DB_PASSWORD

ADD https://github.com/opendatakit/aggregate/releases/download/v2.0.3/ODK-Aggregate-v2.0.3-Linux-x64.run.zip /tmp/aggregate.zip

RUN cd /tmp && \
    unzip aggregate.zip && \
    ./ODK-Aggregate-v2.0.3-Linux-x64.run \
      --mode unattended \
      --platform postgresql \
      --database_hostname $DB_HOSTNAME \
      --database_port $DB_PORT \
      --jdbc_username $DB_USERNAME \
      --jdbc_password $DB_PASSWORD

FROM tomcat:9-jdk11

RUN rm -rf webapps/ROOT
