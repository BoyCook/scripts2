#!/bin/bash 
#
#Maven install artifact code
# $Id$

function die() {
     echo $*
     exit 1
}

mvn install:install-file -Dfile=starteam100.jar -DgroupId=com.starbase.starteam -DartifactId=starteam -Dversion=2008 -Dpackaging=jar -DgeneratePom=true
mvn install:install-file -Dfile=ServicesUtils.jar -DgroupId=com.borland.ukservices -DartifactId=services-utils -Dversion=1.0.0 -Dpackaging=jar -DgeneratePom=true

repo='http://craigcook.co.uk/artefacts/content/repositories/thirdparty'

# mvn deploy:deploy-file -Durl=$repo -DrepositoryId=cccs-thirdparty -Dfile=apache-tomcat-6.0.26.tar.gz -DgroupId=org.apache -DartifactId=apache-tomcat -Dversion=6.0.26 -Dpackaging=tar.gz -DgeneratePom=true
# mvn deploy:deploy-file -Durl=$repo -DrepositoryId=cccs-thirdparty -Dfile=apache-tomcat-6.0.24.tar.gz -DgroupId=org.apache -DartifactId=apache-tomcat -Dversion=6.0.24 -Dpackaging=tar.gz -DgeneratePom=true
# mvn deploy:deploy-file -Durl=$repo -DrepositoryId=cccs-thirdparty -Dfile=oracle-jdbc-10.1.0.2.0.jar -DgroupId=oracle -DartifactId=oracle-jdbc -Dversion=10.1.0.2.0 -Dpackaging=jar -DgeneratePom=true
mvn deploy:deploy-file -Durl=$repo -DrepositoryId=cccs-thirdparty -Dfile=hudson.war -DgroupId=hudson -DartifactId=hudson -Dversion=1.353 -Dpackaging=war -DgeneratePom=true
