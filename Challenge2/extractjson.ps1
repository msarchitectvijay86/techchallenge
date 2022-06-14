$rg = "rg_azsearch"
$azsearch = "testsearch"

$adminkey = az search admin-key show --resource-group $rg --service-name $azsearch
$out = $adminkey | ConvertFrom-Json
$key = $out.primaryKey
write-host "The key is " $key

$headers = @{"api-key"=$key; "Accept"="application/json; odata.metadata=none"}
function Write-Headers
{
    param(
        [Parameter(Mandatory=$True,ValueFromPipeline=$True)]$headers
    )

    $text = ($headers.Keys | foreach { "$_`: $($headers[$_])" }) -join "`n"
    Write-Host $text
}
Write-Headers $headers


#Extract index JSON from source Azure Search

$uri = "https://${azsearch}.search.windows.net/indexes?api-version=2021-04-30-Preview"
Write-host "Uri is " $uri
$indexes = Invoke-restmethod $uri -Method Get -header $headers -ContentType application/json 
$indexlist = @()
$indexlist = $indexes.value.name
foreach ($index in $indexlist)
{
$uri = "https://${azsearch}.search.windows.net/indexes/${index}?api-version=2021-04-30-Preview"
$indexjson = Invoke-restmethod $uri -Method Get -header $headers -ContentType application/json 
$output = $indexjson |ConvertTo-Json -depth 20
$output |Out-File C:\azsearch\indexes\$index.json
}

