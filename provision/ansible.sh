#!/bin/bash
# DevOps training 2024 - Peter Mikaczo

# Function definition
print_line() {
  echo "========================"
}

#dependency for pipx
print_line
echo "Install pip"
yum install pip -y

#Install pipx - https://pypa.github.io/pipx/installation/
print_line
echo "Install pipx"
python3 -m pip install --user pipx
python3 -m pipx ensurepath

#Install ansible - https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html#installation-guide
print_line
echo "Install ansible"
pipx install --include-deps ansible

#Verify
print_line
echo "Verify ansible"
ansible --version

# shell completion of the Ansible
print_line
echo "Add shell completion of the Ansible"
pipx inject --include-apps ansible argcomplete
activate-global-python-argcomplete --user

# Install sshpass for Ansible inventory with ssh password
print_line
echo "Install sshpass"
yum install sshpass -y

