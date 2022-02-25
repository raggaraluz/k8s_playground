apply:
	kubectl create cm pyweb-script --from-file=pyweb.py --dry-run=client -o yaml > pyweb-script.yaml 
	kubectl create cm httping-script --from-file=httping.py --dry-run=client -o yaml > httping-script.yaml
	kubectl create -f pyweb-script.yaml 
	kubectl create -f httping-script.yaml
	kubectl create -f pyweb.yaml
	kubectl create -f httping.yaml
	kubectl label cm httping-script app=pyweb
	kubectl label cm pyweb-script app=pyweb

clean:
	-kubectl delete deployments -l app=pyweb
	-kubectl delete pod -l app=pyweb --force --grace-period=0
	-kubectl delete svc -l app=pyweb
	-kubectl delete cm -l app=pyweb

redeploy: clean apply
	

watch1:
	kubectl exec -it pyweb-ping -- python /tmp/httping.py

watch2:
	watch -n 1 "kubectl get endpoints,pod | grep pyweb"


