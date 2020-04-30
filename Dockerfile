FROM alpine/git
WORKDIR /app
RUN git clone https://github.com/spring-projects/spring-petclinic.git 

FROM maven:3.5-jdk-8-alpine
WORKDIR /app
COPY --from=0 /app/spring-petclinic /app 
RUN mvn clean package

FROM openjdk:8-jre-alpine
WORKDIR /app
COPY --from=1 /app/target/*.jar /app

# Uncomment the RUN line if the version has changed
# Then use the output of docker build to modify the
# .jar file name
#RUN ls

CMD ["java","-jar","spring-petclinic-2.2.0.BUILD-SNAPSHOT.jar"] 
