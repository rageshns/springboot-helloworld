FROM 196573780280.dkr.ecr.us-east-1.amazonaws.com/pcl-appd-jdk-apm:4.5_jdk8-alpine

# We added a VOLUME pointing to "/tmp" because that is where a Spring Boot application creates
# working directories for Tomcat by default. The effect is to create a temporary file on your
# host under "/var/lib/docker" and link it to the container under "/tmp". This step is optional
# for the simple app that we wrote here, but can be necessary for other Spring Boot applications
# if they need to actually write in the filesystem.
VOLUME /tmp

ADD target/gs-spring-boot-docker-0.1.0.jar app.jar
ENV JAVA_OPTS=""

EXPOSE 9080 

CMD  java ${JAVA_OPTS}  \
 -Djava.security.egd=file:/dev/./urandom \
 -javaagent:/opt/appdynamics/javaagent.jar \
 -jar /app.jar