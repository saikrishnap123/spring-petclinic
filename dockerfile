FROM maven:3.8-openjdk-17 AS builder
RUN git clone https://github.com/spring-projects/spring-petclinic.git
RUN cd spring-petclinic/ && ./mvnw package -DskipTests

FROM openjdk:17
COPY --from=builder /spring-petclinic/target/spring-petclinic*.jar /spring-petclinic.jar
EXPOSE 8080
CMD [ "java", "-jar", "spring-petclinic.jar" ]
