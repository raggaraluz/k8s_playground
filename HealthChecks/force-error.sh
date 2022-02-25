kubectl exec -it $(kubectl get pod -l app=pyweb -o json | jq -r .items[0].metadata.name) -- rm /tmp/ok
