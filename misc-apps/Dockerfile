##### SOURCE COMPILATION #####
# IMAGE: Get the base image for maven build
# FROM maven:3.6-ibmjava-8 AS build-env
#
# COPY ./src /build/src
# COPY ./pom.xml /build/pom.xml 
#
# WORKDIR /build
# RUN mvn package -DskipTests
#
#
##### APP IMAGE BUILD #####
# IMAGE: Get the base image for Liberty
FROM websphere-liberty:kernel-ubi-min

USER 1001

# CONFIG: Add server configs
COPY --chown=1001:0 ./liberty/config/ /config/


# APP: Deploy application
COPY --chown=1001:0 ./target/*.war /config/apps/
 

# HAZELCAST:
## Enable HTTP/HTTPS and MP_MONITORING for detailed caching info in Hazelcast
## Management Center.  (Remove for PROD?)
ARG HTTP_ENDPOINT=false
ARG SSL=false
ARG MP_MONITORING=false
## Copy hazelcast libs JARs from official image.
# COPY --from=hazelcast/hazelcast:3.12 --chown=1001:0 /opt/hazelcast/lib/*.jar /opt/ibm/wlp/usr/shared/resources/hazelcast/
# Instruct configure.sh to copy the client topology hazelcast.xml
# ARG HZ_SESSION_CACHE=client

USER root
RUN chown -R 1001:0 /config /opt/ibm/wlp/usr/servers/defaultServer /opt/ibm/wlp/usr/shared/resources && \
    chmod -R g+rw /config /opt/ibm/wlp/usr/servers/defaultServer  /opt/ibm/wlp/usr/shared/resources

USER 1001
RUN configure.sh


# ENTRYPOINT:
USER root
COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

USER 1001
ENTRYPOINT ["entrypoint.sh"]
