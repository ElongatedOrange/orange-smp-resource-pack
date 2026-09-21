$ErrorActionPreference = 'Stop'
Add-Type -AssemblyName System.IO.Compression.FileSystem
$output = Join-Path $PSScriptRoot 'dist'
New-Item -ItemType Directory -Path $output -Force | Out-Null
$zipPath = Join-Path $output 'orange-smp-resource-pack.zip'
if (Test-Path -LiteralPath $zipPath) { Remove-Item -LiteralPath $zipPath }
$zip = [System.IO.Compression.ZipFile]::Open($zipPath, 'Create')
try {
    $files = @((Get-Item "$PSScriptRoot\pack.mcmeta"), (Get-Item "$PSScriptRoot\pack.png"))
    if (Test-Path "$PSScriptRoot\assets") { $files += Get-ChildItem "$PSScriptRoot\assets" -Recurse -File }
    foreach ($file in ($files | Sort-Object FullName)) {
        $relative = [System.IO.Path]::GetRelativePath($PSScriptRoot, $file.FullName).Replace('\', '/')
        $entry = $zip.CreateEntry($relative)
        $entry.LastWriteTime = [DateTimeOffset]::new(2026, 9, 21, 0, 0, 0, [TimeSpan]::Zero)
        $inputStream = [System.IO.File]::OpenRead($file.FullName)
        $outputStream = $entry.Open()
        try { $inputStream.CopyTo($outputStream) } finally { $inputStream.Dispose(); $outputStream.Dispose() }
    }
} finally { $zip.Dispose() }
$hash = (Get-FileHash -LiteralPath $zipPath -Algorithm SHA1).Hash.ToLowerInvariant()
Set-Content -LiteralPath "$zipPath.sha1" -Value $hash -Encoding ascii -NoNewline
Write-Output "Built $zipPath (SHA-1: $hash)"
