
FROM 196573780280.dkr.ecr.us-east-1.amazonaws.com/pcl-appd-jdk-apm:4.5_jdk8-alpine

ENV FC_LANG en-US
ENV LC_CTYPE en_US.UTF-8

# dependencies
RUN apk add --update bash ttf-dejavu fontconfig

# fix broken cacerts
RUN apk add --update java-cacerts && \
    rm -f /usr/lib/jvm/default-jvm/jre/lib/security/cacerts && \
    ln -s /etc/ssl/certs/java/cacerts /usr/lib/jvm/default-jvm/jre/lib/security/cacerts

VOLUME /tmp

ADD target/gs-spring-boot-docker-0.1.0.jar app.jar
ENV JAVA_OPTS=""

EXPOSE 9080 443

CMD  java ${JAVA_OPTS}  \
 -Djava.security.egd=file:/dev/./urandom \
 -javaagent:/opt/appdynamics/javaagent.jar \
 -jar /app.jar