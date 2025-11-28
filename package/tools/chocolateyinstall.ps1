$ErrorActionPreference = 'Stop';
$PackageParameters = Get-PackageParameters
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url = 'https://wwcom.ch/downloads/cti_4_2_7.exe'
$url64 = 'https://wwcom.ch/downloads/cti64_4_2_7.exe'
$checksum = 'c5f2238b4e7872c08e0452376189521a44e37dcbf9e0df5f09933285924fa625fed35650fce045dcc989b0b2fcc554514389c543c4a22116f7be4b1326377514'
$checksum64 = '64fb13603af1ba17b312e17381dcad273d1bf18c2aa303d59b813983f898b7d51136de327a7b6d8d4e75860f5aa3a07e744dc758aa08fac4f68b065e0a9ae1b9'

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
