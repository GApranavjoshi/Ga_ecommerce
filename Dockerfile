# Build stage
# Just a label for the build stage
FROM maven:3.9-eclipse-temurin-17 AS builder
# It is a Docker image that already contains:
# - Maven
# - Java 17 JDK

WORKDIR /build
COPY pom.xml .
COPY src ./src
RUN mvn clean package -DskipTests

# Runtime stage
FROM eclipse-temurin:17-jre-alpine
WORKDIR /myapp
COPY --from=builder /build/target/ecommerce-0.0.1-SNAPSHOT.jar app.jar
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.jar"]