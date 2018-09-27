# Join EKS Nodes

This terraform module creates the required local configuration for kubectl and aws-auth configmap and execute kubectl command to join the EKS nodes to the EKS cluster.

The Join EKS nodes module requires:

* An EKS Cluster, preferably created using the [EKS Cluster Module](https://github.com/overdrive3000/terraform_eks_cluster).
* The kubectl binary installed within the OS Path as described at (https://docs.aws.amazon.com/eks/latest/userguide/install-kubectl.html)
* The aws-iam-authenticator binary installed within the OS Path as described at (https://docs.aws.amazon.com/eks/latest/userguide/getting-started.html#eks-prereqs)
* The IAM user configured with using this module should be the same used to create the EKS Cluster.

## Features

This terraform module creates the following resources:

* Local kubeconfig configuration
* Local aws-auth-cm.yaml
* Creates the aws-auth config map in kubernetes


## Usage

To use the module, include something like the following in your terraform configuration:

```

module "join_cluster" {
  source = "github.com/overdrive3000/terraform_eks_join_nodes"

  cluster_name     = "mycluster"
  region           = "us-east-1"
  cluster_endpoint = "API ENDPOINT RETORNED BY EKS CLUSTER"
  cluster_ca       = "CA RETURNED BY THE EKS CLUSTER"
  role             = "arn:aws:iam::000000000:role/mycluster-eksServiceRole"
}
```

## Inputs

| Name             | Description                                | Default   | Required   |
|------------------|--------------------------------------------|:---------:|:----------:|
| cluster_name     | EKS Cluster name                           | -         | yes        |
| region           | EKS Cluster region                         | -         | yes        |
| cluster_endpoint | EKS Cluster API Server Endpoint            | -         | yes        |
| role             | IAM EKS Service Role                       | -         | yes        |
| kubeconfig       | Path in which kubeconfig will be generated | ~/.kube/  | no         |


## Output

| Name       | Description                                 |
|------------|---------------------------------------------|
| config_map | aws-auth-cm configuration                   |
| kubeconfig | Full path of the kubectl configuration file |
