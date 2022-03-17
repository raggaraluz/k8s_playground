# Application development
## Pod Lifecycle

Create the environment in your k8s instance and start demo app
```
git clone https://github.com/davidp1404/k8s_playground.git
cd k8s_playground/
./set-env.sh
cd PodLifeCycle
make apply

$ k get pod --show-labels 
NAME                              READY   STATUS        RESTARTS   AGE   LABELS
signal-watcher-574c45486f-4vslt   1/1     Running       0          31s   app=signal-watcher,pod-template-hash=574c45486f
```
Start a new terminal and execute:
```
$ make logs
pod=`kubectl get pod -l app=signal-watcher -o json | jq -r .items[0].metadata.name`;
kubectl logs -f $pod
Hello from the postStart handler
Hello, my pid is 1
Iteration #1
Iteration #2
Iteration #3
...
```
Previous window will show you when the pod receive the SIGTERM notification and when the app is able to flush data to disk.

Start another terminal and execute:
```
make kill     # Just issue a kubectl delete pod ..
```
Watch the secuence of messages of the different handlers.

Start another terminal and execute:
```
make ps     # Show processes running into the pod
```
Watch the secuence of messages of the different handlers.

## Play a little

1. What happend when the post-start script doesn't finish?    
Uncomment the "sleep infinity" line in the script

2. What happend when the pre-stop script doesn't finish?    
Uncomment the "sleep infinity" line in the script

3. What do you think is the best way to ensure that our pod flush data to disk before dying?

4. When I use a multicontainer pod, all this stuff applies to all of them?


<details close>
<summary> Solution</summary>
<br>

## Key points to highlight:
- If you don't set the readiness probe, the kubelet assumes that the app is ready to receive traffic as soon as the container starts.
- If the container takes 10 secons to start, all the requests to it will fail for those 10 seconds. 
- If the application reaches an unrecoverable error, you should let it crash quickly. A common best-practice if is to implement a full health check in your app returning an error code that tells k8s (kubelet) the container/pod is dead. If your app is vulnerable to deadlocks implements watchdog functions.
- Readiness probes delay setting conditions conditions to insertion of the pod in the service (endpoints join the pieces), but does nothing after it is added.
- Liveness probles monitor and restart pods along all its live.
- You must understand the [pod lifecycle](https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle/) to tune properly your app for minimal downtime. There are not single value definition that fits all cases.