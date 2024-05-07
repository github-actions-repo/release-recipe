#!/bin/bash

# Delete the entire resourcegroup!

groupName=AKSCluster

az group delete --resource-group $groupName --yes