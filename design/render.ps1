# Renders the banner, cover and card images with headless Edge.
#
#   powershell -ExecutionPolicy Bypass -File design\render.ps1                          # all images
#   powershell -ExecutionPolicy Bypass -File design\render.ps1 home-banner card-dg-bridge  # some images
#
# Output goes to docs/.gitbook/assets/ (or design/out/ with -Preview).

param(
    [switch]$Preview,
    [Parameter(ValueFromRemainingArguments = $true)]
    [string[]]$Names
)

$edge = 'C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe'
$here = Split-Path -Parent $MyInvocation.MyCommand.Path

# name = width,height
$images = [ordered]@{
    'home-banner'     = '1990,480'
    'dg-shops-cover'  = '1990,480'
    'dg-bridge-cover' = '1990,480'
    'card-dg-bridge'  = '1920,1080'
}

if (-not $Names) { $Names = $images.Keys }

$outDir = if ($Preview) { Join-Path $here 'out' } else { Join-Path (Split-Path -Parent $here) 'docs\.gitbook\assets' }
New-Item -ItemType Directory -Force -Path $outDir | Out-Null

foreach ($name in $Names) {
    if (-not $images.Contains($name)) { Write-Warning "Unknown image: $name"; continue }
    $html = Join-Path $here "$name.html"
    if (-not (Test-Path -LiteralPath $html)) { Write-Warning "Missing $html"; continue }

    $out = Join-Path $outDir "$name.png"
    $profile = Join-Path $env:TEMP ("dg-render-" + [guid]::NewGuid().ToString('N'))
    $url = 'file:///' + ($html -replace '\\', '/')

    if (Test-Path -LiteralPath $out) { Remove-Item -LiteralPath $out -Force }

    Start-Process -Wait -FilePath $edge -ArgumentList @(
        '--headless=new',
        "--user-data-dir=$profile",
        '--hide-scrollbars',
        '--force-device-scale-factor=1',
        "--window-size=$($images[$name])",
        '--virtual-time-budget=3000',
        "--screenshot=$out",
        $url
    )

    Remove-Item -LiteralPath $profile -Recurse -Force -ErrorAction SilentlyContinue

    if (Test-Path -LiteralPath $out) { Write-Host "OK  $name -> $out" } else { Write-Warning "No output for $name" }
}
