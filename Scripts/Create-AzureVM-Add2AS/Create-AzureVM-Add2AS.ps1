# Create Azure VM and add to existing availability set
# Module 2 Lab 3

# Store entered creds as $cred
$cred = Get-Credential

# create initial VM config
$vm = New-AzVMConfig -VMName myVM2 -VMSize Standard_D1

# add OS info to config
$vm = Set-AzVMOperatingSystem `
-VM $vm `
-Windows `
-ComputerName myVM2 `
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
-ResourceGroupName "Mod2Lab3-RG" `
-Name "myVM2" `
-Location "East US" `
-VirtualNetworkName "myVnet2" `
-SubnetName "mySubnet2" `
-SecurityGroupName "myNetworkSecurityGroup2" `
-PublicIpAddressName "myPublicIpAddress2" `
-AvailabilitySetName "myAvailabilitySet1"
-OpenPorts 80,3389