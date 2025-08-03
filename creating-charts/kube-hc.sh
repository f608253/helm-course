#!/bin/bash

echo "� Cluster Info"
kubectl cluster-info
kubectl version --short

echo -e "\n�� Nodes Overview"
kubectl get nodes -o wide
kubectl top nodes

echo -e "\n� Node Capacity & Allocatable"
for node in $(kubectl get nodes -o name); do
  echo -e "\nNode: $node"
  kubectl describe $node | grep -E 'Capacity|Allocatable'
done

echo -e "\n� Pod Utilization"
kubectl get pods --all-namespaces --field-selector=status.phase=Running | wc -l

echo -e "\n� Resource Quotas"
kubectl get resourcequotas --all-namespaces

echo -e "\n� Core System Pods Health (kube-system)"
kubectl get pods -n kube-system -o wide

echo -e "\n⚠️ Recent Events"
kubectl get events --sort-by='.metadata.creationTimestamp' | tail -n 10
