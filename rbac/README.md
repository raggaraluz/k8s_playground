# RBAC exercise

## Scenario One:
- We were asked to deploy a mysql instance that uses a secret named "database-access" to set credentials.
- User Dave (context=dave), as developer must be able only to manage deployments and pods in namespace "staging". To let him able to troubleshoot issues allow the capability to watch console output but __not exec into the pod__.
- User Bob (context=bob), as DBA must be the unique user who can view/manage secrent named "database-access" in namespaces "staging" and "production"
- A serviceaccount named "spinnaker" must be able to deploy the resources created by Dave and Bob in "production" namespace.

Questions:
1. Can we grant Dave permission to create secrets without expossing the dabase credentials?
2. Is database secret really secured in this scene?, what do we have to change to make it really secure?

Start creating the katakoda environment and in the controlplane node execute:
```
git clone https://github.com/davidp1404/k8s_playground.git
cd k8s_playground
./set-env.sh
cd rbac
./enable-token-auth.sh
echo "Wait till kubectl shows the node list"
watch -n 5 kubectl get nodes
```
Two kubeconfig contexts were created, you can move between them with kubectx passing as parameter the selected context name.
You can change your default namespace with:
```
controlplane $ kubectx
bob
dave
kubernetes-admin@kubernetes

controlplane $ k config set-context --current --namespace staging
```

<details close>
<summary> Solution</summary>
<br>

EnCt2dcdffb404dfd67d91a9395289b6f90970c6aea24dcdffb404dfd67d91a939528e5WRcL4T0AD
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
iVuEr3fo4CVGhIwEmS

Decrypt it at https://encipher.it
