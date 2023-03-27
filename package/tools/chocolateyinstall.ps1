$ErrorActionPreference = 'Stop';
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$urlPackage = 'https://wwcom.ch/downloads/cti_4_0_32.exe' 
$checksumPackage = 'b6ee88ea281becfdb044fa0eca5593ab1ce8b2f5f5669bac77014afcd6bac45c8bf34e320b0c3f64452ca4ed99b6fb883ba9612991114ddccd8a24feedb707e7'

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