# BulkRemove-ResourceGroups
# Written by: Jennifer Elliott
# Date: 26042020
# Bulk remove Azure Resource Groups based on variable input

$rgbulkname = Read-Host "Please enter the common name of your Resource Groups"
$rgstodelete = Get-AzResourceGroup | Select-Object ResourceGroupName | Where-Object ResourceGroupName -like "*$rgbulkname*" 

foreach ($rg in $rgstodelete){
    $rgname = $rg.ResourceGroupName
    Remove-AzResourceGroup -Name $rgname

Write-Host "$rgname deleted successfully!"
}