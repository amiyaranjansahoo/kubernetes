
### What is a Kubernetes Namespace?
![image](https://github.com/amiyaranjansahoo/kubernetes/assets/24844782/38933287-5a64-4590-9d06-88a1a7fffa7d)

```sh
A Kubernetes namespace helps separate a cluster into logical units. It helps granularly organize, allocate,
manage, and secure cluster resources. Here are two notable use cases for Kubernetes namespaces:

Apply policies to cluster segments—Kubernetes namespaces let you apply policies to different parts of a cluster.
For example, you can define resource policies to limit resource consumption. You can also use container network
interfaces (CNIs) to apply network policies that define how communication is achieved between pods in each namespace.
Learn more about Kubernetes networking.
Apply access controls—namespaces let you define role-based access control (RBAC). You can define a role object type
and assign it using role binding. The role you define is applied to a namespace, and RoleBinding is applied to
specific objects within this namespace. Using this technique can help you improve the security of your cluster.

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

default—a default space for objects that do not have a specified namespace.
kube-system—a default space for Kubernetes system objects, such as kube-dns and kube-proxy, and add-ons
providing cluster-level features, such as web UI dashboards, ingresses, and cluster-level logging.
kube-public—a default space for resources available to all users without authentication.
kube-node-lease—a default space for objects related to cluster scaling.
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
#### How do you switch between Kubernetes namespaces?
```sh
kubectl config set-context --current --namespace=dev
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
