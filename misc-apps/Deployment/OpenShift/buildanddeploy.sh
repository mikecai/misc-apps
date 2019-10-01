#!/bin/bash +x
set -e


# Check for required arguments
if [ $# -lt 2 ]; then
    printf "\n"
    printf "No arguments provided\n"
    printf "Usage:\n"
    printf "    buildanddeploy.sh <username> <password>\n\n"
    exit 1
fi

 

set -x

WORK_DIR="$( cd -L "$( dirname "${BASH_SOURCE[0]}" )"/../.. && pwd )"

# Create Security Account Constraints
oc apply -f $WORK_DIR/Deployment/OpenShift/ssc.yaml

# Create projects
oc create -f $WORK_DIR/Deployment/OpenShift/liberty-projects.yaml

# Create service accounts
oc create serviceaccount websphere -n misc-apps-liberty-dev
oc create serviceaccount websphere -n misc-apps-liberty-stage
oc create serviceaccount websphere -n misc-apps-liberty-prod
oc adm policy add-scc-to-user ibm-websphere-scc -z websphere -n misc-apps-liberty-dev
oc adm policy add-scc-to-user ibm-websphere-scc -z websphere -n misc-apps-liberty-stage
oc adm policy add-scc-to-user ibm-websphere-scc -z websphere -n misc-apps-liberty-prod

# Deploy Jenkins
oc project misc-apps-liberty-build
oc new-app jenkin-persistent

# Update Jenkins service accounts
oc policy add-role-to-user edit system:serviceaccount:misc-apps-liberty-build:jenkins -n misc-apps-liberty-dev
oc policy add-role-to-user edit system:serviceaccount:misc-apps-liberty-build:jenkins -n misc-apps-liberty-stage
oc policy add-role-to-user edit system:serviceaccount:misc-apps-liberty-build:jenkins -n misc-apps-liberty-prod

# Import deployment templates
oc create -f $WORK_DIR/Deployment/OpenShift/template-liberty-deploy.yaml -n misc-apps-liberty-dev
oc create -f $WORK_DIR/Deployment/OpenShift/template-liberty-deploy.yaml -n misc-apps-liberty-stage
oc create -f $WORK_DIR/Deployment/OpenShift/template-liberty-deploy.yaml -n misc-apps-liberty-prod

# Create deployment definitions
oc new-app gse-liberty-deploy -p APPLICATION_NAME=misc-apps-liberty -n misc-apps-liberty-dev 
oc new-app gse-liberty-deploy -p APPLICATION_NAME=misc-apps-liberty -n misc-apps-liberty-stage
oc new-app gse-liberty-deploy -p APPLICATION_NAME=misc-apps-liberty -n misc-apps-liberty-prod

# Import build template
oc create -f $WORK_DIR/Deployment/OpenShift/template-liberty-build.yaml -n misc-apps-liberty-build

# Create build definitions
oc new-app gse-liberty-build -p APPLICATION_NAME=misc-apps-liberty -p SOURCE_URL="https://github.com/mikecai/misc-apps" -n misc-apps-liberty-build



