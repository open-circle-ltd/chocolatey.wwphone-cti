$ErrorActionPreference = 'Stop';
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$urlPackage = 'https://wwcom.ch/downloads/cti_4_0_107.exe' 
$checksumPackage = '33b6e71f752e100e03d196261b9fe5fb4f06ee6d3f66676eca5d8cbd914de0ba64842f9b11fb435e1247b7ca7d204b192b8d2dc1b42c5ee7a3b4ad276f2ea17e'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  fileType      = 'EXE'
  url           = $urlPackage
  softwareName  = 'cti*'
  checksum      = $checksumPackage
  checksumType  = 'sha512'
  silentArgs   = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-' + 
  " /Log=`"$env:TEMP\$env:ChocolateyPackageName.$env:ChocolateyPackageVersion.Install.log`""
}

Install-ChocolateyPackage @packageArgs