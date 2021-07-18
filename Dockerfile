FROM maven:3.8.1-openjdk-8 as build
ARG database=h2
WORKDIR ./build
ARG database
ENV database = ${database}
COPY . .
RUN mvn package
FROM openjdk:8-oraclelinux7
WORKDIR springapp
COPY --from=build build/target/spring-petclinic.war .
ENTRYPOINT ["java"]
CMD ["-jar", "spring-petclinic.war" ]
EXPOSE 8080