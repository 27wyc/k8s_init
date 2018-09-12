set -x
rm -fr /var/lib/etcd/default.etcd/*
#systemctl stop docker

systemctl start etcd.service
# etcdctl get /kube-centos/network/config
#bash /etc/etcd/etcd-init.sh
#systemctl start flanneld.service
#mk-docker-opts.sh -d /run/docker_opts.env -c
systemctl start docker
systemctl start kube-apiserver.service
systemctl start kube-scheduler.service
systemctl start kube-controller-manager.service
systemctl start kubelet.service
systemctl start kube-proxy.service

#kubectl apply -f /root/kube-dns.yaml
#kubectl create namespace istio-system

# cd /root/istio-1.0.0
# kubectl create namespace istio-system
# kubectl apply -f install/kubernetes/helm/istio/templates/crds.yaml
# kubectl apply -f install/kubernetes/helm/istio/charts/certmanager/templates/crds.yaml
# helm template install/kubernetes/helm/istio --name istio --namespace istio-system > $HOME/istio.yaml
# kubectl create -f $HOME/istio.yaml
