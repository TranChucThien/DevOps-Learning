#!/bin/bash

set -e

echo "==> Starting EKS cluster creation (if not created yet)..."
eksctl create cluster -f cluster.yaml

export CLUSTER_NAME=tct-cluster
export REGION=us-west-1
export ROLE_NAME="ClusterAutoscalerRole"
export POLICY_NAME="ClusterAutoscalerPolicy"
export POLICY_FILE="cluster-autoscaler-policy.json"
export TRUST_POLICY_FILE="trust-policy.json"

echo "==> Retrieving AWS Account ID..."
export ACCOUNT_ID=$(aws sts get-caller-identity --query "Account" --output text)
echo "    -> Account ID: $ACCOUNT_ID"

echo "==> Retrieving OIDC ID for EKS cluster '$CLUSTER_NAME' in region '$REGION'..."
export OIDC_ID=$(aws eks describe-cluster --name $CLUSTER_NAME --region $REGION --query "cluster.identity.oidc.issuer" --output text | awk -F'/' '{print $NF}')
echo "    -> OIDC ID: $OIDC_ID"

echo "==> Generating trust-policy.json from template..."
sed -e "s/\$account_id/$ACCOUNT_ID/g" \
    -e "s/\$region/$REGION/g" \
    -e "s/\$oidc_id/$OIDC_ID/g" \
    trust-policy-template.json > trust-policy.json
echo "==> trust-policy.json has been created successfully."

echo "==> Creating IAM Policy..."
if ! aws iam create-policy \
    --policy-name "$POLICY_NAME" \
    --policy-document file://$POLICY_FILE > /dev/null 2>&1; then
  echo "⚠️ Policy might already exist, continuing..."
else
  echo "✅ Policy created successfully."
fi

export POLICY_ARN="arn:aws:iam::${ACCOUNT_ID}:policy/${POLICY_NAME}"

echo "==> Creating IAM Role with trust policy..."
if ! aws iam create-role \
  --role-name "$ROLE_NAME" \
  --assume-role-policy-document file://$TRUST_POLICY_FILE > /dev/null 2>&1; then
  echo "⚠️ Role might already exist, continuing..."
else
  echo "✅ Role created successfully."
fi

echo "==> Attaching policy to the role..."
aws iam attach-role-policy \
  --role-name "$ROLE_NAME" \
  --policy-arn "$POLICY_ARN"
echo "✅ Policy attached to role."

echo "🎉 Completed: IAM Role '$ROLE_NAME' is ready for Cluster Autoscaler."


sed -e "s|\$ACCOUNT_ID|$ACCOUNT_ID|g" \
    -e "s|\$ROLE_NAME|$ROLE_NAME|g" \
    -e "s|\$CLUSTER_NAME|$CLUSTER_NAME|g" \
    cluster-autoscaler-autodiscover-template.yaml > cluster-autoscaler.yaml

kubectl apply -f cluster-autoscaler.yaml