FROM tomcat:8.0.51-jre8-alpine

RUN rm -rf /usr/local/tomcat/webapps/*

ARG WAR_FILE = WAR_FILE_MUST_BE_SPECIFIED_AS_BUILD_ARG

COPY ${WAR_FILE} /usr/local/tomcat/webapps/ROOT.war

EXPOSE 8080

CMD ["catalina.sh","run"]
