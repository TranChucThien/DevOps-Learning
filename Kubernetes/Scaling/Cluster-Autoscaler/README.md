# EKS Cluster with IRSA & Cluster Autoscaler (Demo Setup)

This guide provides instructions for setting up an Amazon EKS cluster, configuring IRSA (IAM Roles for Service Accounts) for the Cluster Autoscaler, and running a test to see how the autoscaler provisions new nodes when pods need more capacity.

> **Note:** This setup is for learning/demo purposes only and is not production-ready.

-----

## 📌 Prerequisites

Ensure you have the following installed:

* **AWS CLI** (v2+)
* **eksctl**
* **kubectl**
* **Bash shell environment**
* **AWS account** with administrator permissions

-----

## 1️⃣ Automation Setup

To automate the creation of the EKS cluster and the necessary configurations, run the `script.sh` file:

```bash

./script.sh

```

This script performs the following actions:

* Creates an EKS cluster using `eksctl`.
* Configures node groups.
* Associates an OIDC provider for IRSA.
* Installs the Cluster Autoscaler.

### Outputs

#### AWS Resources Provisioned

The following AWS resources will be provisioned:

* **EKS Cluster**:
    * **Name**: `tct-cluster`
    * **Region**: `us-east-2`
    * **Nodegroup**: `tct-nodegroup`
* **IAM Policy**:
    * **Name**: `ClusterAutoscalerPolicy`
    * **Description**: Based on `cluster-autoscaler-policy.json`, it grants permissions to the Cluster Autoscaler to describe EC2 instances and adjust Auto Scaling Groups (ASGs).
* **IAM Role**:
    * **Name**: `ClusterAutoscalerRole`
    * **Description**: Its trust policy, generated from `trust-policy-template.json`, allows the EKS OIDC provider to assume this role via IRSA.
    * **IAM Role–Policy Attachment**:
    * **Description**: Attaches the `ClusterAutoscalerPolicy` to the `ClusterAutoscalerRole`.

#### Kubernetes Resources Applied

A Cluster Autoscaler Deployment is created in the `kube-system` namespace.

* A YAML manifest (`cluster-autoscaler.yaml`) is generated from `cluster-autoscaler-autodiscover-template.yaml`.
* Placeholders for `$ACCOUNT_ID`, `$ROLE_NAME`, and `$CLUSTER_NAME` are replaced in the manifest.
* The Deployment uses the specified IAM role through IRSA to interact with AWS APIs.


## 2️⃣ Test the Autoscaler

```bash
# Apply the workload:
kubectl apply -f deployment.yaml

# Scale up:
kubectl scale deployment inflate --replicas=100

# Measure Scaling Time
./time_deployment.sh
```

## 3️⃣ 🧹 Cleanup
```
eksctl delete cluster --name <CLUSTER_NAME> --region <REGION>
```
📚 References

- [YouTube: Cluster Autoscaler on EKS](https://www.youtube.com/watch?v=a6D1GgrtkP4) 
- [Cluster Autoscaler AWS README](https://github.com/kubernetes/autoscaler/blob/master/cluster-autoscaler/cloudprovider/aws/README.md)  