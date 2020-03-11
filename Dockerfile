FROM maven:3-jdk-11 AS build
ADD . /root/
WORKDIR /root
RUN mvn package
RUN cp ./collector/target/collector-*.jar /opt/collector.jar
RUN cp ./jmx_prometheus_javaagent/target/jmx_prometheus_javaagent-*.jar /opt/jmx_prometheus_javaagent.jar
RUN cp ./jmx_prometheus_httpserver/target/jmx_prometheus_httpserver-*-jar-with-dependencies.jar /opt/jmx_prometheus_httpserver.jar

FROM openjdk:11-jre-slim
COPY --from=build /opt /opt/jmx_exporter/
