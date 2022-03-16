.ONESHELL:
SHELL = /usr/bin/bash

apply:
	kubectl create cm signal-watcher --from-file=scripts/
	kubectl create -f signal_watcher.yaml

apply2:
	kubectl create cm signal-watcher --from-file=scripts/
	kubectl create -f signal_watcher2.yaml

clean:
	-kubectl delete -f signal_watcher.yaml
	-kubectl delete -f signal_watcher2.yaml
	-kubectl delete cm signal-watcher

rebuild: clean apply

rebuild2: clean apply2

logs:
	pod=`kubectl get pod -l app=signal-watcher -o json | jq -r .items[0].metadata.name`;
	kubectl logs -f $$pod

ps:
	pod=`kubectl get pod -l app=signal-watcher -o json | jq -r .items[0].metadata.name`;
	watch -n 1 kubectl exec -it $$pod -- ps -ef

pods: 
	watch -n 1 kubectl get pod -l app=signal-watcher
kill:
	@pod=`kubectl get pod -l app=signal-watcher -o json | jq -r .items[0].metadata.name`
	@kubectl delete pod $$pod --grace-period=12

	
