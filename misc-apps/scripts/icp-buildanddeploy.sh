#!/bin/bash +x
set -e


# Check for required arguments
if [ $# -lt 2 ]; then
    printf "\n"
    printf "No arguments provided\n"
    printf "Usage:\n"
    printf "    icp-buildanddeploy.sh <username> <password>\n\n"
    exit 1
fi

 

set -x

 

# Usage: buildAndDeploy.sh <username> <password>
workingDir=$PWD
username=$1
password=$2
icp_repo="mycluster.icp:8500"
icp_namespace="mikecai"
docker_img_name="misc-apps"
docker_img_version="latest"
docker_tag="$icp_repo/$icp_namespace/$docker_img_name:$docker_img_version"
icp_host="mycluster.icp"
icp_port="8443"


#cp $workingDir/mvn-config/settings.xml $workingDir/settings.xml
docker build --rm $workingDir -t $docker_tag
#rm $workingDir/settings.xml
docker login $icp_repo -u $username -p $password
docker push $docker_tag


cloudctl login -a https://$icp_host:$icp_port -u $username -p $password -n $icp_namespace


#helm delete $docker_img_name --purge --tls
#sleep 10s
#helm install --name $docker_img_name -f $workingDir/icp/values.yaml  ibm-charts/ibm-websphere-liberty --tls 


helm upgrade --install --recreate-pods -f $workingDir/values.yaml $docker_img_name ibm-charts/ibm-websphere-liberty --tls 	#--version 1.10.0

 

# TEMP: WLP helm chart v1.9.0 patch for Hazelcast security roles (ISSUE #568)
#       https://github.ibm.com/WASCloudPrivate/roadmap-cloudpaks/issues/568
#       !!! Remove once fix is rolled into helm chart release !!!
#export NAMESPACE=$docker_namespace
#export HELM_RELEASE=$docker_name
#export ROLE=$(kubectl -n ${NAMESPACE} get role -l release=${HELM_RELEASE} -o=jsonpath='{.items[0].metadata.name}')
#kubectl -n ${NAMESPACE} patch role ${ROLE} --type json --patch '[{"op":"add","path":"/rules/0/resources/-","value":"pods"}]'
#kubectl -n ${NAMESPACE} get role ${ROLE} -o=yaml

sleep 5s
kubectl get pods

