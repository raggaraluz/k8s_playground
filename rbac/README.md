# RBAC exercises

## Scenario One:
- We were asked to deploy a mysql instance as a k8s deployment who uses a secret named "database-access" to set credentials.
- User Dave (context=dave), as developer must be able only to manage deployments and pods in namespace "staging" 
- User Bob (context=bob), as DBA must be the unique user who can view/manage secrents named "database-access" in namespaces "staging" and "production"
- A serviceaccount named "spinnaker" must be able to deploy from your git repo the yaml file with Dave's deployment in "production" namespace.

