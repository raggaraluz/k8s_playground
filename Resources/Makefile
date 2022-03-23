.ONESHELL:
.SILENT:
SHELL = /usr/bin/bash
NS="playground"
apply:
	kubectl -n ${NS} create -f SampleApp.yaml

clean:
	-kubectl -n ${NS} delete -f SampleApp.yaml

rebuild: clean apply

resources:
	echo "- Request/Limits values:"
	kubectl -n ${NS} get pod -l app=sample-app -o json | jq .items[].spec.containers[].resources
	echo "- QoS values:"
	kubectl -n ${NS} get pod -l app=sample-app -o json | jq .items[].status.qosClass

stress-low:
	pod=`kubectl get pod -l app=sample-app -o json | jq -r .items[0].metadata.name`;
	kubectl exec -it $$pod -- nohup stress -c 1 -m 1 --vm 512000 &    # 500KB

stress-hard:
	pod=`kubectl get pod -l app=sample-app -o json | jq -r .items[0].metadata.name`;
	kubectl exec -it $$pod -- nohup stress -c 4 -m 4 &

stress-off:
	pod=`kubectl get pod -l app=sample-app -o json | jq -r .items[0].metadata.name`;
	kubectl exec -it $$pod -- pkill stress

describe:
	pod=`kubectl get pod -l app=sample-app -o json | jq -r .items[0].metadata.name`;
	kubectl describe pod $$pod

watch:
	pod=`kubectl get pod -l app=sample-app -o json | jq -r .items[0].metadata.name`;
	watch -n 1 kubectl exec -it $$pod -- ps -ef

monitor:
	watch -n 2 kubectl top pod -l app=sample-app

top:
	pod=`kubectl get pod -l app=sample-app -o json | jq -r .items[0].metadata.name`;
	kubectl exec -it $$pod -- top -d 5

httping:
	pod=`kubectl get pod -l app=sample-app -o json | jq -r .items[0].metadata.name`;
	kubectl exec -it $$pod -- httping my-http-server -t 2 -F -s
