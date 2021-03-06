Param
(
    [Switch]
    $tools,

    [Switch]
    $dev,

    [Switch]
    $vsext,

    [Switch]
    $installChoco,

    [Switch]
    $installVs

)

#
# General constants
# 
$vsixInstallerCommand2013 = "C:\Program Files (x86)\Microsoft Visual Studio 12.0\Common7\IDE\VsixInstaller.exe"
$vsixInstallerCommand2015 = "C:\Program Files (x86)\Microsoft Visual Studio 14.0\Common7\IDE\VSIXInstaller.exe"
$vsixInstallerCommandGeneralArgs = " /q /a "


#
# Function to create a path if it does not exist
#
function CreatePathIfNotExists($pathName) {
    if(!(Test-Path -Path $pathName)) {
        New-Item -ItemType directory -Path $pathName
    }
}

#
# Function to install VSIX extensions
#
function InstallVSExtension($extensionUrl, $extensionFileName, $vsVersion) {
    
    Write-Host "Installing extension " $extensionFileName
    
    # Select the appropriate VSIX installer
    if($vsVersion -eq "2013") {
        $vsixInstallerCommand = $vsixInstallerCommand2013
    }
    if($vsVersion -eq "2015") {
        $vsixInstallerCommand = $vsixInstallerCommand2015
    }

    # Download the extension
    wget $extensionUrl -OutFile $extensionFileName

    # Quiet Install of the Extension
    $proc = Start-Process -FilePath "$vsixInstallerCommand" -ArgumentList ($vsixInstallerCommandGeneralArgs + $extensionFileName) -PassThru
    $proc.WaitForExit()
    if ( $proc.ExitCode -ne 0 ) {
        Write-Host "Unable to install extension " $extensionFileName " due to error " $proc.ExitCode -ForegroundColor Red
    }

    # Delete the downloaded extension file from the local system
    Remove-Item $extensionFileName
}

#
# Chocolatey Installation script
# Pre-Requisites:
# - Microsoft Office latest version
# - Visual Studio 2013 latest version
#

if( $installChoco )
{
    Set-ExecutionPolicy unrestricted

    iex ((new-object net.webclient).DownloadString('https://chocolatey.org/install.ps1'))
}


#
# [tools] Tools needed on every machine
#

if( $tools ) {

    choco install -y dotnet4.6.1

    choco install -y keepass.install

    choco install -y 7zip

    choco install -y adobereader

    choco install -y googlechrome

    choco install -y  --allowemptychecksum paint.net

    choco install -y skype 

    choco install -y slack 

    choco install -y notepadplusplus

}


# 
# [ittools] IT-oriented tools
#

if( $ittools )
{

    choco install -y curl

    choco install -y wireshark

    choco install -y fiddler4

    choco install -y microsoft-message-analyzer 

    choco install -y  --allowemptychecksum putty

    choco install -y sysinternals

    choco install -y --allowemptychecksum ffmpeg 

    choco install -y  --allowemptychecksum winscp

    choco install -y virtualbox

    choco install -y virtualbox.extensionpack
    
    choco install -y visualstudiocode

    choco install -y --allowemptychecksum github

    choco install -y miniconda3

    choco install -y linqpad 

    choco install -y --allowemptychecksum ilspy 

}


#
# Visual Studio Extensions
#


if( $vsext) {

    # CodeMaid
    # https://visualstudiogallery.msdn.microsoft.com/76293c4d-8c16-4f4a-aee6-21f83a571496
    InstallVSExtension -extensionUrl "https://visualstudiogallery.msdn.microsoft.com/76293c4d-8c16-4f4a-aee6-21f83a571496/file/9356/31/CodeMaid_v0.8.0.vsix" `
                       -extensionFileName "CodeMaid.vsix" -vsVersion $vsVersion
    
    # Indent Guides
    # https://visualstudiogallery.msdn.microsoft.com/e792686d-542b-474a-8c55-630980e72c30
    InstallVSExtension -extensionUrl "https://visualstudiogallery.msdn.microsoft.com/e792686d-542b-474a-8c55-630980e72c30/file/48932/20/IndentGuide%20v14.vsix" `
                       -extensionFileName "IndentGuide.vsix" -vsVersion $vsVersion
    
    # Web Essentials 2015
    # https://visualstudiogallery.msdn.microsoft.com/ee6e6d8c-c837-41fb-886a-6b50ae2d06a2
    InstallVSExtension -extensionUrl "https://visualstudiogallery.msdn.microsoft.com/ee6e6d8c-c837-41fb-886a-6b50ae2d06a2/file/146119/37/Web%20Essentials%202015.1%20v1.0.207.vsix" `
                       -extensionFileName "WebEssentials2015.vsix" -vsVersion $vsVersion
    
    # jQuery Code Snippets
    # https://visualstudiogallery.msdn.microsoft.com/577b9c03-71fb-417b-bcbb-94b6d3d326b8
    InstallVSExtension -extensionUrl "https://visualstudiogallery.msdn.microsoft.com/577b9c03-71fb-417b-bcbb-94b6d3d326b8/file/84997/6/jQueryCodeSnippets.vsix" `
                       -extensionFileName "jQueryCodeSnippets.vsix" -vsVersion $vsVersion
    
    # F# PowerTools
    # https://visualstudiogallery.msdn.microsoft.com/136b942e-9f2c-4c0b-8bac-86d774189cff
    InstallVSExtension -extensionUrl "https://visualstudiogallery.msdn.microsoft.com/136b942e-9f2c-4c0b-8bac-86d774189cff/file/124201/33/FSharpVSPowerTools.vsix" `
                       -extensionFileName "FSharpPowerTools.vsix" -vsVersion $vsVersion
    
    # Snippet Designer
    # https://visualstudiogallery.msdn.microsoft.com/B08B0375-139E-41D7-AF9B-FAEE50F68392
    InstallVSExtension -extensionUrl "https://visualstudiogallery.msdn.microsoft.com/B08B0375-139E-41D7-AF9B-FAEE50F68392/file/5131/12/SnippetDesigner.vsix" `
                       -extensionFileName "SnippetDesigner.vsix" -vsVersion $vsVersion
    
    # SideWaffle Template Pack
    # https://visualstudiogallery.msdn.microsoft.com/a16c2d07-b2e1-4a25-87d9-194f04e7a698
    InstallVSExtension -extensionUrl "https://visualstudiogallery.msdn.microsoft.com/a16c2d07-b2e1-4a25-87d9-194f04e7a698/referral/110630" `
                       -extensionFileName "SideWaffle.vsix" -vsVersion $vsVersion
    
    # GraphEngine VSExt
    # https://visualstudiogallery.msdn.microsoft.com/12835dd2-2d0e-4b8e-9e7e-9f505bb909b8
    InstallVSExtension -extensionUrl "https://visualstudiogallery.msdn.microsoft.com/12835dd2-2d0e-4b8e-9e7e-9f505bb909b8/file/161997/14/GraphEngineVSExtension.vsix" `
                       -extensionFileName "GraphEngine.vsix" -vsVersion $vsVersion
    
    # Bing Developer Assistant
    # https://visualstudiogallery.msdn.microsoft.com/5d01e3bd-6433-47f2-9c6d-a9da52d172cc
    # Not using it anymore, distracts IntelliSense...
    InstallVSExtension -extensionUrl "https://visualstudiogallery.msdn.microsoft.com/5d01e3bd-6433-47f2-9c6d-a9da52d172cc/file/150980/8/DeveloperAssistant_2015.vsix" `
                       -extensionFileName "DevAssistant.vsix" -vsVersion $vsVersion
    
    # RegEx Tester
    # https://visualstudiogallery.msdn.microsoft.com/16b9d664-d88c-460e-84a5-700ab40ba452
    InstallVSExtension -extensionUrl "https://visualstudiogallery.msdn.microsoft.com/16b9d664-d88c-460e-84a5-700ab40ba452/file/31824/18/RegexTester-v1.5.2.vsix" `
                       -extensionFileName "RegExTester.vsix" -vsVersion $vsVersion
    
    # Web Compiler
    # https://visualstudiogallery.msdn.microsoft.com/3b329021-cd7a-4a01-86fc-714c2d05bb6c
    InstallVSExtension -extensionUrl "https://visualstudiogallery.msdn.microsoft.com/3b329021-cd7a-4a01-86fc-714c2d05bb6c/file/164873/38/Web%20Compiler%20v1.10.306.vsix" `
                       -extensionFileName "WebCompiler.vsix" -vsVersion $vsVersion
    
    # OpenCommandLine
    # https://visualstudiogallery.msdn.microsoft.com/4e84e2cf-2d6b-472a-b1e2-b84932511379
    InstallVSExtension -extensionUrl "https://visualstudiogallery.msdn.microsoft.com/4e84e2cf-2d6b-472a-b1e2-b84932511379/file/151803/35/Open%20Command%20Line%20v2.0.168.vsix" `
                       -extensionFileName "OpenCommandLine.vsix" -vsVersion $vsVersion
    
    # Refactoring Essentials for VS2015
    # https://visualstudiogallery.msdn.microsoft.com/68c1575b-e0bf-420d-a94b-1b0f4bcdcbcc
    InstallVSExtension -extensionUrl "https://visualstudiogallery.msdn.microsoft.com/68c1575b-e0bf-420d-a94b-1b0f4bcdcbcc/file/146895/20/RefactoringEssentials.vsix" `
                       -extensionFileName "RefactoringEssentials.vsix" -vsVersion $vsVersion
    
    # AllJoyn System Bridge Templates
    # https://visualstudiogallery.msdn.microsoft.com/aea0b437-ef07-42e3-bd88-8c7f906d5da8
    InstallVSExtension -extensionUrl "https://visualstudiogallery.msdn.microsoft.com/aea0b437-ef07-42e3-bd88-8c7f906d5da8/file/165147/8/DeviceSystemBridgeTemplate.vsix" `
                       -extensionFileName "AllJoynSysBridge.vsix" -vsVersion $vsVersion
    
    # ASP.NET Project Templates for traditional ASP.NET Projects
    # https://visualstudiogallery.msdn.microsoft.com/9402d38e-2a85-434e-8d6a-8fc075068a42
    InstallVSExtension -extensionUrl "https://visualstudiogallery.msdn.microsoft.com/9402d38e-2a85-434e-8d6a-8fc075068a42/referral/149131" `
                       -extensionFileName "AspNetTemplates.vsix" -vsVersion $vsVersion
                           
    # .Net Portability Analyzer
    # https://visualstudiogallery.msdn.microsoft.com/1177943e-cfb7-4822-a8a6-e56c7905292b
    InstallVSExtension -extensionUrl "https://visualstudiogallery.msdn.microsoft.com/1177943e-cfb7-4822-a8a6-e56c7905292b/file/138960/3/ApiPort.vsix" `
                       -extensionFileName "NetPortabilityAnalyzer.vsix" -vsVersion $vsVersion

    # Caliburn.Micro Windows 10 Templates for VS2015
    # https://visualstudiogallery.msdn.microsoft.com/b6683732-01ed-4bb3-a2d3-a633a5378997
    InstallVSExtension -extensionUrl "https://visualstudiogallery.msdn.microsoft.com/b6683732-01ed-4bb3-a2d3-a633a5378997/file/165880/5/CaliburnUniversalTemplatePackage.vsix" `
                       -extensionFileName "CaliburnTemplates.vsix" -vsVersion $vsVersion

    # Color Theme Editor
    # https://visualstudiogallery.msdn.microsoft.com/6f4b51b6-5c6b-4a81-9cb5-f2daa560430b
    InstallVSExtension -extensionUrl "https://visualstudiogallery.msdn.microsoft.com/6f4b51b6-5c6b-4a81-9cb5-f2daa560430b/file/169990/1/ColorThemeEditor.vsix" `
                       -extensionFileName "ColorThemeEditor.vsix" -vsVersion $vsVersion

    # Productivity Power Tools
    # https://visualstudiogallery.msdn.microsoft.com/34ebc6a2-2777-421d-8914-e29c1dfa7f5d
    InstallVSExtension -extensionUrl "https://visualstudiogallery.msdn.microsoft.com/34ebc6a2-2777-421d-8914-e29c1dfa7f5d/file/169971/1/ProPowerTools.vsix" `
                       -extensionFileName "ProPowerTools.vsix" -vsVersion $vsVersion
                       
}