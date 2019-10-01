## For URIBuilder NCDFE:

execute:
  `mvn integration-test`


## OpenShift Deployment

1. Create Security Context Constraint

	1. Create `scc.yaml` file

	2. Run command:
	
		`oc apply -f $WORK_DIR/Deployment/OpenShift/scc.yaml`

2. Create application project(s)

	1. Create `liberty-projects.yaml` file
	
	2. Run command:
	
		`oc create -f $WORK_DIR/Deployment/OpenShift/liberty-projects.yaml`
		
3. Create service account(s) for project(s)

	Run commands:
	
		```
		oc create serviceaccount websphere -n misc-apps-liberty-dev
		oc create serviceaccount websphere -n misc-apps-liberty-stage
		oc create serviceaccount websphere -n misc-apps-liberty-prod
		oc adm policy add-scc-to-user ibm-websphere-scc -z websphere -n misc-apps-liberty-dev
		oc adm policy add-scc-to-user ibm-websphere-scc -z websphere -n misc-apps-liberty-stage
		oc adm policy add-scc-to-user ibm-websphere-scc -z websphere -n misc-apps-liberty-prod
		```
		
4. Deploy Jenkins Instance (if not already provisioned)

	Run commands:
	
	```
	oc project misc-apps-liberty-build
	oc new-app jenkin-persistent
	```
5. Update Jenkins service account

	Run commands:
	
	```
	oc policy add-role-to-user edit system:serviceaccount:misc-apps-liberty-build:jenkins -n misc-apps-liberty-dev
	oc policy add-role-to-user edit system:serviceaccount:misc-apps-liberty-build:jenkins -n misc-apps-liberty-stage
	oc policy add-role-to-user edit system:serviceaccount:misc-apps-liberty-build:jenkins -n misc-apps-liberty-prod
	```
	
6. Import the deployment templates

	Run commands:
	
	```
	oc create -f $WORK_DIR/Deployment/OpenShift/template-liberty-deploy.yaml -n misc-apps-liberty-dev
	oc create -f $WORK_DIR/Deployment/OpenShift/template-liberty-deploy.yaml -n misc-apps-liberty-stage
	oc create -f $WORK_DIR/Deployment/OpenShift/template-liberty-deploy.yaml -n misc-apps-liberty-prod
	```
	
7. Create deployment definitions

	Run commands:

	```
	oc new-app gse-liberty-deploy -p APPLICATION_NAME=misc-apps-liberty -n misc-apps-liberty-dev 
	oc new-app gse-liberty-deploy -p APPLICATION_NAME=misc-apps-liberty -n misc-apps-liberty-stage
	oc new-app gse-liberty-deploy -p APPLICATION_NAME=misc-apps-liberty -n misc-apps-liberty-prod
	```
	
8. Import build template

	Run commands:
	
	`oc create -f $WORK_DIR/Deployment/OpenShift/template-liberty-build.yaml -n misc-apps-liberty-build`
	
	
	
