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
[string]$title
)

Add-Type -AssemblyName PresentationFramework

if (!$title) {
    $title = "Sensibilisation Cybersécurité"
}

[xml]$xaml = @"
<Window
 xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
 Title="$title"
 Height="260"
 Width="520"
 WindowStartupLocation="CenterScreen"
 ResizeMode="NoResize"
 Topmost="True">

    <Grid Margin="20">
        <StackPanel VerticalAlignment="Center">

            <TextBlock
                Text="⚠ Votre session est restée ouverte"
                FontFamily="Segoe UI"
                FontSize="28"
                FontWeight="Bold"
                Margin="0,0,0,20"
                TextAlignment="Center"/>

            <TextBlock
                Text="$message"
                FontSize="18"
                TextAlignment="Center"
                Margin="0,0,0,25"
                TextWrapping="Wrap"/>

            <Button
                Name="OKButton"
                Content="Compris"
                Width="120"
                Height="35"
                HorizontalAlignment="Center"/>

        </StackPanel>
    </Grid>
</Window>
"@

$reader = New-Object System.Xml.XmlNodeReader $xaml
$window = [Windows.Markup.XamlReader]::Load($reader)

$button = $window.FindName("OKButton")
$button.Add_Click({ $window.Close() })

$window.ShowDialog() | Out-Null

}

MsgBox -m "Pensez à verrouiller votre poste avec WIN + L"
