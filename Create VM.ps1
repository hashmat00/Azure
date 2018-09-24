#connect to Azure Account
connect-azureRmAccount


#create Resource Group
New-AzureRmResourceGroup -Name myResourceGroup -Location EastUS

#Create virtual machine
New-AzureRmVm `
    -ResourceGroupName "myResourceGroup" `
    -Name "myVM" `
    -Location "East US" `
    -VirtualNetworkName "myVnet" `
    -SubnetName "mySubnet" `
    -SecurityGroupName "myNetworkSecurityGroup" `
    -PublicIpAddressName "myPublicIpAddress" `
    -OpenPorts 80,3389



#Connect to virtual machine
Get-AzureRmPublicIpAddress -ResourceGroupName "Central-US" | Select "IpAddress"

# Use the following command to create a remote desktop session from your local computer. Replace the IP address with the public IP address of your VM. When prompted, enter the credentials used when the VM was created:

mstsc /v:VMPublicIPaddress


#Install web server by opening the VM and start powershell window and type folowing cmdts
Install-WindowsFeature -name Web-Server -IncludeManagementTools

#Clean up resources
Remove-AzureRmResourceGroup -Name myResourceGroup
