# -*- mode: ruby -*-
# vi: set ft=ruby :

$etchosts = <<-SCRIPT
cp /etc/hosts /root && \
echo '\n192.168.56.210 ansible.devopstraining.com' >> /etc/hosts && \
echo '192.168.56.211 web.devopstraining.com m-web' >> /etc/hosts 
SCRIPT


Vagrant.configure("2") do |config|



  config.vm.define "web" do |web|
    web.vm.box = "bento/rockylinux-9"
    web.vm.provider "virtualbox" do |vb|
      vb.memory = "768"
    end
    web.vm.network "private_network", ip: "192.168.56.211"
    web.vm.synced_folder "./shared", "/shared"
    web.vm.provision "shell", inline: $etchosts
    web.vm.provision "shell", inline: "useradd -m -p $(openssl passwd -1 homework) homework" #passwd -1 "rocky"
    web.vm.provision "shell", inline: "echo 'homework ALL=(ALL) NOPASSWD:ALL' | sudo tee /etc/sudoers.d/homework"
    web.vm.provision "shell", inline: "hostnamectl set-hostname m-web"
    web.vm.network "forwarded_port", guest:80, host:8888
  end

  

  config.vm.define "ansible" do |ansible|
    ansible.vm.box = "bento/rockylinux-9"
    ansible.vm.provider "virtualbox" do |vb|
      vb.memory = "1024"
    end
    ansible.vm.network "private_network", ip: "192.168.56.210"
    ansible.vm.hostname = "ansible"
    ansible.vm.synced_folder "./shared", "/shared"
    ansible.vm.provision "shell", inline: $etchosts
    ansible.vm.provision "shell", path: "provision/ansible.sh"
    ansible.vm.provision "shell", inline: "ssh-keyscan m-web >> ~/.ssh/known_hosts" #ssh host key check (fingerprint)
    ansible.vm.provision "shell", inline: "ssh-keyscan ansible >> ~/.ssh/known_hosts" #ssh host key check (fingerprint)
    ansible.vm.provision "shell", inline: "hostnamectl set-hostname ansible"
    
  end
end
