#!/bin/bash

echo "Ì¥ç Cluster Info"
kubectl cluster-info
kubectl version --short

echo -e "\nÔøΩÔøΩ Nodes Overview"
kubectl get nodes -o wide
kubectl top nodes

echo -e "\nÌ≥¶ Node Capacity & Allocatable"
for node in $(kubectl get nodes -o name); do
  echo -e "\nNode: $node"
  kubectl describe $node | grep -E 'Capacity|Allocatable'
done

echo -e "\nÌ≥ä Pod Utilization"
kubectl get pods --all-namespaces --field-selector=status.phase=Running | wc -l

echo -e "\nÌ∑† Resource Quotas"
kubectl get resourcequotas --all-namespaces

echo -e "\nÌ¥ç Core System Pods Health (kube-system)"
kubectl get pods -n kube-system -o wide

echo -e "\n‚ö†Ô∏è Recent Events"
kubectl get events --sort-by='.metadata.creationTimestamp' | tail -n 10
