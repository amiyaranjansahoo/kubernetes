#### Manual build:
###### Launch EC2 with atleast 2 CPU and 4 GB RAM.
###### Install the jdk 17: java-17-amazon-corretto-devel 
###### Install and configure the path for maven
###### Install git
###### Install docker
###### Clone the project from github.
```sh
https://github.com/amiyaranjansahoo/javahome-k8s-project.git
```

###### Build the dockerimage from the Dockerfile:
```sh
FROM openjdk:8-jdk-alpine
VOLUME /tmp
EXPOSE 8095
ADD target/*.jar app.jar
ENV JAVA_OPTS=""
ENTRYPOINT [ "sh", "-c", "java $JAVA_OPTS -Djava.security.egd=file:/dev/./urandom -jar /app.jar" ]
```
###### Push the docker image to docker hub / ECR
