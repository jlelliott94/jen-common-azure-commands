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

# Module 2 Demo 1
    # Generate RDP file for VM
    Get-AzRemoteDesktopFile


# Module 2 Demo 2
    # Powershell generation of Virtual Machine

    # Store entered creds as $cred
    $cred = Get-Credential

    # create initial VM config
    $vm = New-AzVMConfig -VMName myVM -VMSize Standard_D1

    # add OS info to config
    $vm = Set-AzVMOperatingSystem `
    -VM $vm `
    -Windows `
    -ComputerName myVM `
    -Credential $cred `
    -ProvisionVMAgent -EnableAutoUpdate 

    # Add image info to VM config
    $vm = Set-AzVMSourceImage `
    -VM $vm `
    -PublisherName MicrosoftWindowsServer `
    -Offer WindowsServer `
    -Skus 2016-Datacenter `
    -Version latest

    # Create new VM
    New-AzVm `
    -ResourceGroupName "myResourceGroup" `
    -Name "myVM" `
    -Location "East US" `
    -VirtualNetworkName "myVnet" `
    -SubnetName "mySubnet" `
    -SecurityGroupName "myNetworkSecurityGroup" `
    -PublicIpAddressName "myPublicIpAddress" `
    -OpenPorts 80,3389

# Module 2 Demo 2
    # create a resource group
    New-AzResourceGroup -Name myResourceGroup -Location EastUS

    # create the virtual machine 
    # when prompted, provide a username and password to be used as the logon credentials for the VM
    New-AzVm `
        -ResourceGroupName "myResourceGroup" `
        -Name "myVM" `
        -Location "East US" `
        -VirtualNetworkName "myVnet" `
        -SubnetName "mySubnet" `
        -SecurityGroupName "myNetworkSecurityGroup" `
        -PublicIpAddressName "myPublicIpAddress" `
        -OpenPorts 80,3389

    #get public IP of VM
    Get-AzPublicIpAddress -ResourceGroupName "myResourceGroup" | Select "IpAddress"
    #RDP to to public IP <Append retrieved public IP>
    mstsc /v:publicIpAddress


# Module 2 Demo 1 - Creating VM in Portal
    #Install IIS
    Install-WindowsFeature -name Web-Server -IncludeManagemntTools


# Module 2 Demo 2 - Custom Script Extension and DSC

# Run custom script extension against VM
Set-AzVmCustomScriptExtension -FileUri https://scriptstore.blob.core.windows.net/scripts/Install_IIS.ps1 -Run "PowerShell.exe" -VmName vmName -ResourceGroupName resourceGroup -Location "location"

# DSC .ps1 file
configuration IISInstall
{
 Node “localhost”
 {
 WindowsFeature IIS
 {
 Ensure = “Present”
 Name = “Web-Server”
 } } }

 # Module 2 Demo 3 - lab
 # add VM to existing Availability set
 New-AzVM -AvailabilitySetID "Name of Availability Set"



 #Random / Unsorted!

 #New Azure Availability Set
 New-AzAvailabilitySet -ResourceGroupName "myRG" -Name "myAvailabilitySet" -Location "East US" -PlatformUpdateDomainCount 5 -PlatformFaultDomainCount 2


 #Export resource group template
 $resourceGroupName = Read-Host -Prompt "Enter the Resource Group name"

Export-AzResourceGroup -ResourceGroupName $resourceGroupName

# Configure static private IP
$Nic = Get-AzureRmNetworkInterface -ResourceGroupName "ResourceGroup1" -Name "NetworkInterface1"
$Nic.IpConfigurations[0].PrivateIpAddress = "10.0.1.20"
$Nic.IpConfigurations[0].PrivateIpAllocationMethod = "Static"
$Nic.Tag = @{Name = "Name"; Value = "Value"}
Set-AzureRmNetworkInterface -NetworkInterface $Nic

# Configure static public IP
$publicIp = Get-AzPublicIpAddress -Name $publicIpName -ResourceGroupName $rgName
$publicIp.PublicIpAllocationMethod = "Static"
Set-AzPublicIpAddress -PublicIpAddress $publicIp
Get-AzPublicIpAddress -Name $publicIpName -ResourceGroupName $rgName

# Identify available DNS name for Azure VM scale set deployment
$rg = Get-AzResourceGroup -Name az1000301-RG
Test-AzDnsAvailability -DomainNameLabel jenddlsname -Location $rg.Location

# Create Azure Storage Account
Get-AzLocation | select Location 
$location = "eastus" 
$resourceGroup = "mod3demo1-rg" 
New-AzResourceGroup -Name $resourceGroup -Location $location 
New-AzStorageAccount -ResourceGroupName $resourceGroup -Name "mod3demo1" -Location $location -SkuName Standard_LRS -Kind StorageV2 

# Create File Share
# Retrieve storage account and storage account key
$storageContext = New-AzStorageContext <storage-account-name> <storage-account-key>
# Create the file share, in this case “logs”
$share = New-AzStorageShare logs -Context $storageContext

# Enae Secure Transfer Required
Set-AzStorageAccount -Name <StorageAccountName> -ResourceGroupName <ResourceGroupName> -EnableHttpsTrafficOnly $True

# Creat File Share, Retrieve Access Key, Create Context and Create File Share (Demo 4)
# Gather storage acc name and key
Get-AzStorageAccount | fl *name*
Get-AzStorageAccount -ResourceGroupName "YourResourceGroupName" -Name "YourStorageAccountName"

# retrieve access key for storage account
$storageAccountKeys = Get-AzStorageAccountKey -ResourceGroupName $resourceGroupName -Name $storageAccountName

#Create context for storage account/key
$storageContext = New-AzStorageContext -StorageAccountName "YourStorageAccountName" -StorageAccountKey $storageAccountKeys[0].value

#Create File Share
$share = New-AzStorageShare "YourFileShareName" -Context $storageContext

#Mount file share
$resourceGroupName = "your-resource-group-name"
$storageAccountName = "your-storage-account-name"
$fileShareName = "your-file-share-name"

# These commands require you to be logged into your Azure account, run Login-AzAccount if you haven't
# already logged in.
$storageAccount = Get-AzStorageAccount -ResourceGroupName $resourceGroupName -Name $storageAccountName
$storageAccountKeys = Get-AzStorageAccountKey -ResourceGroupName $resourceGroupName -Name $storageAccountName
$fileShare = Get-AzStorageShare -Context $storageAccount.Context | Where-Object { 
    $_.Name -eq $fileShareName -and $_.IsSnapshot -eq $false
}

if ($fileShare -eq $null) {
    throw [System.Exception]::new("Azure file share not found")
}

# The value given to the root parameter of the New-PSDrive cmdlet is the host address for the storage account, 
# storage-account.file.core.windows.net for Azure Public Regions. $fileShare.StorageUri.PrimaryUri.Host is 
# used because non-Public Azure regions, such as sovereign clouds or Azure Stack deployments, will have different 
# hosts for Azure file shares (and other storage resources).
$password = ConvertTo-SecureString -String $storageAccountKeys[0].Value -AsPlainText -Force
$credential = New-Object System.Management.Automation.PSCredential -ArgumentList "AZURE\$($storageAccount.StorageAccountName)", $password
New-PSDrive -Name desired-drive-letter -PSProvider FileSystem -Root "\\$($fileShare.StorageUri.PrimaryUri.Host)\$($fileShare.Name)" -Credential $credential -Persist

#dismount file share
Remove-PSDrive -Name desired-drive-letter

# Create storage account level SAS with full permissions
New-AzStorageAccountSASToken -Service Blob,File,Table,Queue -ResourceType Service,Container,Object -Permission "racwdlup"

# Create blob level SAS with full permissions
New-AzStorageBlobSASToken -Container "ContainerName" -Blob "BlobName" -Permission rwd

# create az network mod4demo1
#	1. Create a virtual network. Use values as appropriate.
$myVNet2 = New-AzVirtualNetwork -ResourceGroupName myResourceGroup -Location EastUS -Name myVNet2 -AddressPrefix 10.0.0.0/16 
#	2. Verify your new virtual network information.
Get-AzVirtualNetwork -Name myVNet2 
#	3. Create a subnet. Use values as appropriate.
$mySubnet2 = Add-AzVirtualNetworkSubnetConfig -Name mySubnet2 -AddressPrefix 10.0.0.0/24 -VirtualNetwork $myVNet2 
#	4. Verify your new subnet information.
Get-AzVirtualNetworkSubnetConfig -Name mySubnet2 -VirtualNetwork $myVNet2 
#	5. Associate the subnet to the virtual network.
$mySubnet2 | Set-AzVirtualNetwork 


# DNS - retrieve zone and name server information - sec115par3
# Retrieve the zone information
$zone = Get-AzDnsZone –Name contoso.net –ResourceGroupName MyResourceGroup

# Retrieve the name server records
Get-AzDnsRecordSet –Name “@” –RecordType NS –Zone $zone

#mod5demo1 commands
#remove all mod4 resource groups - see script .\BulkRemove-ResourceGroups.ps1

Get-AzContext
# Add new vNet Gateway connection (use if in different subscriptions as can't do through portal!)
Get-AzVirtualNetworkGatewayConnection

# Get az virtual network gateway connection status and information
Get-AzVirtualNetworkGatewayConnection -Name MyGWConnection -ResourceGroupName MyRG
#results
"connectionStatus": "Connected",
"ingressBytesTransferred": 33509044,
"egressBytesTransferred": 4142431

