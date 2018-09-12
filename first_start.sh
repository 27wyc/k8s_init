#!/usr/bin/env bash

rm -fr /var/lib/etcd/default.etcd/*
systemctl start etcd.service
systemctl start docker
systemctl start kube-apiserver.service
systemctl start kube-scheduler.service
systemctl start kube-controller-manager.service

while ! (kubectl create clusterrolebinding kubelet-bootstrap --clusterrole=system:node-bootstrapper --user=kubelet-bootstrap); do
    sleep 0.5
    echo retry
done

systemctl start kubelet

csr=
while [[ $csr'a' == 'a' ]]; do
    sleep 0.5
    csr=`kubectl get csr | tail -n1 | awk '{print $1}'`
done

kubectl certificate approve $csr

systemctl start kube-proxy.service
