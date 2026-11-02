FROM eclipse-temurin:25-jdk AS build
WORKDIR /app
COPY . .
RUN mkdir -p /root/.m2/repository \
    && cp -R .maven-repository/. /root/.m2/repository/ \
    && chmod +x ./mvnw \
    && ./mvnw clean package -DskipTests

FROM eclipse-temurin:25-jre
WORKDIR /app
COPY --from=build /app/target/*.jar app.jar
EXPOSE 8081
ENTRYPOINT ["java", "-jar", "app.jar"]
