$base = "C:\Users\Hhhr\OneDrive\Desktop\dulizhan\shure-clone\images"
$cssUrls = @(
  "https://www.shure.com.cn/shureredesign/_next/static/css/e5a9070c3bfc5cfe.css",
  "https://www.shure.com.cn/shureredesign/_next/static/css/e3f23e111b874094.css"
)
$ua = "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 Chrome/120.0 Safari/537.36"
foreach ($u in $cssUrls) {
  $name = Split-Path $u -Leaf
  $out = "$base\$name"
  try { Invoke-WebRequest -Uri $u -UserAgent $ua -OutFile $out -TimeoutSec 30 }
  catch { Write-Output ("FAIL " + $u + " : " + $_.Exception.Message) }
}
Get-ChildItem "$base\*.css" | Select-Object Name,Length
