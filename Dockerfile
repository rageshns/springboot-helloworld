FROM 196573780280.dkr.ecr.us-east-1.amazonaws.com/pcl-appd-jdk-apm:4.5_jdk8-alpine


VOLUME /tmp

ADD target/gs-spring-boot-docker-0.1.0.jar app.jar
ENV JAVA_OPTS=""

EXPOSE 9080 8090

CMD  java ${JAVA_OPTS}  \
 -Dlog4j.configurationFile=opt/appdynamics/ver4.5.1.23676/conf/logging/log4j2.xml \
 -Djava.security.egd=file:/dev/./urandom \
 -javaagent:/opt/appdynamics/javaagent.jar \
 -jar /app.jar