

$clientId = "48aff9ec-7d2d-4189-8f21-80f110dad523"
$clientSecret = "n6u8Q~-LqCwtOv1T16ugQT~OBU2U6VMy6_3c.b2R"
$tenantId = "e5ff440d-0854-4245-bcba-baa4251ffcdd"
$subscriptionId = "a6478d69-288c-48d5-a5dd-0ec146abe20e"
$resourceGroupName = "lab-qrm-rg"
$apimName = "lab-qrm-apim"
$apiId = "wsdl-api"
# @{"GetGroup_v2_GroupId"="64531e4c46346119381b323a"}
# $jsonpayload = [Console]::In.ReadLine()
# $json = ($jsonpayload | ConvertFrom-Json -AsHashtable)

# $clientId = $json.clientId
# $clientSecret = $json.clientSecret
# $tenantId = $json.tenantId
# $subscriptionId = $json.subscriptionId
# $resourceGroupName = $json.resourceGroupName
# $apimName = $json.apimName
# $apiId = $json.apiId

$user = $clientId
$password = ConvertTo-SecureString -String $clientSecret -AsPlainText -Force
$Credential = New-Object -TypeName "System.Management.Automation.PSCredential" -ArgumentList $user, $password
$account = Connect-AzAccount -ServicePrincipal -Credential $Credential -Tenant $tenantId
$sub = Select-AzSubscription -SubscriptionId $subscriptionId
$apimContext = New-AzApiManagementContext -ResourceGroupName $resourceGroupName -ServiceName $apimName
Start-Sleep -Seconds 5
$operations = Get-AzApiManagementOperation -Context $apimContext -ApiId $apiId
$output = @{}
foreach ($op in $operations)
{
    [xml]$policy = Get-AzApiManagementPolicy -Context $apimContext -ApiId $apiId -OperationId $op.OperationId -Format rawxml

    $node = Select-Xml -Xml $policy -XPath "//outbound/choose/when/set-body"
    $jsonnode = $node.ToString()
    $pattern='([A-Za-z0-9]+(_[A-Za-z0-9]+)+)": {% if item.([A-Za-z0-9]+(_[A-Za-z0-9]+)+)'
    $Countries=[Regex]::Matches($jsonnode,$Pattern)|ForEach-Object {
    $textBeforeMatch = $jsonnode.Substring(0, $_.Index)
    $textAfterMatch = $jsonnode.Substring(($_.Index+$_.Length), $jsonnode.Length-($_.Index+$_.Length))
    $firstCharUppercase = $_.Value.Substring(0,1).ToUpper()
    $matchedStringWithoutFirstChar = $_.Value.Substring(1, $_.Length-1)
    $updatedCasedString = $firstCharUppercase + $matchedStringWithoutFirstChar
    $jsonnode = $textBeforeMatch + $updatedCasedString + $textAfterMatch
    }
    $node.Node.InnerText = $jsonnode
    Set-AzApiManagementPolicy -Context $apimContext -ApiId $apiId -OperationId $op.OperationId -Policy $policy.OuterXml.ToString()


    #$base64Policy = [Convert]::ToBase64String([System.Text.Encoding]::Unicode.GetBytes($policy))
    #      $policyOutput = @{
    #    OperationId = $op.OperationId
    #    Policy = $base64Policy
    #}
    #$output.Add($op.Name, $policyOutput)
    #$output.Add($op.Name, $op.OperationId)
    #$output.Add($op.OperationId, $base64Policy)
    # Remove-AzApiManagementPolicy -Context $apimContext -ApiId $apiId -OperationId $op.OperationId
}
#Write-Host ($output | ConvertTo-Json)