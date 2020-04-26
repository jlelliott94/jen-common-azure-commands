# BulkRemove-ResourceGroups
# Written by: Jennifer Elliott
# Date: 26042020
# Bulk remove Azure Resource Groups based on variable input

# Store string common to the resource groups wanting to be deleted
$rgbulkname = Read-Host "Please enter the common name of your Resource Groups"

# Retrieve AzResourceGroups and filter results based on previous variable
$rgstodelete = Get-AzResourceGroup | Select-Object ResourceGroupName | Where-Object ResourceGroupName -like "*$rgbulkname*" 

# Loop through results to remove each resource group
foreach ($rg in $rgstodelete){
    $rgname = $rg.ResourceGroupName
    Remove-AzResourceGroup -Name $rgname

Write-Host "$rgname deleted successfully!"
} 

# Improvements:
    # Automatically approve what is being deleted so don't need to hit Y every time loop runs
    # If/else statement for confirmation message in for loop based on conditional outcome
    # Clean up initial gathering of resource groups