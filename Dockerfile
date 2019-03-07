
FROM 196573780280.dkr.ecr.us-east-1.amazonaws.com/pcl-appd-jdk-apm:4.5_jdk8-alpine

ENV FC_LANG en-US
ENV LC_CTYPE en_US.UTF-8



VOLUME /tmp

ADD target/gs-spring-boot-docker-0.1.0.jar app.jar
ENV JAVA_OPTS=""

EXPOSE 9080 443

CMD  java ${JAVA_OPTS}  \
 -Djava.security.egd=file:/dev/./urandom \
 -javaagent:/opt/appdynamics/javaagent.jar \
 -jar /app.jar