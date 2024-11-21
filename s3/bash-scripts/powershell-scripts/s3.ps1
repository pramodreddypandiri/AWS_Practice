Import-Module AWS.Tools.S3

$region = "us-east-1"

$bucketName = Read-Host -Prompt 'Enter the s3 bucket name'

Write-Host "AWS Region: $region"
Write-Host "S3 Bucket: $bucketName"
function BucketExists {
    $bucket = Get-S3Bucket -BucketName $bucketName -ErrorAction silentlyContinue
    return $null -ne $bucket

    
}

if(-not (BucketExists)){
    Write-Host "Bucket does not exists..."
    New-S3Bucket -BucketName $bucketName -Region $region
} else{
    Write-Host "Bucket Already exists..."
}
New-S3Bucket -BucketName $bucketName -Region $region

#create a new file

$fileName = 'myfile.txt'
$fileContent = 'Hello World!'
Set-Content -Path $fileName -Value $fileContent

Write-S3Object -BucketName $bucketName -File $fileName -Key $fileName