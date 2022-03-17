FROM openjdk:8-jdk-alpine as build
# Running applications with user privileges helps to mitigate some risks. 
# So suggest to run the application as a non-root user
RUN addgroup -S spring && adduser -S spring -G spring
USER spring:spring
WORKDIR /workspace/app
COPY src src
COPY pom.xml pom.xml
COPY .mvn .mvn
COPY mvnw .
RUN --mount=type=cache,target=/root/.m2 ./mvnw package

FROM openjdk:8-jdk-alpine as runtime
RUN addgroup -S spring && adduser -S spring -G spring
USER spring:spring
VOLUME /tmp
ARG TARGET=/workspace/app/target
COPY --from=build ${TARGET}/*.jar /workspace/app/spring-boot-helloworld.jar
EXPOSE 8080
ENTRYPOINT ["java","-jar","/workspace/app/spring-boot-helloworld.jar"]