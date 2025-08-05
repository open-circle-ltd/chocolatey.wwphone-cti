$ErrorActionPreference = 'Stop';
$PackageParameters = Get-PackageParameters
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url = 'https://wwcom.ch/downloads/cti_4_1_12.exe' 
$url64 = 'https://wwcom.ch/downloads/cti64_4_1_12.exe'
$checksum = '05c41e7020a30d26885c29c99f04c55f33a5732ea8f992f7de2248911bb3baf612a52028a6c158abe1d974743bf1b817bde005857a16ea113c5df1c6130b0ac8'
$checksum64 = '58b633a8b5570756d5c03772d49fc34591f847e2aa662df088389ea4015ae47f2620924fca165b562605d9aa7acf3c1861d4e0a4a26e1dec96c11049026b6fcb'

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
