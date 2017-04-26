oc cluster up
oc login -u system:admin
oadm policy add-scc-to-group anyuid system:authenticated
oc create -f https://raw.githubusercontent.com/jkurisu/openshift/master/productmachine.json -n openshift
