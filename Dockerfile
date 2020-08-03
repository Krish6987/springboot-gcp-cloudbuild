FROM maven:3.6.3-ibmjava-8-alpine

RUN mkdir -p /usr/src/app/springboot/

WORKDIR /usr/src/app/springboot/

COPY . .

RUN mvn clean install

