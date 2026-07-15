# 下载推荐产品/其它 products.TKLBLS.com.cn 图片
$base = "C:\Users\Hhhr\OneDrive\Desktop\dulizhan\shure-clone\images"
$urls = [System.IO.File]::ReadAllLines("$base\prod-imgs.txt")
$ua = "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 Chrome/120.0 Safari/537.36"
$cnt = 0
foreach ($u in $urls) {
  $u = $u.Trim()
  if ($u.Length -lt 10) { continue }
  # 用 hash 作为文件名
  $hash = ($u -split '/')[-1]
  $name = "prod_" + $hash
  $out = Join-Path $base $name
  try {
    Invoke-WebRequest -Uri $u -UserAgent $ua -OutFile $out -TimeoutSec 45
    $cnt++
    Write-Output ("OK " + (Get-Item $out).Length + " " + $name)
  } catch {
    Write-Output ("FAIL " + $u + " :: " + $_.Exception.Message)
  }
}
Write-Output ("---- PROD IMG DONE: " + $cnt)
