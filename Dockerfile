FROM openjdk:8-jdk-alpine

# We added a VOLUME pointing to "/tmp" because that is where a Spring Boot application creates
# working directories for Tomcat by default. The effect is to create a temporary file on your
# host under "/var/lib/docker" and link it to the container under "/tmp". This step is optional
# for the simple app that we wrote here, but can be necessary for other Spring Boot applications
# if they need to actually write in the filesystem.
VOLUME /tmp


COPY ./AppdConfig.env /
COPY ./AppdStart.sh /

ADD target/gs-spring-boot-docker-0.1.0.jar app.jar
#RUN chmod +x /AppdStart.sh
RUN chmod 0755 /AppdStart.sh
#ENV JAVA_OPTS=""
#RUN cat /AppdStart.sh | tr -d '\r' > /AppdStart.sh

# To reduce Tomcat startup time we added a system property pointing to "/dev/urandom" as a source of entropy.
#ENTRYPOINT [ "sh", "-c", "java $JAVA_OPTS -Djava.security.egd=file:/dev/./urandom -jar /app.jar" ]
#ENTRYPOINT ["java","-Djava.security.egd=file:/dev/./urandom","-jar","/app.jar"]
#CMD "/AppdStart.sh"

# runs application
#CMD ["/usr/bin/java", "-jar", "-Djava.security.egd=file:/dev/./urandom", "/app.jar"]
ENTRYPOINT ["java","-Djava.security.egd=file:/dev/./urandom","-jar","/app.jar"]
#ENTRYPOINT ["sh","/AppdStart.sh"]