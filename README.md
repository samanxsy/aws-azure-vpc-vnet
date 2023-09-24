# Ephemeral Cloud Infrastructure Deployment with Terraform


[![Terraform](https://img.shields.io/badge/Terraform-purple)](https://www.terraform.io/) 
[![Terraform Cloud](https://img.shields.io/badge/TerraformCloud-white)](https://app.terraform.io/) 
[![AWS](https://img.shields.io/badge/AWS-orange)](https://aws.amazon.com/) 
[![Azure](https://img.shields.io/badge/Azure-blue)](https://azure.microsoft.com/en-us/) 

## Overview
This repository contains Terraform configurations and modules for deploying cloud infrastructure in AWS and Azure. The configurations are developed to provision Virtual Machines and Virtual Networks and other necessary resources in a modular way, to provide a quick test environment.


## Features

- **Multi-Cloud Support:** Deploy resources in both AWS and Azure.
  
- **Modular Terraform Configs:** Organized configurations for easy customization and maintenance.
  
- **Terraform Cloud Integration:** Terraform state is managed through Terraform Cloud, enabling version-controlled runs, improved secret management, and Policy as Code enforcement.
  
- **Policy as Code with Sentinel:** Sentinel is enabled within Terraform Cloud workspaces to enforce specific policies.

- **HashiCorp Vault:** Sensitive credentials, such as SSH keys, are securely stored and managed using HashiCorp Vault.
  
- **Temporary Test Environments:** Quickly spin up and tear down cloud resources for testing purposes.
  
- **GitHub Actions Integration:** GitHub Actions workflows are used to automate configuration tests and monitor infrastructure changes for improved efficiency.
