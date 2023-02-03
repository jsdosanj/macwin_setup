# 1. Make sure to wipe Windows PC
# 2. Install Windows 11
# 3. Once you have created the admin account on the PC, run Windows updates
# 4. After Windows Updates have completed, you can follow the steps below:
#    1. Make sure the Microsoft App Installer is installed:https://www.microsoft.com/en-us/p/app-installer/9nblggh4nns1
#    2. Place the script on the Desktop
#    3. Open Terminal/PowerShell/CommandPrompt as Administrator
#    4. Go to the desktop with this command "C:\Users\admin\Desktop"
#    5. Run the command "Set-ExecutionPolicy RemoteSigned"
#    6. Run the command "./winsetupconfig.ps1"
#    7. Press Enter.
#    8. The command should start running and you will see progress bars for each application.
#    9. After the script has completed, please change the device name and restart the computer.

Write-Output("Uninstalling all the packaged crapware; we will leave Windows Store so anything can be replaced...")
DISM /Online /Get-ProvisionedAppxPackages | select-string Packagename | % {$_ -replace("PackageName : ", "")} | select-string "^((?!WindowsStore).)*$" | select-string "^((?!DesktopAppInstaller).)*$" | ForEach-Object {Remove-AppxPackage -allusers -package $_}

Write-Output("Installing Winget package manager...")
Add-AppxPackage 'https://aka.ms/Microsoft.VCLibs.x64.14.00.Desktop.appx'
Invoke-WebRequest https://www.nuget.org/api/v2/package/Microsoft.UI.Xaml/2.7.1 -OutFile ".\UI.Xaml.zip"
Expand-Archive .\UI.Xaml.zip -DestinationPath ".\uixaml"
Add-AppxPackage -Path ".\uixaml\tools\AppX\x64\Release\Microsoft.UI.Xaml.2.7.appx"
Add-AppxPackage 'https://github.com/microsoft/winget-cli/releases/download/v1.2.10271/Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.msixbundle'
Remove-Item .\uixaml\ -Recurse
Remove-Item .\UI.Xaml.zip

Write-Output("Uninstalling more crap we probably don't want, like apps for Spotify, and Disney+...")
winget uninstall "Cortana" --silent --accept-source-agreements
winget uninstall "Disney+" --silent --accept-source-agreements
winget uninstall "Mail and Calendar" --silent --accept-source-agreements
winget uninstall "Microsoft News" --silent --accept-source-agreements
winget uninstall "Microsoft OneDrive" --silent --accept-source-agreements
winget uninstall "Microsoft Tips" --silent --accept-source-agreements
winget uninstall "MSN Weather" --silent --accept-source-agreements
winget uninstall "Movies & TV" --silent --accept-source-agreements
winget uninstall "OneDrive" --silent --accept-source-agreements
winget uninstall "Spotify Music" --silent --accept-source-agreements
winget uninstall "Windows Maps" --silent --accept-source-agreements
winget uninstall "Xbox TCUI" --silent --accept-source-agreements
winget uninstall "Xbox Game Bar Plugin" --silent --accept-source-agreements
winget uninstall "Xbox Game Bar" --silent --accept-source-agreements
winget uninstall "Xbox Identity Provider" --silent --accept-source-agreements
winget uninstall "Xbox Game Speech Windows" --silent --accept-source-agreements

Write-Output("Installing Apps...")
winget install -e RandyRants.SharpKeys --accept-source-agreements 
winget install -e --id Microsoft.DotNet.DesktopRuntime.5 --silent --accept-source-agreements
winget install -e --id Microsoft.DotNet.DesktopRuntime.7 --silent --accept-source-agreements
winget install -e --id Microsoft.PowerShell --silent --accept-source-agreements
winget install -e --id Microsoft.OpenSSH.Beta --silent --accept-source-agreements
winget install -e --id Microsoft.PowerToys --silent --accept-source-agreements
winget install -e --id Microsoft.PowerBI --silent --accept-source-agreements
winget install -e --id Microsoft.Office --silent --accept-source-agreements
winget install -e --id Microsoft.Teams --silent --accept-source-agreements
winget install -e --id Microsoft.OneDrive.Enterprise --silent --accept-source-agreements
winget install -e --id Microsoft.VisualStudioCode --silent --accept-source-agreements
winget install -e --id Microsoft.RemoteDesktopClient --silent --accept-source-agreements
winget install -e --id Dell.CommandUpdate --silent --accept-source-agreements
winget install -e --id Dell.DisplayManager --silent --accept-source-agreements
winget install -e --id Google.Chrome --silent --accept-source-agreements
winget install -e --id Mozilla.Firefox --silent --accept-source-agreements
winget install -e --id Zoom.Zoom --silent --accept-source-agreements
winget install -e --id Adobe.Acrobat.Reader.64-bit --silent --accept-source-agreements
winget install -e --id VideoLAN.VLC --silent --accept-source-agreements
winget install -e --id Notepad++.Notepad++ --silent --accept-source-agreements
winget install -e --id Grammarly.Grammarly.Office --silent --accept-source-agreements
winget install -e --id Greenshot.Greenshot --silent --accept-source-agreements
winget install -e --id LogMeIn.LastPass --silent --accept-source-agreements
winget install -e --id Canva.Canva --silent --accept-source-agreements
winget install -e --id 7zip.7zip --silent --accept-source-agreements
Write-Output("Please manually install Sophos Central and Big-IP Edge Client")

Write-Output("Changing registry settings for taskbar, lockscreen, and more...")
# Set the Windows Taskbar to never combine items (Windows 7 style)
Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced' -Name 'TaskbarGlomLevel' -Value 2
# Set the Windows Taskbar to use small icons
Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced' -Name 'TaskbarSmallIcons' -Value 1
# Disable Chat, Widgets Taskbar Buttons
Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced' -Name 'TaskbarMn' -Value 0
Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced' -Name 'TaskbarDa' -Value 0
Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced' -Name 'ShowTaskViewButton' -Value 0
Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Search' -Name 'SearchboxTaskbarMode' -Value 0
# Show hidden files and folders
Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced' -Name 'Hidden' -Value 1
# Don't hide file extensions
Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced' -Name 'HideFileExt' -Value 1
# Don't include public folders in search (faster)
Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced' -Name 'Start_SearchFiles' -Value 1
# Disable Taskbar / Cortana Search Box on Windows 11
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Search" -Name "SearchboxTaskbarMode" -Value "00000000";

# Don't show ads / nonsense on the lockscreen
Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager' -Name 'ContentDeliveryAllowed' -Value 1
Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager' -Name 'RotatingLockScreenEnabled' -Value 1
Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager' -Name 'RotatingLockScreenOverlayEnabled' -Value 0
Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager' -Name 'SubscribedContent-338388Enabled' -Value 0
Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager' -Name 'SubscribedContent-338389Enabled' -Value 0
Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager' -Name 'SubscribedContent-88000326Enabled' -Value 0

# Set timezone automatically
Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\tzautoupdate" -Name "Start" -Value "00000003";

# Disable prompts to create an MSFT account
Set-ItemProperty -Path "HKLM:\Software\Microsoft\Windows\CurrentVersion\Policies\System" -Name "EnableLUA" -Value "00000000";

# Finally, stop and restart explorer.
Get-Process -Name explorer | Stop-Process
start explorer.exe

# Get Serial Number of device so you can rename the PC
Get-WmiObject win32_bios | select Serialnumber
Write-Output("Please set the device name using this naming standard:")
Write-Output("Department name-serial number Example: CAS-123456")
Write-Output("Please make sure to install Sophos Central and Big-IP Edge Client")
Write-Output("After installing every application and renaming the device,")
Write-Output("please restart your computer so all changes can be applied to the system.")
Write-Output("After restarting, please check for updates again.")