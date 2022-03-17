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
Use signal_watcher2.yaml to test it


<details close>
<summary> Solution</summary>
<br>

1. The post-start hook is blocking
2. The pre-stop hook is not blocking, the pod will be killed after grace-period expire
3. The developer has the key, the orchestator (=kubelet) can't know what stage the app is and need to take a decission, as late after grace-period.
4. Yes, the TERM signal is propagated to all containers (pid=1), but be aware that you must ensure it reaches all the processes running in your containers. 