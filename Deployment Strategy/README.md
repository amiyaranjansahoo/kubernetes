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
•	Ramped slow rollout: Rolls out replicas of the new version, while in parallel, shutting down old replicas. 
•	Best-effort controlled rollout: Specifies a “max unavailable” parameter which indicates what percentage of existing pods
        can be unavailable during the upgrade, enabling the rollout to happen much more quickly.
•	Canary deployment: It uses a progressive delivery approach, with one version of the application serving most users, and another,
        newer version serving a small pool of test users. The test deployment is rolled out to more users if it is successful.
```
