<# DISABLED LEGACY BRAND LEARNING SCRIPT
# 强制下载所有 widen 图片到 images 目录
$base = "C:\Users\Hhhr\OneDrive\Desktop\dulizhan\shure-clone\images"
$content = [System.IO.File]::ReadAllLines("$base\all-images.txt")
$ua = "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 Chrome/120.0 Safari/537.36"
$i = 0
$okCount = 0; $failCount = 0
foreach ($line in $content) {
  $u = $line.Trim()
  if ($u.Length -lt 10) { continue }
  $i++
  $path = $u -replace 'https://shure.widen.net/content/',''
  $name = $path -replace '%[0-9A-Fa-f]{2}','_' -replace '[^A-Za-z0-9._\-]','_'
  if ($name.Length -gt 100) { $name = $name.Substring($name.Length - 100) }
  if ($name.Length -lt 5) { Write-Output ("BADNAME [" + $i + "] " + $u); continue }
  $out = Join-Path $base $name
  if ((Test-Path $out) -and ((Get-Item $out).Length -gt 0)) {
    $okCount++; continue
  }
  try {
    Invoke-WebRequest -Uri $u -UserAgent $ua -OutFile $out -TimeoutSec 45
    $sz = (Get-Item $out).Length
    $okCount++
    Write-Output ("OK [" + $i + "] " + $sz + " " + $name)
  } catch {
    $failCount++
    Write-Output ("FAIL [" + $i + "] " + $u + " :: " + $_.Exception.Message)
  }
}
Write-Output ("---- DONE ok=" + $okCount + " fail=" + $failCount + " total=" + $i)

#>
