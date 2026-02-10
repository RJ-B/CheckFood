# ===============================================================
# 1. FÁZE: SESTAVENÍ (BUILD STAGE)
# ===============================================================
# Změna z openjdk na eclipse-temurin pro zajištění dostupnosti obrazu
FROM maven:3.8.5-eclipse-temurin-17 AS build

WORKDIR /app

COPY pom.xml .
RUN mvn dependency:go-offline -B

COPY src ./src
RUN mvn clean package -DskipTests

# ===============================================================
# 2. FÁZE: RUNTIME (RUN STAGE)
# ===============================================================
FROM eclipse-temurin:17-jre-focal

WORKDIR /app

# Kopírování JAR souboru
COPY --from=build /app/target/*.jar app.jar

EXPOSE 8081

ENTRYPOINT ["java", \
            "-Dspring.profiles.active=${SPRING_PROFILES_ACTIVE}", \
            "-Dfile.encoding=UTF-8", \
            "-jar", \
            "app.jar"]