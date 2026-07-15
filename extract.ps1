$base = "C:\Users\Hhhr\OneDrive\Desktop\dulizhan\shure-clone\images"
$h = Get-Content "$base\page.html" -Raw -Encoding UTF8
Write-Output ("LENGTH=" + $h.Length)

Write-Output "----CSS----"
$css = [regex]::Matches($h, '<link[^>]*?href="([^"]+\.css[^"]*)"')
foreach ($m in $css) { Write-Output $m.Groups[1].Value }

Write-Output "----JS----"
$js = [regex]::Matches($h, '<script[^>]*?src="([^"]+)"')
foreach ($m in $js) { Write-Output $m.Groups[1].Value }

Write-Output "----IMAGES----"
$img = [regex]::Matches($h, '(?:src|data-src|content)="([^"]*\.(?:png|jpg|jpeg|svg|webp)[^"]*)"')
$i = 0
foreach ($m in $img) { Write-Output $m.Groups[1].Value; $i++; if ($i -ge 60) { break } }
