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
