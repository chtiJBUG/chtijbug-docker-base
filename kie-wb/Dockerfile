##########################################################################
# Dockerfile that provides the image for JBoss Drools Workbench 6.5.0.Final
###########################################################################

####### BASE ############
FROM jboss/wildfly:10.0.0.Final

####### MAINTAINER ############
MAINTAINER "Nicolas Héron" "nicolas.heron@pymma-software.com"

####### ENVIRONMENT ############
ENV JBOSS_BIND_ADDRESS 0.0.0.0
ENV KIE_REPOSITORY https://repository.jboss.org/nexus/content/groups/public-jboss
ENV CHTIJBUG_REPOSITORY https://oss.sonatype.org/content/repositories/releases
ENV KIE_VERSION 6.5.0.Final
ENV KIE_CLASSIFIER wildfly10
ENV KIE_CONTEXT_PATH kie-wb
ENV KIE_SERVER_PROFILE standalone-full
ENV CHTIJBUG_VERSION 2.0.10
# Do NOT use demo neither examples by default in this image (no internet connection required).
ENV KIE_DEMO false
ENV JAVA_OPTS -Xms256m -Xmx512m



####### DROOLS-WB ############


RUN curl $CHTIJBUG_REPOSITORY/org/chtijbug/drools/drools-framework-kie-wb-wars/$CHTIJBUG_VERSION/drools-framework-kie-wb-wars-$CHTIJBUG_VERSION.war -o /opt/jboss/wildfly/standalone/deployments/$KIE_CONTEXT_PATH.war

#RUN curl -o $HOME/$KIE_CONTEXT_PATH.war $KIE_REPOSITORY/org/kie/kie-drools-wb-distribution-wars/$KIE_VERSION/kie-drools-wb-distribution-wars-$KIE_VERSION-$KIE_CLASSIFIER.war && \
#unzip -q $HOME/$KIE_CONTEXT_PATH.war -d $JBOSS_HOME/standalone/deployments/$KIE_CONTEXT_PATH.war &&  \
#touch $JBOSS_HOME/standalone/deployments/$KIE_CONTEXT_PATH.war.dodeploy &&  \
# rm -rf $HOME/$KIE_CONTEXT_PATH.war

####### MVN REPO ############
# https://bugzilla.redhat.com/show_bug.cgi?id=1263738
RUN mkdir -p $HOME/.m2/repository/org/guvnor/guvnor-asset-mgmt-project/$KIE_VERSION && \
curl -o $HOME/.m2/repository/org/guvnor/guvnor-asset-mgmt-project/$KIE_VERSION/guvnor-asset-mgmt-project-$KIE_VERSION.jar $KIE_REPOSITORY/org/guvnor/guvnor-asset-mgmt-project/$KIE_VERSION/guvnor-asset-mgmt-project-$KIE_VERSION.jar

####### SCRIPTS ############
USER root
ADD etc/start_drools-wb.sh $JBOSS_HOME/bin/start_drools-wb.sh
RUN chown jboss:jboss $JBOSS_HOME/bin/start_drools-wb.sh



####### ENVIRONMENT ############
# Use demo and examples by default in this showcase image (internet connection required).
ENV KIE_DEMO false
ENV KIE_SERVER_PROFILE standalone-full-drools

####### EXPOSE INTERNAL JBPM GIT PORT ############
EXPOSE 8001

####### Drools Workbench CUSTOM CONFIGURATION ############
ADD etc/standalone-full-drools.xml $JBOSS_HOME/standalone/configuration/standalone-full-drools.xml
ADD etc/drools-users.properties $JBOSS_HOME/standalone/configuration/drools-users.properties
ADD etc/drools-roles.properties $JBOSS_HOME/standalone/configuration/drools-roles.properties

# Added files are chowned to root user, change it to the jboss one.
USER root
RUN chown jboss:jboss $JBOSS_HOME/standalone/configuration/standalone-full-drools.xml && \
chown jboss:jboss $JBOSS_HOME/standalone/configuration/drools-users.properties && \
chown jboss:jboss $JBOSS_HOME/standalone/configuration/drools-roles.properties

# Switchback to jboss user
USER root
RUN yum install -y git
RUN mkdir /home/db
RUN mkdir /home/lucene
RUN mkdir /home/niodir
RUN mkdir /home/kie-example
RUN chown jboss:jboss /home/db
RUN chown jboss:jboss /home/lucene
RUN chown jboss:jboss /home/niodir
RUN chown jboss:jboss /home/kie-example
RUN cd /home/kie-example && git clone https://github.com/chtiJBUG/onboarding-nautic-project.git
RUN cd /home/kie-example && git clone https://github.com/chtiJBUG/onboarding-carinsurance-project.git
RUN cd /home/kie-example && git clone https://github.com/chtiJBUG/onboarding-loyalty-project.git
####### EXPOSE INTERNAL JBPM GIT PORT ############
EXPOSE 8001

####### RUNNING DROOLS-WB ############
VOLUME /home/db
VOLUME /home/lucene
VOLUME /home/niodir
WORKDIR $JBOSS_HOME/bin/
CMD ["./start_drools-wb.sh"]
