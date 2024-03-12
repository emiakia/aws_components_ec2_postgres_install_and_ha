#!/bin/bash

local_ip=$(hostname -I | awk '{print $1}')
echo $local_ip

# Get playbook from Github
wget https://raw.githubusercontent.com/emiakia/aws_components_ec2_postgres_install_and_ha/main/ansible/p00install-postgres-for-primary.yaml
wget https://raw.githubusercontent.com/emiakia/aws_components_ec2_postgres_install_and_ha/main/ansible/p01installation.yaml
wget https://raw.githubusercontent.com/emiakia/aws_components_ec2_postgres_install_and_ha/main/ansible/p02post-installation.yaml
wget https://raw.githubusercontent.com/emiakia/aws_components_ec2_postgres_install_and_ha/main/ansible/p03checking.yaml

wget https://raw.githubusercontent.com/emiakia/aws_components_ec2_postgres_install_and_ha/main/ansible/ansible.cfg
wget https://raw.githubusercontent.com/emiakia/aws_components_ec2_postgres_install_and_ha/main/ansible/vars.yaml
wget https://raw.githubusercontent.com/emiakia/aws_components_ec2_postgres_install_and_ha/main/ansible/inventory.yaml

sed -i "s/PPP/$local_ip/" vars.yaml

# Define the path to your Ansible playbook
PLAYBOOK_PATH="./p00install-postgres-for-primary.yaml
echo $PLAYBOOK_PATH

# # Update the system
# echo "Updating system..."
# sudo apt update -y

# # Install Ansible
# echo "Installing Ansible..."
# sudo apt install -y ansible

# # Verify Ansible installation
# echo "Verifying Ansible installation..."
# ansible --version

# # Run the Ansible playbook
# echo "Running Ansible playbook..."
# ansible-playbook -i inventory.yaml "$PLAYBOOK_PATH"


rm -rf *yaml*
rm -rf *cfg*
