# ===============================================================
# 1. FÁZE: SESTAVENÍ (BUILD STAGE)
# ===============================================================
FROM maven:3.9.6-eclipse-temurin-21 AS build

WORKDIR /app

COPY pom.xml .
RUN mvn dependency:go-offline -B

COPY src ./src
RUN mvn clean package -DskipTests

# ===============================================================
# 2. FÁZE: RUNTIME (RUN STAGE)
# ===============================================================
FROM eclipse-temurin:21-jre-jammy

WORKDIR /app

COPY --from=build /app/target/*.jar app.jar

EXPOSE 8081

ENTRYPOINT ["java", \
            "-Dspring.profiles.active=${SPRING_PROFILES_ACTIVE}", \
            "-Dfile.encoding=UTF-8", \
            "-jar", \
            "app.jar"]