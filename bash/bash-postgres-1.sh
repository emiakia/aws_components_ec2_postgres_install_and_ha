#!/bin/bash

local_ip=$(hostname -I | awk '{print $1}')
echo $local_ip

ssh_user=$(whoami)
echo $ssh_user


# Get playbook from Github
wget https://raw.githubusercontent.com/emiakia/aws_components_ec2_postgres_install_and_ha/main/ansible/s00install-postgres-for-standby.yaml
wget https://raw.githubusercontent.com/emiakia/aws_components_ec2_postgres_install_and_ha/main/ansible/s01installation.yaml
wget https://raw.githubusercontent.com/emiakia/aws_components_ec2_postgres_install_and_ha/main/ansible/s02post-installation.yaml
wget https://raw.githubusercontent.com/emiakia/aws_components_ec2_postgres_install_and_ha/main/ansible/s03checking.yaml

wget https://raw.githubusercontent.com/emiakia/aws_components_ec2_postgres_install_and_ha/main/ansible/ansible.cfg
wget https://raw.githubusercontent.com/emiakia/aws_components_ec2_postgres_install_and_ha/main/ansible/vars.yaml
wget https://raw.githubusercontent.com/emiakia/aws_components_ec2_postgres_install_and_ha/main/ansible/inventory.yaml

sed -i "s/SSS/$local_ip/" vars.yaml
sed -i "s/UUU/$ssh_user/" vars.yaml

# Define the path to your Ansible playbook
PLAYBOOK_PATH="./s00install-postgres-for-standby.yaml"
echo $PLAYBOOK_PATH

# Update the system
echo "Updating system..."
sudo apt update -y

# Install Ansible
echo "Installing Ansible..."
sudo apt install -y ansible

# Verify Ansible installation
echo "Verifying Ansible installation..."
ansible --version

# Run the Ansible playbook
echo "Running Ansible playbook..."
ansible-playbook -i inventory.yaml "$PLAYBOOK_PATH"

rm -rf *yaml*
rm -rf *cfg*
