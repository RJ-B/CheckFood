# ===============================================================
# 1. FÁZE: SESTAVENÍ (BUILD STAGE)
# ===============================================================
FROM maven:3.9-eclipse-temurin-21 AS build

WORKDIR /app

COPY pom.xml .
RUN mvn dependency:go-offline -B

COPY src ./src
RUN mvn clean package -DskipTests

# ===============================================================
# 2. FÁZE: RUNTIME (RUN STAGE)
# ===============================================================
FROM eclipse-temurin:21-jre

WORKDIR /app

COPY --from=build /app/target/*.jar app.jar

ENV PORT=8081

EXPOSE ${PORT}

ENTRYPOINT java -jar app.jar --server.port=${PORT} --server.address=0.0.0.0
