FROM ubuntu:14.04

# Based on work by Carlos Moro
MAINTAINER Carlos Moro <cmoro@deusto.es>
MAINTAINER KikoV <kikov@kikov.org>

ENV TOMCAT_VERSION 9.0.0.M21

# Set locales
RUN locale-gen es_ES.UTF-8
ENV LANG es_ES.UTF-8
ENV LC_CTYPE es_ES.UTF-8

# Fix sh
RUN rm /bin/sh && ln -s /bin/bash /bin/sh

# Install dependencies
RUN apt-get update
RUN apt-get install -y git build-essential curl wget software-properties-common

# Install JDK 8
RUN \
echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | debconf-set-selections && \
add-apt-repository -y ppa:webupd8team/java && \
apt-get update && \
apt-get install -y oracle-java8-installer wget unzip tar && \
rm -rf /var/lib/apt/lists/* && \
rm -rf /var/cache/oracle-jdk8-installer

# Define commonly used JAVA_HOME variable
ENV JAVA_HOME /usr/lib/jvm/java-8-oracle

# Get Tomcat
RUN wget --quiet --no-cookies http://apache.rediris.es/tomcat/tomcat-9/v${TOMCAT_VERSION}/bin/apache-tomcat-${TOMCAT_VERSION}.tar.gz -O /tmp/tomcat.tgz && \
tar xzvf /tmp/tomcat.tgz -C /opt && mv /opt/apache-tomcat-${TOMCAT_VERSION} /opt/tomcat

# Remove garbage
RUN rm /tmp/tomcat.tgz && rm -rf /opt/tomcat/webapps/examples && rm -rf /opt/tomcat/webapps/docs && rm -rf /opt/tomcat/webapps/ROOT

# Add admin/admin user
ADD tomcat-users.xml /opt/tomcat/conf/

ENV CATALINA_HOME /opt/tomcat
ENV PATH $PATH:$CATALINA_HOME/bin

EXPOSE 8080
EXPOSE 8009
EXPOSE 4110
#VOLUME "/opt/tomcat/webapps"
WORKDIR /opt/tomcat

CMD /opt/tomcat/bin/run.sh
