#### Skillpipe ####

## Backfill commands that I haven't added yet! ##

# Module 1 Demo 1

    # Basics
    Get-Help
    Get-Command
    Get-Verb
    # | ft -AutoSize (format to table)

    # List subscriptions
    Get-AzSubscription

    # List Resource Grops
    Get-AzResourceGroup

# Module 1 Demo 2
    # Install Az module and overwrite with new version if old one exists
    Install-Module -Name az -AllowClobber
    # Trust PS repository
    Set-PSRepository -Name "internalSource" -InstallationPolicy -Trusted
    # Connect to Azure
    Connect-AzAccount
    # Create Resource Group
    New-AzResourceGroup -Name "Mod1Demo2"-RG -Location eastus
    # Remove Resource Group
    Remove-AzResourceGroup -Name "Mod1Demo2-RG"
    # Assign tags to RG !!RESEARCH ONE COMMAND FOR MULTIPLE TAGS!!
    Set-AzResourceGroup -Name "Mod1Demo2-RG" -Tag@{"skillpipe-module-number"="1"}
    Set-AzResourceGroup -Name "Mod1Demo2-RG" -Tag@{"ms-resource-usage"="skillpipe-demo"}

# Module 1 Demo 5 - 

    # New Resource Lock
    New-AzResourceLock -LockName Posh-Delete-Lock -LockLevel CanNotDelete -ResourceGroupName Mod1Demo5-RG

    # Get all Resource Locks
    Get-AzResourceLock

    # Remove Resource Lock
    Remove-AzResourceLock -LockName Posh-Delete-Lock -ResourceGroupName Mod1Demo5-RG

# Module 1 Demo 7

    # Connect to Azure from local powershell
    Connect-AzAccount

    # Specify which subscription to deploy resources into (this is my subID) - retrieve then set
    Get-AzContext
    Set-AzContext -subscription e3823142-c82d-48ad-a949-4c8073253550

    # New RG
    New-AzResourceGroup -Name "Mod1Demo7-RG" -Location "East US"

    # Deploy Linux VM from Quickstart template from local Powershell
    $templateUri = "https://raw.githubusercontent.com/Azure/azure-quickstart-templates/master/101-vm-simple-linux/azuredeploy.json"
    New-AzResourceGroupDeployment -Name "RGDeployment1" -ResourceGroupName "Mod1Demo7-RG" -TemplateUri $templateUri

    # FROM MS DOCS SITE - https://docs.microsoft.com/en-us/azure/azure-resource-manager/templates/deploy-powershell
    # New Az RG based on host input
    $resourceGroupName = Read-Host -Prompt "Enter the Resource Group name"
    $location = Read-Host -Prompt "Enter the location (i.e. centralus)"

    New-AzResourceGroup -Name $resourceGroupName -Location $location
    # New AzRG Deployment w/ remote template
    
    New-AzResourceGroupDeployment -ResourceGroupName $resourceGroupName -TemplateUri https://raw.githubusercontent.com/Azure/azure-quickstart-templates/master/101-vm-simple-windows/azuredeploy.json
    # Add the below to include a remote parameter document
    -TemplateParameterUri https://raw.githubusercontent.com/Azure/azure-quickstart-templates/master/101-vm-simple-windows/azuredeploy.parameters.json

    # Verify - list Az VMs
    Get-AzVM

    # Above with additional details around simpleLinuxVM
    Get-AzVM -Name "simpleLinuxVM"  -resourcegroupname "Mod1Demo7-RG"

    # List VMs in subscription - alternate method ($vm variable stored)
    $vm = Get-AzVM  -Name "SimpleLinuxVM" -ResourceGroupName "Mod1Demo7-RG"

    # More variable examples
    $ResourceGroupName = "Mod1Demo7-Rg"
    $vm = Get-AzVM  -Name MyVM -ResourceGroupName $ResourceGroupName
    $vm.HardwareProfile.vmSize = "Standard_A3"

    # Update VM with variable information from the above exampless
    Update-AzVM -ResourceGroupName $ResourceGroupName  -VM $vm
