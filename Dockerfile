FROM openjdk:8-jdk-alpine

RUN apk --update upgrade && \
    apk add --no-cache \
      bash \
      unzip \
      ca-certificates && \
    update-ca-certificates && \
    rm -rf /var/cache/apk/*
	

VOLUME /tmp

COPY AppServerAgent.zip /

ADD target/gs-spring-boot-docker-0.1.0.jar app.jar

RUN chmod +x AppServerAgent.zip

RUN sh -c 'touch /app.jar'

RUN unzip AppServerAgent.zip -d AppServerAgent && rm -f AppServerAgent.zip

ENV JAVA_OPTS=""

EXPOSE 9080 

CMD  java ${JAVA_OPTS}  \
 -Djava.security.egd=file:/dev/./urandom \
 -javaagent:/javaagent.jar \
 -jar /app.jar