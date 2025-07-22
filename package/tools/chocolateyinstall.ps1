$ErrorActionPreference = 'Stop';
$PackageParameters = Get-PackageParameters
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$url = 'https://wwcom.ch/downloads/cti_4_1_10.exe' 
$url64 = 'https://wwcom.ch/downloads/cti64_4_1_10.exe'

$checksum = '2be0d4d7c2e9478316e0f91b95b32fe6a03b4f3b122184c351a128fc10bb517965634e16ae7ad6434d40d3b52d2f8c96d132a229eb052536fe371f39c03f2d1e'
$checksum64 = '0bb5db6c808502dea242acaca4290836ae4b115e01a1b5f39ffe2bb4ebd21ac3a757bab50067744873307edaca6b5ee478416d59b20986ee2382ffa494d8eb2f'

# Prep 32bit install
$32bit = $false
if ($PackageParameters) {
  if ($PackageParameters["32bit"]) {
    $32bit = $true
  }
}

# Args for 64bit install
$packageArgs64 = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  fileType      = 'EXE'
  url           = $url64
  softwareName  = 'cti*'
  checksum      = $checksum64
  checksumType  = 'sha512'
  silentArgs    = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-' + 
  " /Log=`"$env:TEMP\$env:ChocolateyPackageName.$env:ChocolateyPackageVersion.Install.log`""
}

# Args for 32bit install
$packageArgs32 = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  fileType      = 'EXE'
  url           = $url
  softwareName  = 'cti*'
  checksum      = $checksum
  checksumType  = 'sha512'
  silentArgs   = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-' + 
  " /Log=`"$env:TEMP\$env:ChocolateyPackageName.$env:ChocolateyPackageVersion.Install.log`""
}

if ($32bit) {
  Write-Host "Installing 32-bit version"
  Install-ChocolateyPackage @packageArgs32
} else {
  Write-Host "Installing 64-bit version"
  Install-ChocolateyPackage @packageArgs64
}
