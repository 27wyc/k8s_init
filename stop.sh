set -x

systemctl stop kube-proxy.service
systemctl stop kubelet.service
systemctl stop kube-controller-manager.service
systemctl stop kube-scheduler.service
systemctl stop kube-apiserver.service
systemctl stop etcd.service
rm -fr /var/lib/etcd/default.etcd/*
docker rm -f $(docker ps -a -q)
systemctl stop docker
systemctl stop flanneld.service
iptables --flush
iptables -tnat --flush
ip link delete flannel.1
ip link delete docker0
ip link delete cni0

