# This is a script I used to complete Module 5 Demo 2 in the Skillpipe Book for AZ-103

# New Subnet for vNet1
$vnet1subnet1 = New-AzVirtualNetworkSubnetConfig -Name Subnet1 -AddressPrefix "10.0.0.0/25"
# New GW subnet for vNet 1
$vnet1gwsubnet = New-AzVirtualNetworkSubnetConfig -Name GatewaySubnet -AddressPrefix "10.0.0.128/25"
# Create vNet1, associate to RG, associate subnets
$vnet1 = New-AzVirtualNetwork -Name "vNet1" -ResourceGroupName "mod5demo2-rg" -Location "australiaeast" -AddressPrefix "10.0.0.0/24" -Subnet $vnet1subnet1,$vnet1gatewaysubnet

# New Subnet for vNet2
$vnet2subnet1 = New-AzVirtualNetworkSubnetConfig -Name Subnet1 -AddressPrefix "10.0.1.0/25"
# New GW subnet for vNEt2
$vnet2gwsubnet = New-AzVirtualNetworkSubnetConfig -Name GatewaySubnet -AddressPrefix "10.0.1.128/25"
# Create vNet2, associate it to RG, associate subnets
$vnet2 = New-AzVirtualNetwork -Name "vNet2" -ResourceGroupName "mod5demo2-rg" -Location "australiaeast" -AddressPrefix "10.0.1.0/24" -Subnet $vnet1subnet1,$vnet1gatewaysubnet