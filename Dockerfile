FROM maven:3.6.3-ibmjava-8-alpine

RUN mkdir -p /usr/src/app/springboot/

WORKDIR /usr/src/app/springboot/

COPY . .

RUN ls

RUN mvn clean install

FROM From tomcat:8.0.51-jre8-alpine

RUN rm -rf /usr/local/tomcat/webapps/*

COPY ./target/springboot-0.0.1-SNAPSHOT.war /usr/local/tomcat/webapps/ROOT.war

CMD ["catalina.sh","run"]

