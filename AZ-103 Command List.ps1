#### Skillpipe ####

## Backfill commands that I haven't added yet! ##

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