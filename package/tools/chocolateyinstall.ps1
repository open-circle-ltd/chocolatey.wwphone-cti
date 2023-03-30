$ErrorActionPreference = 'Stop';
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$urlPackage = 'https://wwcom.ch/downloads/cti_4_0_34.exe' 
$checksumPackage = '20b53d4cd1f045c24c7b236e3b269f35a87b6a9179b8cbc0207541cb832779ec36107885b485fc4ee5a012aaf6eddc6ba95b53875b0df483cf81ec0f789c05e0'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  fileType      = 'EXE'
  url           = $urlPackage
  softwareName  = 'cti*'
  checksum      = $checksumPackage
  checksumType  = 'sha512'
  silentArgs   = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
}

Install-ChocolateyPackage @packageArgs