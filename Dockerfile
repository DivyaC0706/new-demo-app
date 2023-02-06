FROM maven:3.6.3-openjdk-11-slim as BUILDER
WORKDIR /build/
COPY pom.xml /build/
COPY src /build/src/
RUN mvn clean package -Dmaven.test.skip=true

FROM tomcat
WORKDIR /app/
EXPOSE 8080
COPY --from=BUILDER /build/target/vprofile-v1.war /usr/local/tomcat/webapps
CMD ["catalina.sh", "run"]