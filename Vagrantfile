Vagrant.configure("2") do |config|

  config.vm.box_check_update = false
  config.vm.provision "shell", path: "install_prerequisites.sh"

  #Kubernetes Masternode
  MasterNodeCount = 1
  
   (1..MasterNodeCount).each do |i|
    config.vm.define "master#{i}" do |node|
      node.vm.box = "ubuntu/focal64"
      node.vm.hostname = "master#{i}"
      node.vm.network :private_network, ip: "192.168.5.10#{i}"
      # Name shown in the GUI
      node.vm.provider "virtualbox" do |vb|
        vb.name = "kubernetes-master"
        vb.memory = 4096
        vb.cpus = 2
    end
  end
end

# Kubernetes  WorkerNodes
NodeCount = 3

(1..NodeCount).each do |i|
  config.vm.define "node#{i}" do |node|
    node.vm.box = "ubuntu/focal64"
    node.vm.hostname = "node#{i}"
    node.vm.network "private_network", ip: "192.168.5.15#{i}"
    node.vm.provider "virtualbox" do |vb|
      vb.name = "kubernetes-node#{i}"
      vb.memory = 4096
      vb.cpus = 2
    end
  end
end

 
end


