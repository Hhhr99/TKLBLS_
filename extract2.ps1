<# DISABLED LEGACY BRAND LEARNING SCRIPT
$base = "C:\Users\Hhhr\OneDrive\Desktop\dulizhan\shure-clone\images"
$h = Get-Content "$base\page.html" -Raw -Encoding UTF8

# 提取 <title>
$t = [regex]::Match($h, '<title>(.*?)</title>')
if ($t.Success) { Write-Output ("TITLE=" + $t.Groups[1].Value) }

Write-Output "----META----"
$desc = [regex]::Match($h, '<meta name="description" content="([^"]*)"')
if ($desc.Success) { Write-Output ("DESC=" + $desc.Groups[1].Value) }

Write-Output "----H1/H2/H3----"
foreach ($tag in @('h1','h2','h3')) {
  $ms = [regex]::Matches($h, '<' + $tag + '[^>]*>([\s\S]*?)</' + $tag + '>')
  foreach ($m in $ms) {
    $txt = $m.Groups[1].Value -replace '<[^>]+>','' -replace '\s+',' '
    $txt = $txt.Trim()
    if ($txt.Length -gt 0 -and $txt.Length -lt 120) { Write-Output ($tag + ': ' + $txt) }
  }
}

Write-Output "----NAV LINKS----"
$nav = [regex]::Matches($h, '<a[^>]*href="([^"]*)"[^>]*>([\s\S]*?)</a>')
$n = 0
foreach ($m in $nav) {
  $txt = ($m.Groups[2].Value -replace '<[^>]+>','' -replace '\s+',' ').Trim()
  if ($txt.Length -gt 0 -and $txt.Length -lt 40) {
    Write-Output ($m.Groups[1].Value + ' :: ' + $txt)
    $n++
    if ($n -ge 80) { break }
  }
}

#>
