param(
[string]$Path,
[string]$Date
)

Add-Type -assembly "system.io.compression.filesystem"

$runDate = Get-Date

$arrRootFolders = get-childitem $Path -Exclude $arrFilter -Force -OutBuffer 1000 | where {$_.Attributes -match 'Directory'}

Write-Host "Compress and Delete Script Running - " $runDate
Write-Host "Path: " $Path
Write-Host "Month to Compress: " $Date
Write-Host "-------------"
Write-Host "Start Compress!"
Write-Host "-------------"


foreach ($item in $arrRootfolders)
{
    Write-Host "Check Folder: " $item.FullName

    $arrSubfolders = get-childitem $Item.FullName -Recurse -Force -OutBuffer 1000 -Directory $Date | where {$_.Attributes -match 'Directory'}
        
    foreach ($subFolder in $arrSubfolders)
    {
        Write-Host "COMPRESS FOLDER: " $subFolder.FullName
        
            $path = $subFolder.FullName
            $destination = "$path.zip"

            Write-Host "Zip file: " $destination

            [io.compression.zipfile]::CreateFromDirectory($subFolder.fullname, $destination)

            if(Test-Path $destination)
            {
                Write-Host "Zip file is created: " $destination
                Write-Host "!!! Delete Source folder: " $subFolder.FullName
                remove-item $subfolder.FullName -Recurse -Force
            }
    }

}            


$endDate = Get-Date

Write-Host "-------------"
Write-Host "Script ended! - " $endDate
Write-Host "-------------"