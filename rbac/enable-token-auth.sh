#!/bin/bash

cat <<EOF > /etc/kubernetes/pki/token-file.txt 
tkdave,dave,1000,"dev"
tkbob,bob,1001,"dba"
EOF
sed -i '/image:.*/i \ \ \ \ - --token-auth-file=/etc/kubernetes/pki/token-file.txt' /etc/kubernetes/manifests/kube-apiserver.yaml
kubectl config set-credentials bob --token=tkbob
kubectl config set-credentials dave --token=tkdave
kubectl config set-context bob --user=bob --cluster=kubernetes
kubectl config set-context dave --user=dave --cluster=kubernetes
