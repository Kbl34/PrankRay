$Path="HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced"
Set-ItemProperty -Path $Path -Name "HideIcons" -Value 1
Get-Process "explorer"| Stop-Process


$url = "https://raw.githubusercontent.com/Kbl34/PrankRay/refs/heads/main/prank.png"


Invoke-WebRequest $url -OutFile C:\Users\Public\prank.png


$setwallpapersrc = @"
using System.Runtime.InteropServices;

public class Wallpaper
{
  public const int SetDesktopWallpaper = 20;
  public const int UpdateIniFile = 0x01;
  public const int SendWinIniChange = 0x02;
  [DllImport("user32.dll", SetLastError = true, CharSet = CharSet.Auto)]
  private static extern int SystemParametersInfo(int uAction, int uParam, string lpvParam, int fuWinIni);
  public static void SetWallpaper(string path)
  {
    SystemParametersInfo(SetDesktopWallpaper, 0, path, UpdateIniFile | SendWinIniChange);
  }
}
"@
Add-Type -TypeDefinition $setwallpapersrc

[Wallpaper]::SetWallpaper("C:\Users\Public\prank.png")


#Pop Up Message

function MsgBox {

[CmdletBinding()]
param (	
[Parameter (Mandatory = $True)]
[Alias("m")]
[string]$message,

[Parameter (Mandatory = $False)]
[Alias("t")]
[string]$title,

[Parameter (Mandatory = $False)]
[Alias("b")]
[ValidateSet('OK','OKCancel','YesNoCancel','YesNo')]
[string]$button,

[Parameter (Mandatory = $False)]
[Alias("i")]
[ValidateSet('None','Hand','Question','Warning','Asterisk')]
[string]$image
)

Add-Type -AssemblyName PresentationCore,PresentationFramework

if (!$title) {$title = " "}
if (!$button) {$button = "OK"}
if (!$image) {$image = "None"}

[System.Windows.MessageBox]::Show($message,$title,$button,$image)

}

MsgBox -m 'Your computer is infected by Ray ransomware' -t "Warning" -b OKCancel -i Warning
