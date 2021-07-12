#!/bin/bash
set -ex
docker build -t harbor.avm.de/openshift/ovn-kubernetes:egressip-bugfix-${1} -f Dockerfile_2 .
docker push harbor.avm.de/openshift/ovn-kubernetes:egressip-bugfix-${1}
oc adm release new --from-release quay.io/openshift/okd:4.7.0-0.okd-2021-08-22-163618 --to-image harbor.avm.de/openshift/okd-egressip-bugfix:4.7.0-0.okd-2021-08-22-163618-avm-${1} ovn-kubernetes=harbor.avm.de/openshift/ovn-kubernetes:egressip-bugfix-${1}
oc adm upgrade --to-image=harbor.avm.de/openshift/okd-egressip-bugfix:4.7.0-0.okd-2021-08-22-163618-avm-${1} --force --allow-explicit-upgrade
