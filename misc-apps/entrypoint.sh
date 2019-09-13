#!/bin/bash

 
##### INSERT ENTRYPOINT COMMANDS BELOW

echo "Running MiscApps Docker entrypoint"


# Set concat of pod namespace and last 5 characters of the pod name as hazelcast client label
#echo "Retrieving Hazelcast client label information"
#if [ "$MY_POD_NAME" != "" -a "$MY_POD_NAMESPACE" != "" ]; then
#  echo "MY_POD_NAME and MY_POD_NAMESPACE detected, setting Hazelcast client label"
#  export MY_POD_SHORT_NAME=`echo $MY_POD_NAME | sed -r 's/.*(.....$)/\1/g'`
#  sed -i -r "s/(hazelcast-client-config-[[:digit:]]*\.[[:digit:]]*\.xsd.>)/\1\n\n  <client-labels>\n    <label>$MY_POD_NAMESPACE-$MY_POD_SHORT_NAME<\/label>\n  <\/client-labels>/gm" /opt/ibm/wlp/usr/shared/config/hazelcast/hazelcast.xml
#fi

##### INSERT ENTRYPOINT COMMANDS ABOVE

 
# Execute docker-server.sh script from base Liberty image. THIS SHOULD ALWAYS BE LAST.
echo "Starting defaultServer"

#/opt/ibm/helpers/runtime/docker-server.sh /opt/ibm/wlp/bin/server debug defaultServer
/opt/ibm/helpers/runtime/docker-server.sh /opt/ibm/wlp/bin/server run defaultServer
 