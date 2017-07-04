################################################################################
# Dockerfile that provides the image for JBoss KIE Server 6.5.0.Final
#################################################################################

####### BASE ############
FROM jboss/wildfly:10.0.0.Final

####### MAINTAINER ############
MAINTAINER "Nicolas Héron" "nicolas.heron@pymma-software.com"

####### ENVIRONMENT ############
ENV JBOSS_BIND_ADDRESS 0.0.0.0
ENV KIE_REPOSITORY https://repository.jboss.org/nexus/content/groups/public-jboss
ENV KIE_VERSION 6.5.0.Final
ENV CHTIJBUG_REPOSITORY https://oss.sonatype.org/content/repositories/releases
ENV KIE_CLASSIFIER ee7
ENV KIE_CONTEXT_PATH kie-server
ENV CHTIJBUG_VERSION 2.0.10
ENV JAVA_OPTS -Xms256m -Xmx512m

###### SWITCH USER root ######
USER root

###### INSTALL PACKAGES ######
RUN yum install -y net-tools

##### SWITCH BACK TO jboss ####
USER jboss
####### KIE-SERVER ############
RUN curl $CHTIJBUG_REPOSITORY/org/chtijbug/drools/kie-server/$CHTIJBUG_VERSION/kie-server-$CHTIJBUG_VERSION.war -o /opt/jboss/wildfly/standalone/deployments/$KIE_CONTEXT_PATH.war
RUN curl $CHTIJBUG_REPOSITORY/org/chtijbug/drools/drools-framework-swimmingpool-web-ui/$CHTIJBUG_VERSION/drools-framework-swimmingpool-web-ui-$CHTIJBUG_VERSION.war -o /opt/jboss/wildfly/standalone/deployments/swimmingpool-web.war


####### ENVIRONMENT ############
# ENV KIE_SERVER_ID kie-server
ENV KIE_SERVER_LOCATION http://localhost:8080/kie-server/services/rest/server
ENV KIE_SERVER_USER kieserver
ENV KIE_SERVER_PWD kieserver1!
# ENV KIE_SERVER_CONTROLLER http://localhost:8080/kie-wb/rest/controller
ENV KIE_SERVER_CONTROLLER_USER admin
ENV KIE_SERVER_CONTROLLER_PWD admin
ENV KIE_MAVEN_REPO http://localhost:8080/kie-wb/maven2
ENV KIE_MAVEN_REPO_USER admin
ENV KIE_MAVEN_REPO_PASSWORD admin

####### Drools KIE Server CUSTOM CONFIGURATION ############
RUN mkdir -p $HOME/.m2
ADD etc/standalone-full-kie-server.xml $JBOSS_HOME/standalone/configuration/standalone-full-kie-server.xml
ADD etc/kie-server-users.properties $JBOSS_HOME/standalone/configuration/kie-server-users.properties
ADD etc/kie-server-roles.properties $JBOSS_HOME/standalone/configuration/kie-server-roles.properties
ADD etc/start_kie-server.sh $JBOSS_HOME/bin/start_kie-server.sh
ADD etc/settings.xml $JBOSS_HOME/../.m2/settings.xml

# Added files are chowned to root user, change it to the jboss one.
USER root
RUN chown jboss:jboss $JBOSS_HOME/standalone/configuration/standalone-full-kie-server.xml && \
chown jboss:jboss $JBOSS_HOME/standalone/configuration/kie-server-users.properties && \
chown jboss:jboss $JBOSS_HOME/standalone/configuration/kie-server-roles.properties && \
chown jboss:jboss $JBOSS_HOME/bin/start_kie-server.sh && \
chown jboss:jboss $JBOSS_HOME/../.m2/settings.xml

####### JBOSS USER ############
# Switchback to jboss user
USER jboss

####### RUNNING KIE-SERVER ############
WORKDIR $JBOSS_HOME/bin/
CMD ["./start_kie-server.sh"]
