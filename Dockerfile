FROM java:8-jdk-alpine

COPY ./target/hello-world-0.1.0.jar /usr/app/

WORKDIR /usr/app

RUN sh -c 'touch hello-world-0.1.0.jar'

ENTRYPOINT ["java","-jar","hello-world-0.1.0.jar"]
