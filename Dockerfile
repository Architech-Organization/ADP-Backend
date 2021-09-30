FROM gradle:6.9.1-jdk11-openj9 AS builder

WORKDIR /tmp

COPY *.gradle .

RUN gradle dependencies

COPY . .

RUN gradle build

FROM openjdk:11.0.10-jre-buster

RUN mkdir /server
WORKDIR /server

COPY --from=builder /tmp/build/libs/realworld-spring-boot-java-2.0.0.jar .

EXPOSE 8080

CMD ["java","-jar","realworld-spring-boot-java-2.0.0.jar"]

