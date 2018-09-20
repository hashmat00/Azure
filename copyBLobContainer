Here is a PowerShell script that can be used to move data in Windows Azure from one subscription to another subscription’s blob storage. The script uses Start-AzureStorageBlobCopy command which is an asynchronous copy operation and copies all the blobs from one container to another. If selected file moving is the intention you can pass in some type of file matching pattern.

Prerequisite:
Download Windows Azure PowerShell
Install Windows Azure Certificate for your subscription

Copy and paste code from here.

#Change these to match the source account
$sourceStorageAccountName = “”
$sourceContainerName = “”
$sourceStorageKey = “” #Need this if moving data from a different subscription

#Destination Account Information
$destStorageAccountName = Read-Host “Enter Destination Storage Account Name”
$destStorageAccountKey = Get-AzureStorageKey $destStorageAccountName | %{$_.Primary}
$destContainerName = Read-Host “Enter Destination Container Name”

$sourceContext = New-AzureStorageContext -StorageAccountName $sourceStorageAccountName -StorageAccountKey $sourceStorageKey -Protocol Http
$destContext = New-AzureStorageContext -StorageAccountName $destStorageAccountName -StorageAccountKey $destStorageAccountKey

$uri = $sourceContext.BlobEndPoint + $sourceContainerName +”/”
# Copy Operation
Get-AzureStorageBlob `
-Context $sourceContext `
-Container $sourceContainerName |
ForEach-Object `
{ Start-AzureStorageBlobCopy `
-SrcUri “$uri$($_.Name)” `
-DestContext $destContext `
-DestContainer $destContainerName `
-DestBlob “hackathon/$($_.Name)” `
}
#Checking Status of Blob Copy — This can be commented out if no confirmation is needed
Get-AzureStorageBlob `
-Context $sourceContext `
-Container $sourceContainerName |
ForEach-Object `
{ Get-AzureStorageBlobCopyState `
-Blob $_.Name `
-Context $destContext `
-Container $destContainerName `
-WaitForComplete `
}

If the data you are copying is on a public blob you can use ‘anonymous’ access instead of providing the $sourceStorageKey. In that case, change $sourceContext to something like the following:

$sourceContext = New-AzureStorageContext -Anonymous -StorageAccountName $sourceStorageAccountName -Protocol Http