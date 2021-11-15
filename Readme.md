# Set up a Kubernetes Cluster using Rancher RKE
### This document guides you to setup a K8s cluster with 1 master and 3 worker nodes running on Ubuntu 20.04 LTS in vagrant environment using RKE (Rancher kubernetes Engine).

## Vagrant Environment
| Role          | IP            | OS               | RAM   | CPU  |
| ------------- |:-------------:| ----------------:|:-----:|-----:|
| Master, etcd  | 192.168.5.101 | Ubuntu 20.04 LTS | 4GB    | 2   |
| Worker node 1 | 192.168.5.151 | Ubuntu 20.04 LTS | 4GB    | 2   |
| Worker node 2 | 192.168.5.152 | Ubuntu 20.04 LTS | 4GB    | 2   |
| Worker node 3 | 192.168.5.152 | Ubuntu 20.04 LTS | 4GB    | 2   |

* Password for the **root** account on all these VMS is **kubeadmin**

## Pre-requisites
   * Virtualbox installed
   * Vagrant installed
   * Host machine has atleast 8 cores
   * Host machine has atleast 32G memory
   * RKE Binary Latest release [here](https://github.com/rancher/rke/releases/)
   * Kubectl Binary

## Create all the above virtual machines
`vagrant up`

## Set up password less SSH Logins on all nodes
Create an ssh keypair on the host machine
`ssh-keygen`

### Copy SSH Keys to all the kubernetes nodes 
`cat ~/.ssh/id_rsa.pub | ssh root@192.168.5.101 'cat >> ~/.ssh/authorized_keys' ` 

`cat ~/.ssh/id_rsa.pub | ssh root@192.168.5.151 'cat >> ~/.ssh/authorized_keys' `  

`cat ~/.ssh/id_rsa.pub | ssh root@192.168.5.152 'cat >> ~/.ssh/authorized_keys' `
    
`cat ~/.ssh/id_rsa.pub | ssh root@192.168.5.153 'cat >> ~/.ssh/authorized_keys' `  

## Create the Kubernetes cluster configuration by using RKE 
`rke config --name devcluster.yml`
This is a interactive cluster configuration, so it will produce a **devcluster.yml** in the current directory.

## Spin up the cluster 
`rke up --config devcluster.yml`

Once the cluster provisioned then there will be a file **kube_config_devcluster.yml** generated in the current directory. Please copy this file into **~/.kube** folder and rename the file as **config**.
`mkdir ~/.kube`
`Copy-Item .\kube_config_devcluster.yml -Destination "~/.kube"`
`Rename-Item -Path "C:\Users\rajms\.kube\kube_config_devcluster.yml" -NewName "config"`

## Verifying the Cluster installation
`Kubectl get nodes`
`kubectl get pods --all-namespaces`

