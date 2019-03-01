FROM openjdk:8-jdk-alpine

VOLUME /tmp

ADD target/gs-spring-boot-docker-0.1.0.jar app.jar

RUN sh -c 'touch /app.jar'

RUN unzip /appd/AppServerAgent.zip -d AppServerAgent && rm -f /appd/AppServerAgent.zip

ENV JAVA_OPTS=""

EXPOSE 9080 

CMD  java ${JAVA_OPTS}  \
 -Djava.security.egd=file:/dev/./urandom \
 -javaagent:/appd/AppServerAgent/javaagent.jar \
 -jar /app.jar