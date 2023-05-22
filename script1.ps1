$sourceFile = "C:\path\*.bat"

$idol = Read-Host "Enter the idol value (separated by commas if multiple):"
$computers = @()
foreach ($id in $idol -split ',') {
    $computer = Get-ADComputer -Filter { Name -like $id } | Select-Object -ExpandProperty Name
    if ($computer) {
        $computers += $computer
    }
}

$destinationPath = "\\$computer\D$\"

foreach ($computer in $computers) {
    $destination = $destinationPath + $computer
    try {
        Copy-Item -Path $sourceFile -Destination $destination -Force
        Write-Host "File successfully copied to $destination"
    }
    catch {
        Write-Host "Failed to copy file to $destination"
    }
}
