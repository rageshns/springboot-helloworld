FROM appdynamics/dynamic-agent-ma
FROM openjdk:8-jdk-alpine

ENV FC_LANG en-US
ENV LC_CTYPE en_US.UTF-8
# dependencies
RUN apk add --update bash ttf-dejavu fontconfig

# fix broken cacerts
RUN apk add --update java-cacerts && \
    rm -f /usr/lib/jvm/default-jvm/jre/lib/security/cacerts && \
    ln -s /etc/ssl/certs/java/cacerts /usr/lib/jvm/default-jvm/jre/lib/security/cacerts
	
# We added a VOLUME pointing to "/tmp" because that is where a Spring Boot application creates
# working directories for Tomcat by default. The effect is to create a temporary file on your
# host under "/var/lib/docker" and link it to the container under "/tmp". This step is optional
# for the simple app that we wrote here, but can be necessary for other Spring Boot applications
# if they need to actually write in the filesystem.
VOLUME /tmp
ENV APP_DIR /app

ADD target/gs-spring-boot-docker-0.1.0.jar $APP_DIR/app.jar
# ENV JAVA_OPTS=""
WORKDIR $APP_DIR
EXPOSE 9080

# To reduce Tomcat startup time we added a system property pointing to "/dev/urandom" as a source of entropy.
#ENTRYPOINT [ "sh", "-c", "java $JAVA_OPTS -Djava.security.egd=file:/dev/./urandom -jar /app.jar" ]
CMD ["java","-Dfile.encoding=UTF-8","-Djava.security.egd=file:/dev/./urandom", "-jar","app.jar"]