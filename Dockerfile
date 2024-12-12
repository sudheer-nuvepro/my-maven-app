FROM maven:3.9.9-eclipse-temurin-17 AS build
WORKDIR /app
COPY pom.xml .
COPY src ./src
RUN mvn clean package
FROM openjdk:17-slim
COPY --from=build /app/target/my-maven-app-1.0-SNAPSHOT.jar /app/my-maven-app.jar
EXPOSE 8081
CMD ["java", "-jar", "/app/my-maven-app.jar"]
