# Network policy exercise

## Environment Preparation

It’s an example of an application with backend/frontend separated with namespaces and admin namespace which need to have access to both namespaces (frontend and backend)
- web pod(frontend) needs to talk with api pod(backend).
- must be an access to web pod from all namespaces.
- admin needs to have access to web/api pods.

Create frontend namespace and deploy web pod into:
```
$ kubectl create ns frontend
$ kubectl label namespaces frontend role=frontend
$ kubectl run web --image=nginx --labels=app=web --port 80 -n frontend
$ kubectl expose pod web --type=ClusterIP --port=80 -n frontend
```
Create backend namespace and deploy api pod into:
```
$ kubectl create ns backend
$ kubectl label namespaces backend role=backend
$ kubectl run api --image=nginx --labels=app=api --port 80 -n backend
$ kubectl expose pod api --type=ClusterIP --port=80 -n backend
```
Create admin namespace and deploy admin pod into:
```
$ kubectl create ns admin
$ kubectl label namespaces admin role=admin
$ kubectl run admin --image=nginx --labels=app=admin --port 80 -n admin
$ kubectl expose pod admin --type=ClusterIP --port=80 -n admin
```
Create test namespace and deploy test pod into:
```
$ kubectl create ns test
$ kubectl run test --image=nginx --labels=app=test --port 80 -n test
$ kubectl expose pod test --type=ClusterIP --port=80 -n test
```
This namespace/pod will be used for testing, no network policies will be installed to this namespace
Validate that connections between all pods in different namespaces permitted.
```
$ kubectl exec -it web -n frontend -- curl api.backend
$ kubectl exec -it web -n frontend -- curl admin.admin
$ kubectl exec -it admin -n admin -- curl web.frontend
$ kubectl exec -it admin -n admin -- curl api.backend
$ kubectl exec -it api -n backend -- curl web.frontend
$ kubectl exec -it api -n backend -- curl admin.admin
```
You must see ‘Welcome to nginx!’ reply in all cases.
## Exercises
Deny all traffic from all namespaces. Create Network policy and deploy to frontend/backend/admin namespaces.
You must see ‘Connection timed out’ instead of ‘Welcome nignx’
```
$ kubectl exec -it test -n test -- curl api.backend
$ kubectl exec -it test -n test -- curl admin.admin
$ kubectl exec -it test -n test -- curl web.frontend
```
Allow ingress in api pod from web pod. Create Network policy and deploy to backend namespace.
You must see ‘Welcome nignx’
```
$ kubectl exec -it web -n frontend -- curl api.backend
```
3. Allow ingress to web pod from all namespaces. Create Network policy and deploy to frontend namespace.

You must see ‘Welcome nignx’
```
$ kubectl exec -it test -n test -- curl web.frontend
```
Allow ingress in api/web pods for admin pod. Modify network policy of api pod and deploy it to backend namespace.
You must see ‘Welcome nignx’
```
$ kubectl exec -it admin -n admin -- curl api.backend
$ kubectl exec -it admin -n admin -- curl web.frontend
```
References:
- https://github.com/ahmetb/kubernetes-network-policy-recipes
- https://kubernetes.io/docs/concepts/services-networking/network-policies/


<details close>
<summary> Solution</summary>
<br>
  
Deny traffic from all namespaces.
```
kind: NetworkPolicy
apiVersion: networking.k8s.io/v1
metadata:
  name: deny-access-all-namespaces
spec:
  podSelector:
    matchLabels:
  ingress:
  - from:
    - podSelector: {}
```
2. Allow ingress in api pod from web pod.
```
kind: NetworkPolicy
apiVersion: networking.k8s.io/v1
metadata:
  name: allow-api-from-frontend
spec:
  podSelector:
    matchLabels:
      app: api
  ingress:
  - from:
    - namespaceSelector:
        matchLabels:
          role: frontend
```
3. Allow ingress in web from all namespaces.
```
kind: NetworkPolicy
apiVersion: networking.k8s.io/v1
metadata:
  name: allow-web-from-all-namespaces
spec:
  podSelector:
    matchLabels:
      app: web
  ingress:
  - from:
    - namespaceSelector: {}
```
4. Allow ingress in api/web pods for admin pod.
```
ingress:
  - from:
    - namespaceSelector:
        matchLabels:
          role: admin
```
You need add it to 2 (network policy for api), because web pod already allows ingress from all namespaces.
