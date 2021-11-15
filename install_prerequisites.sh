#!/bin/bash
#Install docker engine on ubuntu 20.04 LTS 
sudo apt update \
&& sudo apt install -y \
   apt-transport-https \
   ca-certificates \
   curl \
   software-properties-common \
&& sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add - \
&& sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu focal stable" \
&& sudo apt-cache policy docker-ce \
&& sudo apt install -y docker-ce 

#install net-tools
sudo apt install net-tools

#Letting iptables see bridged traffic
cat <<EOF | sudo tee /etc/modules-load.d/k8s.conf
br_netfilter
EOF

cat <<EOF | sudo tee /etc/sysctl.d/k8s.conf
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
EOF

sudo sysctl --system


# Enable ssh password authentication
echo "[TASK 1] Enable ssh password authentication"
sed -i 's/^PasswordAuthentication .*/PasswordAuthentication yes/' /etc/ssh/sshd_config
echo 'PermitRootLogin yes' >> /etc/ssh/sshd_config
systemctl reload sshd

# Set Root password
echo "[TASK 2] Set root password"
echo -e "kubeadmin\nkubeadmin" | passwd root >/dev/null 2>&1

#update dns
sudo sed -i -e 's/#DNS=/DNS=8.8.8.8/' /etc/systemd/resolved.conf
sudo service systemd-resolved restart

