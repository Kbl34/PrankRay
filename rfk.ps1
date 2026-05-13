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
Add-Type -AssemblyName PresentationFramework

$form = New-Object Windows.Window
$form.Title = "ALERTE"
$form.Width = 520
$form.Height = 260
$form.WindowStartupLocation = "CenterScreen"
$form.ResizeMode = "NoResize"
$form.Topmost = $true

$stack = New-Object Windows.Controls.StackPanel
$stack.Margin = "20"

$title = New-Object Windows.Controls.TextBlock
$title.Text = "Sensibilisation Cyber"
$title.FontSize = 28
$title.FontWeight = "Bold"
$title.TextAlignment = "Center"
$title.Margin = "0,0,0,20"

$msg = New-Object Windows.Controls.TextBlock
$msg.Text = "Verrouillez votre session en quittant votre poste"
$msg.FontSize = 18
$msg.TextAlignment = "Center"
$msg.TextWrapping = "Wrap"
$msg.Margin = "0,0,0,25"

$button = New-Object Windows.Controls.Button
$button.Content = "Compris"
$button.Width = 120
$button.Height = 35
$button.HorizontalAlignment = "Center"

$button.Add_Click({ $form.Close() })

$stack.Children.Add($title)
$stack.Children.Add($msg)
$stack.Children.Add($button)

$form.Content = $stack
$form.ShowDialog() | Out-Null
