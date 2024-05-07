#!/bin/bash

groupName=AKSCluster
clusterName=AKSCluster
location=westeurope

if [ -z "$GHCR_PAT" ]
then
    echo "GHCR_PAT is not set"
    exit 1
fi

# Create a new resource group
az group create --name $groupName -l $location

#Create a new AKS cluster
az aks create --resource-group $groupName \
    --name $clusterName \
    --node-count 3 \
    --enable-addons monitoring \
    --generate-ssh-keys

# Connect to the AKS cluster
az aks get-credentials --resource-group $groupName --name $clusterName

# Configure AKS to use the private registry
kubectl create secret docker-registry pullsecret \
    --docker-server=https://ghcr.io/ \
    --docker-username=notneeded \
    --docker-password=$GHCR_PAT