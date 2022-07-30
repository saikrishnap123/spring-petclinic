FROM lolhens/baseimage-openjre
ADD target/springpetclinicApp.jar springpetclinicApp.jar
EXPOSE 80
ENTRYPOINT ["java", "-jar", "springpetclinicApp.jar"]