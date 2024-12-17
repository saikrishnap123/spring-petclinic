FROM openjdk:8
RUN cd spring-petclinic && ./mvnw package -DskipTests
RUN cd /target
EXPOSE 8080
CMD [ "java", "-jar", "spring-petclinic-2.4.2.jar" ]