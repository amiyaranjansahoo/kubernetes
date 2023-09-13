### What is Deployment Strategy
```sh
•	A Deployment strategy defines how to create, upgrade, or downgrade different versions of Kubernetes applications.
•	In a traditional software environment, deployments or upgrades to applications result in downtime and disruption
        of service.
•	Kubernetes can help avoid this, providing several Deployment strategies that let you perform rolling updates to
        multiple application instances, and avoid or minimize downtime.
```
### Types of Deployment Strategy
Below are different types of deployment stragey 
```sh
•	Recreate: Terminates all the pods and replaces them with the new version.
•	Rolling deployment: Replaces pods running the old version of the application with the new version, one by one, without
        downtime to the cluster.
•	Canary deployment: It uses a progressive delivery approach, with one version of the application serving most users, and another,
        newer version serving a small pool of test users. The test deployment is rolled out to more users if it is successful.
```
### Re-create Deployment
```sh
•	All existing Pods are killed before new ones are created
•	This will only guarantee Pod termination before new pod creation
•	Best for development environment
•	If you upgrade a Deployment, all Pods of the old revision will be terminated immediately. 
•	Successful removal is awaited before any Pod of the new revision is created.
```
### Rolling Deployment
```sh
•	A rolling deployment is the default deployment strategy in Kubernetes. 
•	It replaces the existing version of pods with a new version, updating pods slowly one by one, without cluster downtime. 
•	The rolling update uses a readiness probe to check if a new pod is ready, before starting to scale down pods with the old version. If there is a problem, you can stop an update and roll it back, without stopping the entire cluster. 
•	To perform a rolling update, simply update the image of your pods using kubectl set image. This will automatically trigger a rolling update.
•	To refine your deployment strategy, change the parameters in the spec:strategy section of your manifest file. There are two optional parameters—maxSurge and maxUnavailable: 
#### MaxSurge 
o	specifies the maximum number of pods the Deployment is allowed to create at one time. 
o	You can specify this as a whole number (e.g. 5), or as a percentage of the total required number of pods (e.g. 10%, always rounded up to the next whole number). 
o	If you do not set MaxSurge, the implicit, default value is 25%.
#### MaxUnavailable 
o	specifies the maximum number of pods that can be unavailable during the update process. 
o	Like MaxSurge, you can define it as an absolute number (5) or a percentage (10%) value. 
o	It can’t be 0, if MaxSurge is 0, that means both MaxSurge and MaxUnavailable can’t be 0 at a time
o	Default value is 25%
```
