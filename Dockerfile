FROM openjdk:17-jdk-slim
WORKDIR /app
COPY target/demo-app-1.0-SNAPSHOT.jar app.jar
EXPOSE 8080
ENTRYPOINT ["java","-cp","app.jar","com.example.Main"]
