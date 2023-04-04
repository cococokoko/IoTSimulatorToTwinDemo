# Setting up the Resource group with Bicep

* IoT Hub
* IoT Hub Device Provisioning Service (DPS)
* Azure Function App
* Event Grid System Topic
* Digital Twin instance
* Storage Accounts

### Following deployment steps:
- Login to account: az login
- Check subscriptions: az account list -o table
- Choose subscription: az account set --subscription ####
- Check location: az account list-locations -o table
- Create resource group: az group create --name *ResourceCoco* --location westeurope
- Deploy resources defined in bicep file: az deployment group create --resource-group *ResourceCoco* --template-file main.bicep 
- (Delete resource group: az group delete --name *ResourceCoco*)


### Install dependencies
npm install -g azure-functions-core-tools@4 --unsafe-perm true


