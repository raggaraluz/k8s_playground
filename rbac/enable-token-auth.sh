#!/bin/bash

cat <<EOF > /etc/kubernetes/pki/token-file.txt 
tkdave,dave,1000,"dev"
tkbob,bob,1001,"dba"
EOF
sed -i '/image:.*/i \ \ \ \ - --token-auth-file=/etc/kubernetes/pki/token-file.txt' /etc/kubernetes/manifests/kube-apiserver.yaml
