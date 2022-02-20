# RBAC exercise

## Scenario One:
- We were asked to deploy a mysql instance that uses a secret named "database-access" to set credentials.
- User Dave (context=dave), as developer must be able only to manage deployments and pods in namespace "staging". To make him able to troubleshoot issues allow him also the capability to watch console output.
- User Bob (context=bob), as DBA must be the unique user who can view/manage secrent named "database-access" in namespaces "staging" and "production"
- A serviceaccount named "spinnaker" must be able to deploy the resources created by Dave and Bob in "production" namespace.

Questions:
1. Can we grant Dave permission to create secrets without expossing the dabase credentials?
2. Is database secret really secured in this scene?, what do we have to change to make it really secure?
