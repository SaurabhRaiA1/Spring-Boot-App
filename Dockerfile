# Stage 1: Build the application
FROM maven:3.8.5 AS build
WORKDIR /app
COPY pom.xml .
COPY src ./src
RUN mvn dependency:go-offline -DskipTests
RUN mvn package -DskipTests

# Stage 2: Run the application using an OpenJDK image
FROM openjdk:17-jdk-slim
WORKDIR /app
COPY --from=build /app/target/*.jar app.jar
ENTRYPOINT ["java", "-jar", "app.jar"]
