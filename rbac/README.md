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
source ~/.bashrc
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
  
Create namespaces
```
k create ns staging
k create ns production
```
Create roles and bindings
```
k create clusterrole myapp1:dev-role --resource=deployments,pods,pods/log --verb='*' --resource=events --verb=get,watch
k label clusterrole myapp1:dev-role app=myapp1
k create clusterrole myapp1:dba-role --resource=secrets --verb='*'
k label clusterrole myapp1:dba-role app=myapp1
k get clusterroles -l app=myapp1

k -n staging create rolebinding dev-users --clusterrole=myapp1:dev-role --group=dev
k -n production create rolebinding dba-users --clusterrole=myapp1:dba-role --group=dba
k -n staging create rolebinding dba-users --clusterrole=myapp1:dba-role --group=dba

k -n staging get pods --as dave --as-group dev

kubectx dave
k config set-context --current --namespace staging
k -n staging create -f mysql01.yaml

kubectx bob
k config set-context --current --namespace staging
k -n staging create -f access-database-secret.yaml

kubectx kubernetes-admin@kubernetes
k -n production create sa spinnaker-sa
k -n production create rolebinding spinnaker-sa-binding --clusterrole=admin --serviceaccount=production:spinnaker-sa
```
Check we have admin permissions
```
k auth can-i --list -n production --as system:serviceaccount:production:spinnaker-sa
```
1. Can we grant Dave permission to create secrets without expossing the dabase credentials?    
Not in the same namespace, rbac in k8s doesn't allow us to set deny rules, only allow ones.To bypass this limitation we must relay on [AdmissionControllers](https://kubernetes.io/docs/reference/access-authn-authz/extensible-admission-controllers/)

2. Is database secret really secured in this scene?, what do we have to change to make it really secure?    
Not really, as you allow Dave to create pods and watch logs he can create a new pod that mounts the database secret and dumps the value to console.
```
cat <<EOF | kubectl apply -f -
apiVersion: v1
kind: Pod
metadata:
  name: hack
spec:
  containers:
  - args:
    - env
    image: mirror.gcr.io/library/alpine
    name: hack
    envFrom:
    - secretRef:
        name: database-access
EOF

k logs hack | grep -i mysql
```
Without special functionality you can't keep hidden any secret in any namespace where Dave can create containers. Although you remove the capability to watch logs it could be dumped by your corporate logging collector. But you could have a validating web-hook (like Open Policy Agent) configured to intercept all pod creation request coming to Kubernetes API Server. With OPA policies you can only allow the pod creation request if pod spec does not have any invalid or unwanted secrets otherwise it rejects the pod creation request.
Another related restriction to bear in mind is that a pod only can mount secrets created in the same namespace it runs.
