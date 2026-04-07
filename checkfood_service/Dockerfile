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
# 2. FÁZE: RUNTIME (RUN STAGE — optimalizováno pro Cloud Run)
# ===============================================================
FROM eclipse-temurin:21-jre

WORKDIR /app

COPY --from=build /app/target/*.jar app.jar

# Cloud Run nastaví PORT automaticky (default 8080)
ENV PORT=8080

EXPOSE ${PORT}

ENTRYPOINT ["java", \
    "-XX:+UseG1GC", \
    "-XX:MaxRAMPercentage=75.0", \
    "-Djava.security.egd=file:/dev/./urandom", \
    "--add-opens", "java.base/java.io=ALL-UNNAMED", \
    "-jar", "app.jar"]
