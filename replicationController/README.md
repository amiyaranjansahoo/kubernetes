### Replication Controller
```sh
1. A replication controller is an object that enables you to easily create multiple pods as per the requirement and
   also make sure that the numbers pods always exist.
2. In the yaml we need to mention kind as replication controller, then in that case k8s creates the pods and
   plus make sure that pod count is same as replicas value mentioned in the yaml file.
3. We need to mention the value in replicas how many no of pods will be created.
4. If a pod created using RC then it will be automatically replaced if they crash, failed or terminated.
5. RC is recommended if you just want to make sure 1 pod is always running, even after the system reboots.
6. You can run the RC with 1 replica and the RC will make sure the pod is always running.
```

