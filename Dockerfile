FROM alpine:latest
RUN apk update && \
    apk add openjdk8 git

WORKDIR /tmp

RUN wget -q --no-check-certificate "https://apache-mirror.rbc.ru/pub/apache/tomcat/tomcat-9/v9.0.43/bin/apache-tomcat-9.0.43.tar.gz" && \
    tar xvzf apache-tomcat-9.0.43.tar.gz && \
    mkdir -p /usr/local/tomcat && \
    mv ./apache-tomcat-9.0.43/* /usr/local/tomcat/

RUN wget -q --no-check-certificate "http://archive.apache.org/dist/maven/maven-3/3.5.4/binaries/apache-maven-3.5.4-bin.tar.gz" && \
    tar -zxvf apache-maven-3.5.4-bin.tar.gz && \
    mv apache-maven-3.5.4 /usr/lib/mvn \
    ln -s /usr/lib/mvn/bin/mvn /usr/bin/mvn

WORKDIR /usr/local/tomcat/bin
RUN sh catalina.sh start

RUN mkdir /home/boxfuse \
    cd /home/boxfuse \
    git clone https://github.com/boxfuse/boxfuse-sample-java-war-hello.git \
    mv ./boxfuse-sample-java-war-hello/* . \
    rm -rf ./boxfuse-sample-java-war-hello \
    mvn package
CMD [""]