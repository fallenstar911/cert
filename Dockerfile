FROM tomcat:9-jre8-alpine
ADD hello*.war /usr/local/tomcat/webapps/
EXPOSE 8080
