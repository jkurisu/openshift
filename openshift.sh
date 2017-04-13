export KUBECONFIG=/var/lib/origin/openshift.local.config/master/admin.kubeconfig
export CURL_CA_BUNDLE=/var/lib/origin/openshift.local.config/master/ca.crt
chmod +r /var/lib/origin/openshift.local.config/master/admin.kubeconfig
oc cluster up
oc login -u system:admin
oc delete is --all -n openshift
oc create -f https://raw.githubusercontent.com/openshift/origin/master/examples/image-streams/image-streams-rhel7.json -n openshift
oc create -f https://raw.githubusercontent.com/jboss-openshift/application-templates/master/jboss-image-streams.json -n openshift
oc login -u developer -p developer
oc new-project dev --display-name="Tasks - Dev"
oc new-project stage --display-name="Tasks - Stage"
oc new-project cicd --display-name="CI/CD"
oc policy add-role-to-user edit system:serviceaccount:cicd:jenkins -n dev
oc policy add-role-to-user edit system:serviceaccount:cicd:jenkins -n stage
oc policy add-role-to-user edit system:serviceaccount:cicd:jenkins -n cicd
oc project cicd
oc process -f https://raw.githubusercontent.com/OpenShiftDemos/openshift-cd-demo/origin-1.4/cicd-template.yaml | oc create -f -
