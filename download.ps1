# 下载所有 TKLBLS.widen.net 图片到本地 images 目录
$base = "C:\Users\Hhhr\OneDrive\Desktop\dulizhan\shure-clone\images"
$urls = Get-Content "$base\all-images.txt" | Where-Object { $_.Trim().Length -gt 0 }
$ua = "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 Chrome/120.0 Safari/537.36"
$map = @()
$i = 0
foreach ($u in $urls) {
  $i++
  # 从 URL 取末段作为文件名 (已URL编码, 解码)
  $path = $u -replace 'https://shure.widen.net/content/',''
  # 用 id+文件名,但确保合法 windows 文件名
  $name = $path -replace '%[0-9A-Fa-f]{2}','_' -replace '[^A-Za-z0-9._\-]','_'
  # 限制长度
  if ($name.Length -gt 90) { $name = $name.Substring($name.Length - 90) }
  $out = "$base\$name"
  if (-not (Test-Path $out)) {
    try {
      Invoke-WebRequest -Uri $u -UserAgent $ua -OutFile $out -TimeoutSec 40
      Write-Output ("OK [" + $i + "] " + $name)
    } catch {
      Write-Output ("FAIL [" + $i + "] " + $u + " : " + $_.Exception.Message)
    }
  } else {
    Write-Output ("SKIP [" + $i + "] " + $name)
  }
  $map += "$u|$name"
}
$map | Out-File "$base\url-map.txt" -Encoding UTF8
Write-Output "----DONE----"
Get-ChildItem "$base" -Include *.webp,*.jpeg,*.jpg,*.png -File | Measure-Object | ForEach-Object { Write-Output ("Files: " + $_.Count) }
