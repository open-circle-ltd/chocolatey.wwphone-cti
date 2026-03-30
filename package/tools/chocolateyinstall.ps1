$ErrorActionPreference = 'Stop';
$PackageParameters = Get-PackageParameters
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url = 'https://wwcom.ch/downloads/cti_4_2_16.exe'
$url64 = 'https://wwcom.ch/downloads/cti64_4_2_16.exe'
$checksum = '03b4ab10c190a8cc6080d52a2a457593be7756227390fe9288d83fa3131188721f4fd56cc5c89fa02fa7e8495ca27d9cebd3f8f6e8bb2e57a7050fd943339ef4'
$checksum64 = '78c0fa42eaf27a93b5a8d460155752afdb9e61e9666d1ff159888c2a26cf4ba18c78c651976f240f78bae7998543d69df86e74869bc212901b57a2a7248650b4'

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
  silentArgs    = '/MOVEEXISTING /VERYSILENT /SUPPRESSMSGBOXES /NORESTART /NOCLOSEAPPLICATIONS /SP-' + 
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
  silentArgs    = '/MOVEEXISTING /VERYSILENT /SUPPRESSMSGBOXES /NORESTART /NOCLOSEAPPLICATIONS /SP-' + 
  " /Log=`"$env:TEMP\$env:ChocolateyPackageName.$env:ChocolateyPackageVersion.Install.log`""
}

if ($32bit) {
  Write-Host "Installing 32-bit version"
  Install-ChocolateyPackage @packageArgs32
} else {
  Write-Host "Installing 64-bit version"
  Install-ChocolateyPackage @packageArgs64
}
