# Create-2vNets-2Subnets
# Written by: Jennifer Elliott
# Date: 28042020   
# Create 2 Azure vNets with 1 Subnet and 1 gateway subnet each

# Create a new resource group, if not already existing
$rgyorn = Read-Host "Do you already have a resource group? (y/n, default is n)"

If ($rgyorn -eq "y"){
    $currentrgname = Read-Host "Enter the name of your Resource Group"
    $currentrg = Get-AzResourceGroup -Name $currentrgname
    Write-Host "Current Resource Group set to $currentrgname"
} Else {
    $newrgname = Read-Host "Enter the new Resource Group Name"
    $newrgregion = Read-Host "Enter the region for your new Resource Group in programmatic format(eg. australiaeast/eastus etc.)"
    New-AzResourceGroup -Name $newrgname -Location $newrgregion
    $currentrg = Get-AzResourceGroup -Name $newrgname
    Write-Host "Resource Group $newrgname has been created in the region $newrgregion"
}

# Create some networks! REFACTOR THIS CODE LATER ITS JUST TO COMPLETE MY LAB AND WORNT WORK WITH THE ABOVE YET!

# New Subnet for vNet1
$vnet1subnet1 = New-AzVirtualNetworkSubnetConfig -Name Subnet1 -AddressPrefix "10.0.0.0/25"
# New GW subnet for vNet 1
$vnet1gwsubnet = New-AzVirtualNetworkSubnetConfig -Name GatewaySubnet -AddressPrefix "10.0.0.128/25"
# Create vNet1, associate to RG, associate subnets
$vnet1 = New-AzVirtualNetwork -Name vNet1 -ResourceGroupName "mod5demo2-rg" -Location "australiaeast" -AddressPrefix "10.0.0.0/24" -Subnet $vnet1subnet1,$vnet1gatewaysubnet

# New Subnet for vNet2
$vnet2subnet1 = New-AzVirtualNetworkSubnetConfig -Name Subnet1 -AddressPrefix "10.0.1.0/25"
# New GW subnet for vNEt2
$vnet2gwsubnet = New-AzVirtualNetworkSubnetConfig -Name GatewaySubnet -AddressPrefix "10.0.1.128/25"
# Create vNet2, associate it to RG, associate subnets
$vnet2 = New-AzVirtualNetwork -Name vNet1 -ResourceGroupName "mod5demo2-rg" -Location "australiaeast" -AddressPrefix "10.0.1.0/24" -Subnet $vnet1subnet1,$vnet1gatewaysubnet

