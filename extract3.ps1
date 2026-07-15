$base = "C:\Users\Hhhr\OneDrive\Desktop\dulizhan\shure-clone\images"
$css = Get-Content "$base\e5a9070c3bfc5cfe.css" -Raw

# 颜色变量定义 :root
$root = [regex]::Match($css, ':root\s*\{([^}]*)\}')
if ($root.Success) {
  Write-Output "----ROOT VARS----"
  Write-Output $root.Groups[1].Value
}

Write-Output "----HEX COLORS (top freq)----"
$colors = [regex]::Matches($css, '#([0-9a-fA-F]{3,6})(?![0-9a-fA-F])')
$grp = @()
foreach ($m in $colors) { $grp += $m.Value }
($grp | Group-Object | Sort-Object Count -Descending | Select-Object -First 30 | ForEach-Object { "$($_.Count)  $($_.Name)" })

Write-Output "----FONT FAMILY----"
$ff = [regex]::Matches($css, 'font-family\s*:\s*([^;}]+)')
$seen = @{}
foreach ($m in $ff) { $v = $m.Groups[1].Value.Trim(); if (-not $seen.ContainsKey($v)) { $seen[$v]=1; Write-Output $v } }
