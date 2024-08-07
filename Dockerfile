# First stage: Build the application
FROM maven:3.8.6-openjdk-17-slim AS build
WORKDIR /app
COPY pom.xml .
COPY src ./src
RUN mvn clean package -DskipTests

# Second stage: Create a minimal runtime image
FROM openjdk:17-jdk-slim
WORKDIR /app
COPY --from=build /app/target/your-application.jar app.jar
ENTRYPOINT ["java", "-jar", "app.jar"]
