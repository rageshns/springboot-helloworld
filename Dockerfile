FROM openjdk:8-jdk-alpine

VOLUME /tmp

COPY ./AppdConfig.env /
COPY ./AppdStart.sh /

ADD target/gs-spring-boot-docker-0.1.0.jar app.jar

RUN sh -c 'touch /app.jar'

RUN chmod +x /AppdStart.sh
RUN chmod +x /AppdConfig.env


ENV JAVA_OPTS=""

EXPOSE 9080 9090

CMD /AppdStart.sh && \
 java ${JAVA_OPTS} -Djava.security.egd=file:/dev/./urandom -jar /app.jar