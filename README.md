# Infrastructure as Code Repo

[![Terraform](https://img.shields.io/badge/Terraform-purple)](https://www.terraform.io/)
[![Ansible](https://img.shields.io/badge/Ansible-red)](https://www.ansible.com/)
[![Azure](https://img.shields.io/badge/Azure-blue)](https://azure.microsoft.com/en-us/)
[![AWS](https://img.shields.io/badge/AWS-orange)](https://aws.amazon.com/)


This repository contains IaC files for provisioning and managing cloud resources on AWS and Azure. It includes modules for configuring VPCs, VNets, VMs, EC2 instances, networking, storage, and Ansible playbooks. The purpose of this code is to enable quick and easy deployment of test environments, allowing to spin up and tear it down in minutes.

## Table of Contents
- Getting Started
- Prerequisites
- Usage
- Contributing
- License

## Getting Started
To get started with this Repo, follow the steps below:
1. 
Clone the repository to your local machine:

```
git clone https://github.com/samanxsy/Terraform.git
```

2. Navigate to the desired directory based on the cloud provider (**AWS** or **Azure**).

3. Review the available modules and playbooks to understand their functionality and usage.
-  **Note that all the resources are managed to not exceed the free trial limits.**

## Prerequisites

- Valid credentials and subscriptions for the respective cloud providers (**AWS** or **Azure**).
- Familiarity with infrastructure-as-code concepts and tools such as Terraform and Ansible.
- Basic knowledge of networking, security, and cloud infrastructure.

### Usage

1. Update the variables.tf or variables.yml file in the respective module or playbook directory to match your specific requirements.

2. Create your own **SSH credentials** and put them in the correct paths, or modify the path indicated in the code blocks for both **private** and **public** keys

3. Review and update any other configuration files or scripts as necessary.

4. Run the **Terraform** commands for the desired cloud provider and module/playbook.
- **Examples**
```
cd AWS
terraform init
terraform plan
terraform apply
```
**For the AWS, you must create an S3 bucket to store the state, or change the configurations to store the state locally**

```
cd Azure
terraform init
terraform plan
terraform apply
```
5. Connect to your instances via your own SSH credentials

6. To Destroy the infrastructure, simply just run `terraform destroy` in the **root directory** of your desired cloud provider.
For example: 
```
cd AWS
teraform destroy
```

## Ansible
The ansible playbook available in this repo will just install docker and docker-compose. if you need more, or other tools in your Virtual Machines, feel free to modify.

## License
This repository is licensed under the MIT License. Feel free to use the code and modify it to suit your needs.
