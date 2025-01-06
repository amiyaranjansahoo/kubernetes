## Docker file
```sh
FROM alpine:3.14.1
LABEL name="java home"
RUN apk add openjdk8

# Download and install tomcat8
WORKDIR /root/RnD
RUN wget https://dlcdn.apache.org/tomcat/tomcat-9/v9.0.98/bin/apache-tomcat-9.0.98.tar.gz
RUN tar -xvf apache-tomcat-9.0.98.tar.gz
RUN mv apache-tomcat-9.0.98 tomcat9

EXPOSE 8080

# Create the staic page
WORKDIR /root/RnD/tomcat9/webapps
RUN mkdir javahome
RUN echo "<h2> Welcome to the Docker technology - V1 </h2>" > javahome/index.html
CMD ["/root/RnD/tomcat9/bin/catalina.sh","run"]
```

## Manual build
```sh
# Jdk download:
sudo yum install java-17-amazon-corretto-devel -y

# Maven Installation
wget https://dlcdn.apache.org/maven/maven-3/3.9.5/binaries/apache-maven-3.9.5-bin.tar.gz
tar -zxvf apache-maven-3.9.5-bin.tar.gz
sudo mv apache-maven-3.9.5 /usr/local/bin/maven
mvn_home=/usr/local/bin/maven/bin
PATH=${PATH}:${mvn_home}
export PATH

# Git Installation
sudo yum install git -y

# Clone the project
git clone https://github.com/amiyaranjansahoo/javahome-k8s-project.git

# Docker build
FROM openjdk:8-jdk-alpine
VOLUME /tmp
EXPOSE 8095
ADD target/*.jar app.jar
ENV JAVA_OPTS=""
ENTRYPOINT [ "sh", "-c", "java $JAVA_OPTS -Djava.security.egd=file:/dev/./urandom -jar /app.jar" ]
```
