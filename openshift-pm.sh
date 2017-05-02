export http_proxy=http://192.168.11.17:8080
export https_proxy=http://192.168.11.17:8080
export no_proxy=localhost,127.0.0.1,172.20.55.227,172.30.1.1,172.20.56.28

export KUBECONFIG=/var/lib/origin/openshift.local.config/master/admin.kubeconfig
export CURL_CA_BUNDLE=/var/lib/origin/openshift.local.config/master/ca.crt
chmod +r /var/lib/origin/openshift.local.config/master/admin.kubeconfig
oc cluster up --http-proxy=http://192.168.11.17:8080 --https-proxy=http://192.168.11.17:8080 --no-proxy='localhost,127.0.0.1,172.30.0.0/16,172.20.0.0/16,172.17.0.0/16'
oc login -u system:admin
oc delete is --all -n openshift
oc create -f https://raw.githubusercontent.com/openshift/origin/master/examples/image-streams/image-streams-rhel7.json -n openshift
oc create -f https://raw.githubusercontent.com/jboss-openshift/application-templates/master/jboss-image-streams.json -n openshift

oc create -f  https://raw.githubusercontent.com/jkurisu/openshift/master/productmachine-images.json -n openshift

oc create -f https://raw.githubusercontent.com/jkurisu/openshift/master/productmachine.json -n openshift

###oadm policy add-scc-to-group anyuid system:authenticated

oc login -u developer -p developer
oc new-project dev --display-name="Tasks - Dev"
oc new-project stage --display-name="Tasks - Stage"
oc new-project cicd --display-name="CI/CD"
oc policy add-role-to-user edit system:serviceaccount:cicd:jenkins -n dev
oc policy add-role-to-user edit system:serviceaccount:cicd:jenkins -n stage
oc policy add-role-to-user edit system:serviceaccount:cicd:jenkins -n cicd
oc project cicd
oc process -f https://raw.githubusercontent.com/jkurisu/openshift/fja/openshift-cicd-pm-template.yaml | oc create -f -
