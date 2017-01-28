#!/usr/bin/env bash

# Start Wildfly with the given arguments.
echo "Running Drools Workbench on JBoss Wildfly..."
exec ./standalone.sh -b $JBOSS_BIND_ADDRESS -c $KIE_SERVER_PROFILE.xml -Dorg.kie.demo=$KIE_DEMO -Dorg.kie.example=$KIE_DEMO -Dorg.kie.example.repositories=/home/kie-example -Dorg.kie.example=true -Dorg.uberfire.metadata.index.dir=/home/lucene -Dorg.uberfire.nio.git.daemon.host=0.0.0.0 -Dorg.guvnor.m2repo.dir=$JBOSS_HOME/.m2/repository -DM2_HOME==$JBOSS_HOME/.m2/repository -Dorg.uberfire.nio.git.dir=/home/niodir -Derrai.bus.enable_sse_support=false
exit $?



