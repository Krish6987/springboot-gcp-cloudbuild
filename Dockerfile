FROM tomcat:8.0.51-jre8-alpine

RUN rm -rf /usr/local/tomcat/webapps/*

ARG WAR_FILE

COPY ${WAR_FILE} /usr/local/tomcat/webapps/ROOT.war

EXPOSE 8080

CMD ["catalina.sh","run"]
