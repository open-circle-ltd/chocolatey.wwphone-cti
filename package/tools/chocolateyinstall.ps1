$ErrorActionPreference = 'Stop';
$PackageParameters = Get-PackageParameters
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url = 'https://wwcom.ch/downloads/cti_4_3_1.exe'
$url64 = 'https://wwcom.ch/downloads/cti64_4_3_1.exe'
$checksum = '4460b1522bf05635e4bf8db671e83dcf63937488b4c341fe4b5595ed2d2239a9de5f7ef23f37294ae74778f58e24c3d2ea1c253b88954fe5ef8d316e1512f9ec'
$checksum64 = 'eee72e8d937b5925a90fd3c8e5d256655386d3eeb327f168664f8cbf73ecfc25e6af7619c4ab53dc9763a2945501e3b5f9c3384a5ed1dad109bd97ab7c174edb'

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
