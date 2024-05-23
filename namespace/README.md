
### What is a Kubernetes Namespace?
![image](https://github.com/amiyaranjansahoo/kubernetes/assets/24844782/38933287-5a64-4590-9d06-88a1a7fffa7d)

```sh
A Kubernetes namespace helps separate a cluster into logical units. It helps granularly organize, allocate,
manage, and secure cluster resources. Here are two notable use cases for Kubernetes namespaces:

In a new cluster, Kubernetes automatically creates the following namespaces: default (for user workloads) and
three namespaces for the Kubernetes control plane: kube-node-lease, kube-public, and kube-system.
Kubernetes also allows admins to manually create custom namespaces.
```
### Kubernetes Namespaces Concepts
```sh
There are two types of Kubernetes namespaces: 
Kubernetes system namespaces and custom namespaces.
```
#### Default Kubernetes namespaces
```sh
Here are the four default namespaces Kubernetes creates automatically:

default-The default namespace for objects with no other namespace
kube-node-lease This namespace holds Lease objects associated with each node.
Node leases allow the kubelet to send heartbeats so that the control plane
can detect node failure.
kube-public This namespace is created automatically and is readable by all
users (including those not authenticated). This namespace is mostly reserved
for cluster usage, in case that some resources should be visible and readable
publicly throughout the whole cluster. The public aspect of this namespace is only a convention,
not a requirement.
kube-system The namespace for objects created by the Kubernetes system
```
#### Custom Kubernetes namespaces
```sh
Admins can create as many Kubernetes namespaces as necessary to isolate workloads or
resources and limit access to specific users. 
```
#### Here is how to create a namespace using kubectl:
```sh
kubectl create ns mynamespace
```
#### Create namespace using the declarative approach
```sh
apiVersion: v1
kind: Namespace
metadata:
  name: <insert-namespace-name-here>
```
#### How do you switch between Kubernetes namespaces?
```sh
kubectl config set-context --current --namespace=dev
```
#### How to identify the current namespace
```sh
kubectl config get-contexts
```

#### When Should You Use Multiple Kubernetes Namespaces?
```sh
In small projects or teams, where there is no need to isolate workloads or users from each other,
it can be reasonable to use the default Kubernetes namespace. Consider using multiple namespaces for the following reasons:

Isolation—if you have a large team, or several teams working on the same cluster, you can use namespaces to create
separation between projects and microservices. Activity in one namespace never affects the other namespaces.

Development stages—if you use the same Kubernetes cluster for multiple stages of the development lifecycle,
it is a good idea to separate development, testing, and production environments. You do not want errors or
instability in testing environments to affect production users. Ideally, you should use a separate cluster
for each environment, but if this is not possible, namespaces can create this separation.

Permissions—it might be necessary to define separate permissions for different resources in your cluster.
You can define separate RBAC rules for each namespace, ensuring that only authorized roles can access
the resources in the namespace. This is especially important for mission critical applications,
and to protect sensitive data in production deployments.

Resource control—you can define resource limits at the namespace level, ensuring each namespace has access
to a certain amount of CPU and memory resources. This enables separating cluster resources among several
projects and ensuring each project has the resources it needs, leaving sufficient resources for other projects.

Performance—Kubernetes API provides better performance when you define namespaces in the cluster.
This is because the API has less items to search through when you perform specific operations.
```

![image](https://github.com/amiyaranjansahoo/kubernetes/assets/24844782/2d93903c-c934-4194-b46a-387da97e5b85)
