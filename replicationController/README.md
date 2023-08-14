### Replication Controller
```sh
•	A replication controller is an object that enables you to easily create multiple pods as per the requirement and
also make sure that the numbers pods always exist.
•	In the yaml we need to mention kind as replication controller, then in that case k8s creates the pods and
plus make sure that pod count is same as replicas value mentioned in the yaml file.
We need to mention the value in replicas how many no of pods will be created.
•	If a pod created using RC then it will be automatically replaced if they crash, failed or terminated.
•	RC is recommended if you just want to make sure 1 pod is always running, even after the system reboots.
•	You can run the RC with 1 replica and the RC will make sure the pod is always running.
```

