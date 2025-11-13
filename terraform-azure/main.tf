trigger:
  branches:
    include:
      - main

# Variabilele vin din Azure DevOps Library (Variable Group)
variables:
  - group: terraform-backend

# Rulează pe agent hosted (DNS/Internet ok)
pool:
  vmImage: 'ubuntu-latest'

steps:
  - checkout: self

  - task: TerraformInstaller@1
    inputs:
      terraformVersion: 'latest'

  - script: |
      export ARM_CLIENT_ID=$(appId)
      export ARM_CLIENT_SECRET=$(password)
      export ARM_TENANT_ID=$(tenant)
      export ARM_SUBSCRIPTION_ID=$(subscriptionId)

      terraform -version
      terraform init -reconfigure
      terraform plan -out=tfplan
    workingDirectory: terraform-azure
    displayName: 'Terraform Init & Plan (Linux)'

  - script: |
      export ARM_CLIENT_ID=$(appId)
      export ARM_CLIENT_SECRET=$(password)
      export ARM_TENANT_ID=$(tenant)
      export ARM_SUBSCRIPTION_ID=$(subscriptionId)

      terraform apply -auto-approve tfplan
    workingDirectory: terraform-azure
    displayName: 'Terraform Apply (Linux)'
