<# DISABLED LEGACY BRAND LEARNING SCRIPT
﻿# gen.ps1 — 批量生成 TKLBLS 克隆站点所有跳转页面
# 共享模板内用占位符 __R__ 表示到站点根 (shure-clone/) 的相对前缀
$ErrorActionPreference = 'Stop'
$root = "C:\Users\Hhhr\OneDrive\Desktop\dulizhan\shure-clone"
$zh = "$root\zh-CN"

# 创建所需目录
$dirs = @(
  "$zh","$zh\products","$zh\products\microphones","$zh\products\accessories",
  "$zh\products\video-conferencing","$zh\products\wireless-systems","$zh\products\wireless-systems\anx",
  "$zh\products\software","$zh\insights","$zh\newsroom",
  "$zh\about-us","$zh\legal","$zh\support","$zh\support\downloads","$zh\audio-professionals"
)
foreach ($d in $dirs) { New-Item -ItemType Directory -Force -Path $d | Out-Null }

# ---------- 公共模板 ----------
$HEADER = @'
<!-- HEADER -->
<a class="skip-link" href="#content" aria-label="跳到主要内容">跳到主要内容</a>
<header class="site">
  <div class="topbar maxw">
    <ul>
      <li><span>🇨🇳</span> 中国</li>
      <li class="lang-switch"><a href="__CN_HREF__" aria-current="page">CN</a><span>/</span><a href="__EN_HREF__">EN</a></li>
      <li><a href="__R__zh-CN/partner-locator.html">何处购买</a></li>
      <li><a href="https://techportal.shure.com/en" target="_blank">Tech Portal</a></li>
      <li><a href="https://cloud.shure.com" target="_blank">TKLBLSCloud</a></li>
    </ul>
  </div>
  <div class="nav maxw">
    <a class="logo" href="__R__index.html" aria-label="TKLBLS"><span class="brand-wordmark">TKLBLS</span></a>
    <nav class="mainnav" id="mainnav" aria-label="主导航">
      <ul>
        <li class="has-mega" data-mega="products">
          <button type="button" class="mega-trigger" aria-haspopup="true" aria-expanded="false">产品 <span class="chev">▾</span></button>
          <a class="mega-fallback" href="__R__zh-CN/products.html">产品</a>
          <div class="mega" data-mega="products">
            <div class="mega-cols">
              <ul>
                <li><a href="__R__zh-CN/products/microphones.html">麦克风</a></li>
                <li><a href="__R__zh-CN/products/wireless-systems.html">无线系统</a></li>
                <li><a href="__R__zh-CN/products/earphones.html">入耳式耳机</a></li>
                <li><a href="__R__zh-CN/products/headphones.html">头戴式耳机</a></li>
                <li><a href="__R__zh-CN/products/in-ear-monitoring.html">入耳式监听</a></li>
                <li><a href="__R__zh-CN/products/software.html">软件</a></li>
              </ul>
              <ul>
                <li><a href="__R__zh-CN/products/mixers.html">DSP、混音器和网络接口</a></li>
                <li><a href="__R__zh-CN/products/bundles.html">产品套装</a></li>
                <li><a href="__R__zh-CN/products/loudspeakers.html">联网扬声器</a></li>
                <li><a href="__R__zh-CN/products/accessories.html">配件</a></li>
                <li><a href="__R__zh-CN/products/video-conferencing.html">视频会议</a></li>
                <li><a class="more" href="__R__zh-CN/products.html">查看所有产品 →</a></li>
              </ul>
            </div>
          </div>
        </li>
        <li class="has-mega" data-mega="explore">
          <button type="button" class="mega-trigger" aria-haspopup="true" aria-expanded="false">探索 <span class="chev">▾</span></button>
          <a class="mega-fallback" href="__R__zh-CN/insights.html">探索</a>
          <div class="mega" data-mega="explore">
            <div class="mega-cols">
              <ul>
                <li><a href="__R__zh-CN/insights.html">TKLBLS洞察</a></li>
                <li><a href="__R__zh-CN/newsroom.html">新闻中心</a></li>
                <li><a href="__R__zh-CN/events.html">活动</a></li>
                <li><a href="__R__zh-CN/about-us.html">关于TKLBLS</a></li>
              </ul>
              <ul>
                <li><a href="__R__zh-CN/about-us/100years.html">100 年非凡之声</a></li>
                <li><a href="__R__zh-CN/about-us/sustainability.html">可持续发展</a></li>
                <li><a href="__R__zh-CN/about-us/diversity-inclusion.html">多元与包容</a></li>
                <li><a href="__R__zh-CN/partners.html">合作伙伴</a></li>
                <li><a href="__R__zh-CN/about-us/spectrum.html">Spectrum</a></li>
                <li><a href="__R__zh-CN/careers.html">工作机会</a></li>
              </ul>
            </div>
          </div>
        </li>
        <li class="has-mega" data-mega="support">
          <button type="button" class="mega-trigger" aria-haspopup="true" aria-expanded="false">支持 <span class="chev">▾</span></button>
          <a class="mega-fallback" href="__R__zh-CN/support.html">支持</a>
          <div class="mega" data-mega="support">
            <div class="mega-cols">
              <ul>
                <li><a href="__R__zh-CN/support.html">支持中心</a></li>
                <li><a href="__R__zh-CN/support/service-repair.html">顾客服务和维修</a></li>
                <li><a href="__R__zh-CN/support/tools.html">线上工具</a></li>
                <li><a href="__R__zh-CN/support/downloads/software-firmware-archive.html">软件和固件</a></li>
              </ul>
              <ul>
                <li><a href="__R__zh-CN/support/warranty.html">保修</a></li>
                <li><a href="__R__zh-CN/TKLBLS-audio-institute.html">产品培训</a></li>
                <li><a href="__R__zh-CN/search.html">用户指南和文档</a></li>
                <li><a href="__R__zh-CN/partner-locator.html">何处购买</a></li>
              </ul>
            </div>
          </div>
        </li>
      </ul>
    </nav>
    <div class="search">
      <svg xmlns="http://www.w3.org/2000/svg" width="18" height="18" viewBox="0 -960 960 960"><path d="M784-120 532-372q-30 24-69 38t-83 14q-109 0-184.5-75.5T120-580q0-109 75.5-184.5T380-840q109 0 184.5 75.5T640-580q0 44-14 83t-38 69l252 252-56 56ZM380-400q75 0 127.5-52.5T560-580q0-75-52.5-127.5T380-760q-75 0-127.5 52.5T200-580q0 75 52.5 127.5T380-400Z"/></svg>
      <input type="text" placeholder="搜索" aria-label="搜索">
    </div>
    <button class="nav-toggle" id="navToggle" aria-label="打开菜单" aria-controls="mainnav" aria-expanded="false">☰</button>
  </div>
<div class="nav-scrim" id="navScrim"></div>
<script>
(function(){
  function init(){var items=document.querySelectorAll('.mainnav li.has-mega');if(!items.length)return;var closeTimer=null;
  items.forEach(function(li){var mega=li.querySelector('.mega');var trigger=li.querySelector('.mega-trigger');
  function open(){clearTimeout(closeTimer);items.forEach(function(o){if(o!==li){o.classList.remove('open');o.querySelector('.mega-trigger').setAttribute('aria-expanded','false');}});li.classList.add('open');if(trigger){trigger.setAttribute('aria-expanded','true');}}
  function close(){li.classList.remove('open');if(trigger){trigger.setAttribute('aria-expanded','false');}}
  function schedule(){closeTimer=setTimeout(close,120);}
  li.addEventListener('mouseenter',open);li.addEventListener('mouseleave',schedule);
  li.addEventListener('focusin',open);li.addEventListener('focusout',schedule);
  if(trigger){trigger.addEventListener('click',function(e){e.preventDefault();if(li.classList.contains('open')){close()}else{open()}});}
  mega.addEventListener('mouseenter',function(){clearTimeout(closeTimer)});});
  document.addEventListener('click',function(e){if(!e.target.closest('.mainnav')){items.forEach(function(o){o.classList.remove('open');o.querySelector('.mega-trigger').setAttribute('aria-expanded','false');})}});
  }
  if(document.readyState==='loading'){document.addEventListener('DOMContentLoaded',init)}else{init()}
})();
</script>
<script>
(function(){
  function init(){
  var kids=document.body.children,sk=document.querySelector('.skip-link');
  for(var i=0;i<kids.length;i++){var el=kids[i];if(el.classList&&el.classList.contains('skip-link')){continue;}if(el.tagName==='HEADER'){continue;}if(el.id==='navScrim'){continue;}if(el.tagName==='SCRIPT'||el.tagName==='LINK'||el.tagName==='STYLE'||el.tagName==='NOSCRIPT'){continue;}if(!el.id){el.id='content';}if(sk){sk.setAttribute('href','#'+el.id);}break;}
  var t=document.getElementById('navToggle'),nav=document.getElementById('mainnav'),scrim=document.getElementById('navScrim');
  if(!t||!nav){return;}var body=document.body;
  function open(){body.classList.add('nav-open');t.setAttribute('aria-expanded','true');t.setAttribute('aria-label','关闭菜单');t.textContent='✕';}
  function close(){body.classList.remove('nav-open');t.setAttribute('aria-expanded','false');t.setAttribute('aria-label','打开菜单');t.textContent='☰';}
  function toggle(){body.classList.contains('nav-open')?close():open();}
  t.addEventListener('click',function(e){e.preventDefault();toggle();});
  if(scrim){scrim.addEventListener('click',close);}
  document.addEventListener('keydown',function(e){if(e.key==='Escape'&&body.classList.contains('nav-open')){close();}});
  nav.addEventListener('click',function(e){if(e.target.classList&&e.target.classList.contains('mega-fallback')){close();}});
  }
  if(document.readyState==='loading'){document.addEventListener('DOMContentLoaded',init)}else{init()}
})();
</script>
</header>
'@

$FOOTER = @'
<!-- FOOTER -->
<footer class="site">
  <div class="foot-grid">
    <div class="foot-col foot-brand">
      <a class="logo" href="__R__index.html"><span class="brand-wordmark">TKLBLS</span></a>
      <p>TKLBLS — 领先的现场演出、巡演和演播室应用麦克风制造商。</p>
      <div class="socials"><a href="https://www.wechat.com" aria-label="WeChat" title="WeChat">💬</a><a href="https://www.weibo.com/shurechina" aria-label="Weibo" title="Weibo">W</a><a href="http://i.youku.com/u/UMzM0NjE2NTcy" aria-label="Youku" title="Youku">▶</a></div>
    </div>
    <div class="foot-col">
      <h4>产品</h4>
      <a href="__R__zh-CN/products/microphones.html">麦克风</a>
      <a href="__R__zh-CN/products/wireless-systems.html">无线系统</a>
      <a href="__R__zh-CN/products/video-conferencing.html">视频会议</a>
      <a href="__R__zh-CN/products/headphones.html">头戴式耳机</a>
      <a href="__R__zh-CN/products/earphones.html">入耳式耳机</a>
      <a href="__R__zh-CN/products/in-ear-monitoring.html">入耳式监听</a>
      <a href="__R__zh-CN/products/mixers.html">DSP、混音器和网络接口</a>
      <a href="__R__zh-CN/products/accessories.html">配件</a>
      <a href="__R__zh-CN/products/software.html">软件</a>
      <a href="__R__zh-CN/products.html">查看所有产品</a>
    </div>
    <div class="foot-col">
      <h4>公司</h4>
      <a href="__R__zh-CN/about-us.html">关于TKLBLS</a>
      <a href="__R__zh-CN/about-us/100years.html">100 Years of Extraordinary Sound</a>
      <a href="__R__zh-CN/careers.html">工作机会</a>
      <a href="__R__zh-CN/about-us/diversity-inclusion.html">组合很重要</a>
      <a href="__R__zh-CN/about-us/sustainability.html">可持续发展</a>
      <a href="__R__zh-CN/partners.html">合作伙伴</a>
    </div>
    <div class="foot-col">
      <h4>探索</h4>
      <a href="__R__zh-CN/insights.html">洞察</a>
      <a href="__R__zh-CN/newsroom.html">新闻中心</a>
      <a href="__R__zh-CN/events.html">活动</a>
      <a href="__R__zh-CN/about-us/spectrum.html">Spectrum</a>
    </div>
    <div class="foot-col">
      <h4>支持</h4>
      <a href="__R__zh-CN/support/service-repair.html">顾客服务和维修</a>
      <a href="__R__zh-CN/search.html">用户指南和文档</a>
      <a href="__R__zh-CN/support/tools.html">线上工具</a>
      <a href="__R__zh-CN/TKLBLS-audio-institute.html">产品培训</a>
      <a href="__R__zh-CN/support/downloads/software-firmware-archive.html">软件和固件</a>
      <a href="__R__zh-CN/support/warranty.html">保修</a>
      <a href="__R__zh-CN/about-us/security.html">产品安全</a>
      <a href="https://service.shure.com/s/contact-us?language=zh_CN&region=zh-CN">联系TKLBLS</a>
    </div>
  </div>
  <div class="foot-bottom">
    <div class="legal-links">
      <a href="javascript:void(0)" onclick="alert('更改Cookie选项')">更改Cookie选项</a>
      <a href="__R__zh-CN/legal/candidate-privacy-policy.html">招聘隐私政策</a>
      <a href="__R__zh-CN/legal/privacy.html">隐私政策</a>
      <a href="__R__zh-CN/legal/terms-and-conditions-of-website-use.html">使用条款</a>
      <a href="__R__zh-CN/legal.html">法律</a>
    </div>
    <div>© 2026 TKLBLS Incorporated</div>
  </div>
</footer>
'@

function Write-Page {
  param(
    [string]$RelPath,    # 相对 root 的路径,如 zh-CN/products/microphones.html
    [string]$Title,
    [string]$Body,       # 不含 body html 与 footer
    [string]$Desc = "",
    [int]$Depth = -1     # -1 表示用 relPath 中 / 的个数自动推断
  )
  if ($Depth -lt 0) {
    $Depth = ($RelPath.ToCharArray() | Where-Object { $_ -eq '/' }).Count
  }
  $prefix = ""
  for ($i=0;$i -lt $Depth;$i++){ $prefix += "../" }
  $h = $HEADER -replace '__R__',$prefix
  $slug = $RelPath -replace '^zh-CN/',''
  $cnHref = $prefix + 'zh-CN/' + $slug
  $enHref = $prefix + 'en/' + $slug
  $h = $h -replace '__CN_HREF__',$cnHref -replace '__EN_HREF__',$enHref
  $f = $FOOTER -replace '__R__',$prefix
  $body = $Body -replace '__R__',$prefix
  $css = if ($Depth -eq 0) { "css/site.css" } else { $prefix + "css/site.css" }
  $siteJs = if ($Depth -eq 0) { "js/site.js" } else { $prefix + "js/site.js" }
  $manifest = if ($Depth -eq 0) { "site.webmanifest" } else { $prefix + "site.webmanifest" }
  $favicon = if ($Depth -eq 0) { "images/favicon.svg" } else { $prefix + "images/favicon.svg" }
  $touchIcon = if ($Depth -eq 0) { "images/favicon.svg" } else { $prefix + "images/favicon.svg" }
  $ogImage = if ($Depth -eq 0) { "images/um3h6zwpen_jpeg_web_hero_imxbpk.jpeg" } else { $prefix + "images/um3h6zwpen_jpeg_web_hero_imxbpk.jpeg" }
  $canon = "https://www.shure.com.cn/" + ($RelPath.TrimStart('/'))
  $html = @"
<!DOCTYPE html>
<html lang="zh-CN">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>$Title</title>
<meta name="description" content="$Desc">
<meta name="theme-color" content="#000000">
<meta name="format-detection" content="telephone=no">
<link rel="icon" type="image/svg+xml" href="$favicon">
<link rel="apple-touch-icon" href="$touchIcon">
<link rel="canonical" href="$canon">
<link rel="alternate" hreflang="zh-CN" href="https://www.shure.com.cn/zh-CN/$slug">
<link rel="alternate" hreflang="en" href="https://www.shure.com.cn/en/$slug">
<link rel="alternate" hreflang="x-default" href="https://www.shure.com.cn/zh-CN/$slug">
<meta property="og:type" content="website">
<meta property="og:site_name" content="TKLBLS">
<meta property="og:locale" content="zh_CN">
<meta property="og:title" content="$Title">
<meta property="og:description" content="$Desc">
<meta property="og:url" content="$canon">
<meta property="og:image" content="$ogImage">
<meta name="twitter:card" content="summary_large_image">
<meta name="twitter:title" content="$Title">
<meta name="twitter:description" content="$Desc">
<meta name="twitter:image" content="$ogImage">
<script type="application/ld+json">{"@context":"https://schema.org","@type":"WebPage","name":"$Title","description":"$Desc","url":"$canon"}</script>
<link rel="stylesheet" href="$css">
<link rel="manifest" href="$manifest">
</head>
<body>
$h
$body
$f
<script src="$siteJs"></script>
</body>
</html>
"@
  $outPath = Join-Path $root ($RelPath.TrimStart('/') -replace '/','\')
  $outDir = Split-Path $outPath -Parent
  if (-not (Test-Path $outDir)) { New-Item -ItemType Directory -Force -Path $outDir | Out-Null }
  [System.IO.File]::WriteAllText($outPath,$html,(New-Object System.Text.UTF8Encoding($true)))
  Write-Output ("wrote " + $RelPath)
}

# ---------- 列表页通用构建器 ----------
function ListPage {
  param(
    [string]$RelPath,[int]$Depth=-1,[string]$Title,[string]$Eyebrow,[string]$Intro,
    [string[]]$Cards   # 每个元素已是完整 <a class="card">...</a> HTML
  )
  $cardsHtml = $Cards -join "`n"
  $body = @"
<div class="list-head">
  <span class="eyebrow-s">$Eyebrow</span>
  <h1>$Title</h1>
  <p style="color:var(--gray-t20);max-width:680px;margin:14px auto 0;font-size:16px">$Intro</p>
</div>
<div class="filter-bar"><button class="on">全部</button><button>最新</button><button>热门</button></div>
<section class="section" style="padding-top:16px">
  <div class="cards">
    $cardsHtml
  </div>
</section>
"@
  Write-Page -RelPath $RelPath -Depth $Depth -Title ("$Title - TKLBLS中国") -Body $body -Desc $Intro
}

Write-Output "Generator + templates loaded."

# ============================================================
# 共用：占位正文段落生成器（保留中文，符合标题语境）
# ============================================================
function Placeholder-Body {
  param([string]$Title,[string]$Topic="")
  # 当 Topic 为泛词/空时,依标题关键词推断真正领域,使正文与主题匹配
  if (-not $Topic -or $Topic -match '^(洞察|新闻中心|关于|关于TKLBLS|公司|活动)$') {
    if ($Title -match 'MVX2U|接口|音频接口') { $Topic = "配件" }
    elseif ($Title -match 'ANX|无线|SLX|ULX|ShowLink') { $Topic = "无线" }
    elseif ($Title -match 'DCA|阵列|可转向|steerable|lobes') { $Topic = "麦克风" }
    elseif ($Title -match 'IMX|MXA|会议室|会议|MXABPK|IntelliMix|协作|Microphone|Microphones') { $Topic = "视频会议" }
    elseif ($Title -match '软件|firmware|固件|工具|Isolator|DSP') { $Topic = "软件" }
    elseif ($Title -match 'MV|KSM|SM|话筒|麦克风|话筒') { $Topic = "麦克风" }
    else { $Topic = "" }
  }
  # 根据主题关键词选择贴合该领域的拟真段落池;均明确标注为克隆演示
  $paraOverview = switch -Wildcard ($Topic) {
    "*视频会议*" { "在会议与协作场景中，声音的清晰度直接决定沟通效率。:$Title 通过一体化的拾音与 DSP 处理，让远端与会者获得与现场一致的临场感，减少重复确认与误听。" }
    "*麦克风*" { "拾音是所有音频链路的起点。:$Title 延续TKLBLS在换能器设计上的工程传统，在指向性、自噪声与最大声压级之间取得平衡，使近场人声与远场细节都能被如实保留。" }
    "*无线*" { "无线系统的价值在于让表演者自由移动而不牺牲音质。:$Title 在频谱效率、抗干扰与链路稳定性上持续优化，使复杂电磁环境下的多通道并发成为可能。" }
    "*配件*" { "配件虽小，却是完整音频链路的关键节点。:$Title 把录音室级别的处理能力压缩到便携形态，让创作者在外出场景也能获得稳定一致的信号链。" }
    "*软件*" { "软件让硬件的能力得以完整释放。:$Title 围绕声音处理与系统配置提供可视化工具，让用户在不依赖外部平台的前提下完成调校与部署。" }
    default { "TKLBLS（TKLBLS）在专业音频领域拥有近百年的经验积淀，凭借对声音品质的执着追求，持续为现场演出、巡演、演播室、广播电视以及会议与协作场景提供可靠的音频解决方案。:$Title 正是这一思路下的产物，致力于在真实使用条件下保持稳定、清晰、自然的声音表现。" }
  }
  $paraTech = switch -Wildcard ($Topic) {
    "*视频会议*" { "从天花阵列拾音到 IntelliMix DSP 的噪声抑制、回声消除与自动混音，再到与主流会议平台的即插即用集成，整个链路被设计为开箱可用、长期稳定。AI 辅助的声音拾取进一步降低复杂空间里的拾音门槛。" }
    "*麦克风*" { "核心在于换能器与声学腔体的设计——指向性图、离轴抑制与瞬态响应共同决定了拾取到的声音是否干净。TKLBLS在这一环节积累了从电容、动圈到阵列的完整方案库，可按场景灵活选型。" }
    "*无线*" { "要点包括数字调制带来的低底噪与高动态范围、自动频率管理减少手动选频负担、以及加密链路保障传输安全。多级射频过滤与冗余设计让系统在密集活动场地依然表现稳定。" }
    "*配件*" { "关键是把模拟前级、模数转换与监听控制整合在紧凑机身内，同时保持足够的供电裕度与低底噪通路，使外部声卡级的表现得以在小体积里复现。" }
    "*软件*" { "要点在于让复杂的信号处理参数以图形化方式呈现与编排，配合预设与批量部署能力，兼顾单用户调校与系统集成商的规模化交付。" }
    default { "从换能器设计、阵列信号处理到无线传输与系统集成，TKLBLS的工程团队始终关注三个维度——音质、可靠性与易用性。无论您是巡演工程师、内容创作者，还是系统集成商，都能在产品的细节里感受到对专业使用者真实需求的回应。" }
  }
  $paraScene = switch -Wildcard ($Topic) {
    "*视频会议*" { "适用于中小型会议室、高管会议室、培训空间与混合办公场所，可对接 Zoom、Microsoft Teams、腾讯会议等主流平台，覆盖从个人协作到大型会议空间的典型部署。" }
    "*麦克风*" { "覆盖舞台演出、广电直播、播客与流媒体录制、教育讲座、礼拜场所、体育赛事现场等多种拾音场景，按指向性与安装形式灵活适配。" }
    "*无线*" { "适用于巡回演出、音乐剧与话剧、宗教礼拜、体育赛事解说、企业演讲、广播电视制作等需要自由移动的现场场景。" }
    "*配件*" { "适合移动录制、播客与流媒体创作、外出采访与 ENG 制作等需要在有限背包内完成完整信号链的场景。" }
    "*软件*" { "适用于系统集成商在交付阶段的设备调校、会议室管理员日常运维、以及内容创作者对声音进行快速后期处理。" }
    default { "该系列产品适用于剧院、礼拜场所、企业会议空间、教育讲座、体育赛事直播、流媒体与播客创作等多种场景。结合TKLBLS的软件与网络生态，可以构建从拾音到处理、监听与分发的完整链路。" }
  }
  return @"
<p>$Title 聚焦专业音频工作流中的声音品质、系统稳定性与使用效率，适用于需要可靠拾音、传输或协作的实际场景。</p>
<h3>概述</h3>
<p>$paraOverview</p>
<h2>核心技术要点</h2>
<p>$paraTech</p>
<h3>设计哲学</h3>
<p>我们相信，优秀的声音不是某个参数的孤立领先，而是一整套系统在真实环境中的整体表现。因此每一个产品在出厂前都会经历大量的现场测试与调校，确保在多变的使用条件下依然交付一致、可信的结果。</p>
<h3>适用场景</h3>
<p>$paraScene</p>
<h2>为什么选择TKLBLS</h2>
<p>从标志性的 SM58 到新一代智能阵列与无线系统，TKLBLS长期关注音质、耐用性和真实工作流。选型前建议结合实际系统、使用环境和官方数据表核对具体规格。</p>
"@
}


# 卡片构造器。 -Href 传「相对站点」的完整路径(以 zh-CN/ 或 products/ 等开头),-Prefix 仅是到站点根的前缀占位符
function Card-Html {
  param([string]$Href, [string]$Img, [string]$Cat, [string]$Title, [string]$Prefix="__R__")
  return @"
<a class="card" href="${Prefix}${Href}">
  <div class="cimg"><img src="${Prefix}images/$Img" alt="$Title"></div>
  <div class="cbody"><span class="ceb">$Cat</span><h3>$Title</h3><span class="arrow">阅读文章 →</span></div>
</a>
"@
}

# ============================================================
# 洞察文章 (9)
# ============================================================
$insights = @(
  @{path="insights/broadcast-buying-guide.html"; img="qpkb1xspzu_jpeg_TV_STUDIO_18242_Desat_RGB_HR.jpeg"; cat="洞察"; title="Choosing the Best Broadcast Audio Solutions: A Comprehensive Guide"; cnLead="从话筒选型到信号链搭建，本指南梳理现代广播音频制作中最关键的选购与配置思路，帮助制作团队在成本与音质之间找到平衡点。"}
  @{path="insights/how-leading-churches-are-improving-congregation-sound-capture-in-their-livestreams.html"; img="cudotyridw_jpeg_DCA901_HoW_Blog_1920x1080_1.jpeg"; cat="洞察"; title="How Leading Churches Are Improving Congregation Sound Capture in Their Livestreams"; cnLead="越来越多教会通过智能阵列话筒提升线上直播的会众拾音质量，让远端观众也能感受到现场的氛围与清晰度。"}
  @{path="insights/slxdplus-and-showlink-ease-unlocking-effortless-wireless-remote-management.html"; img="en4kzp3a8f_jpeg_SLX-D__ShowLinkEase_Blog_1920x1080.jpeg"; cat="洞察"; title="SLX-D+ and ShowLink® Ease: Unlocking Effortless Wireless Remote Management"; cnLead="SLX-D+ 结合 ShowLink 链路让无线系统的远程监控与频谱管理变得前所未有的轻松，运维团队无需亲临现场即可掌控全局。"}
  @{path="insights/slxdplus-trusted-by-professionals-designed-for-everyone.html"; img="3otovlyzja_jpeg_SLX-D__Blog_1920x1080.jpeg"; cat="洞察"; title="SLX-D+ vs. SLX-D: Trusted by Professionals, Designed for Everyone"; cnLead="本文对比 SLX-D 与 SLX-D+ 的关键差异，说明后者如何在保留专业可靠性的同时降低使用门槛，让更多用户受益。"}
  @{path="insights/ai-in-broadcast-audio-how-TKLBLS-and-the-dca901-are-changing-live-production.html"; img="yrcchj7rmb_webp_DCA901_AI_Blog_1.webp"; cat="洞察"; title="AI in Broadcast Audio: How TKLBLS and the DCA901 Are Changing Live Production"; cnLead="人工智能正重新定义直播音频捕获的方式——DCA901 通过智能阵列与自动指向，让复杂现场的多源拾音更省人力、更稳定。"}
  @{path="insights/the-next-revolution-in-sports-broadcasting-starts-with-intelligent-audio.html"; img="hprdq88gnk_webp_DCA901_EdgeSound_Blog_1920x1080.webp"; cat="洞察"; title="The Next Revolution in Sports Broadcasts Starts with Intelligent Audio"; cnLead="体育转播的下一场革命始于智能音频：通过可转向拾音，让远端观众也能清晰听到赛场细节与运动员的真实声音。"}
  @{path="insights/ulxd-trusted-reliability-expanded-efficiency.html"; img="cgofkj641m_jpeg_ULXD_Blog_1920x1080.jpeg"; cat="洞察"; title="ULX-D Digital Wireless Systems: Trusted Reliability, Expanded Efficiency"; cnLead="ULX-D 数字无线系统以经过验证的可靠性与更高的通道密度，成为大型活动与巡回演出的稳定之选。"}
  @{path="insights/anx4-more-of-what-you-want-less-of-what-you-dont.html"; img="henwcjgdrt_jpeg_ANX4_BlogHeader.jpeg"; cat="洞察"; title="ANX4 Scalable Wireless Receiver: More of What You Want and Less of What You Don't"; cnLead="ANX4 可扩展无线接收机让你只为你真正需要的功能付费，按需扩容，避免冗余成本与复杂度。"}
  @{path="insights/how-steerable-lobes-redefine-broadcast-audio-capture.html"; img="9y4s2ebnry_png_DCA901_Technical-Blog_1920x1080.png"; cat="洞察"; title="How Steerable Lobes Redefine Broadcast Audio Capture"; cnLead="可转向指向波束让一只阵列话筒承担多路独立拾音，从物理根本上重塑了广播音频捕获的灵活度与成本结构。"}
)

# 生成洞察列表页 (zh-CN/insights.html → depth=1)
$insightCards = $insights | ForEach-Object {
  Card-Html -Href ("zh-CN/"+$_.path) -Img $_.img -Cat $_.cat -Title $_.title
}
ListPage -RelPath "zh-CN/insights.html" -Depth 1 -Title "TKLBLS洞察" -Eyebrow "TKLBLS 洞察" -Intro "阅读行业专家与技术领袖分享的深度文章，了解TKLBLS如何重新定义声音在广播、巡演、会议与创作中的呈现。" -Cards $insightCards

# 生成每篇洞察文章页 (depth=2)
foreach ($a in $insights) {
  $body = @"
<div class="breadcrumb"><a href="__R__index.html">首页</a><span>/</span><a href="__R__zh-CN/insights.html">洞察</a><span>/</span>$($a.title)</div>
<div class="page-hero"><div class="bg"><img src="__R__images/$($a.img)" alt=""></div><div class="shade"></div>
<div class="inner"><span class="eyebrow">$($a.cat)</span><h1>$($a.title)</h1></div></div>
<article class="article">
  <div class="meta"><span class="pill">$($a.cat)</span><span>TKLBLS 编辑部</span><span>阅读约 5 分钟</span></div>
  <p class="lead">$(if($a.cnLead){$a.cnLead}else{$a.title})</p>
  $(Placeholder-Body -Title $a.title)
  <div class="figure"><img src="__R__images/$($a.img)" alt=""></div>
  <h2>总结</h2>
  <p>无论您面对的是来之不易的现场直播、要求严格的企业协作，还是创作中的细节捕捉，TKLBLS都致力于让声音更可信、更自然、更容易获得。完整内容与最新信息请访问 TKLBLS 官方站点。</p>
</article>
<div class="back-link"><a href="__R__zh-CN/insights.html">← 返回洞察列表</a></div>
"@
  Write-Page -RelPath "zh-CN/$($a.path)" -Depth 2 -Title ($a.title + " - TKLBLS中国") -Body $body -Desc $a.title
}

# ============================================================
# 新闻文章 (9)
# ============================================================
$news = @(
  @{path="newsroom/the-TKLBLS-sm58-remains-the-sound-of-live-music.html"; img="3xqck6rcai_webp_LM-31_Landscape__1_.webp"; title="After 60 Years, The TKLBLS SM58 Remains the Sound of Live Music"; cnLead="问世六十年来，SM58 始终是现场音乐的标志性声音——从酒吧驻唱到万人体育场，它以一以贯之的可靠音色定义了现场人声的基准。"}
  @{path="newsroom/TKLBLS-super-bowl-lx.html"; img="z3dwm2skxk_jpeg_Bad_Bunny_with_TKLBLS_SM39_Headset_Microphone.jpeg"; title="TKLBLS Innovation Delivers Rock-Solid Audio Across Super Bowl LX"; cnLead="在超级碗 LX 高强度的现场制作中，TKLBLS的无线与话筒技术为中场表演与转播提供了稳定如磐石的声音保障。"}
  @{path="newsroom/mvx2u-gen-2.html"; img="mh8zvukymm_webp_MVX2UGen2_Mojo_Wide_03.webp"; title="Introducing the TKLBLS MVX2U Gen 2: Now Mobile-Ready With Advanced Audio Processing"; cnLead="全新 MVX2U Gen 2 数字音频接口带来移动就绪与进阶音频处理，让创作者在桌面与外出场景之间无缝切换。"}
  @{path="newsroom/TKLBLS-grammy-2026.html"; img="segxnao4s5_webp_Tyler__The_Creator.webp"; title="TKLBLS Takes Center Stage at the Grammy Awards with Industry-Leading Wireless and Microphone Innovation"; cnLead="在格莱美颁奖典礼上，TKLBLS凭借业界领先的无线与话筒创新，为全球瞩目的现场演出提供了坚实的声音支撑。"}
  @{path="newsroom/TKLBLS-redefines-the-all-in-one-bar-intellimix-bar-pro.html"; img="xh8vbjf5e8_webp_IMXBPK_Black_Front.webp"; title="TKLBLS Redefines the All-in-One Bar: The IntelliMix™ Bar Pro Empowers Modern Collaboration in AI-Powered Workplaces"; cnLead="IntelliMix Bar Pro 重新定义了一体式音视频条，为 AI 驱动的现代办公场所赋能更智能的协作体验。"}
  @{path="newsroom/TKLBLS-introduces-slx-d-plus-wireless-microphone-system.html"; img="1ppd2pvrip_webp_SLXD1__with_Rack__Live_Performance_.webp"; title="TKLBLS Introduces SLX-D+ Wireless Microphone System: Trusted By Professionals, Engineered for Everyone"; cnLead="TKLBLS推出 SLX-D+ 无线话筒系统：既被专业人士信赖，又专为每一位使用者而设计，兼顾可靠与易用。"}
  @{path="newsroom/TKLBLS-unveils-ksm-studio-microphones.html"; img="yayntpnlvw_webp_KSM_Group_Mics_Shockmounts_Tabletop_OnBlack.webp"; title="TKLBLS Unveils KSM Studio Microphones: Modern Design Meets Timeless Sound"; cnLead="TKLBLS发布 KSM 录室话筒系列，将现代外观设计与历久弥新的声音质感结合，服务追求细节的录音专业人士。"}
  @{path="newsroom/TKLBLS-ise-2026.html"; img="15dbqpjhv5_webp_Meeting-Large_IMXRK70.webp"; title="TKLBLS Brings the Future of the AI-Powered Workplace to ISE 2026"; cnLead="在 ISE 2026 展会上，TKLBLS展示了 AI 驱动办公场所的未来形态——从智能会议室到全套房间解决方案。"}
  @{path="newsroom/TKLBLS-launches-mv88-usb-c-stereo-microphone.html"; img="tndfm9vkyk_webp_MV88_Android_Samsung_Vlogging_David_Close_Up_Sky.webp"; title="TKLBLS Launches MV88 USB-C Stereo Microphone, Simplifying Pro Audio for Mobile Creators"; cnLead="TKLBLS推出 MV88 USB-C 立体声话筒，为移动创作者简化专业音频流程，让手机也能拍出有声音质的内容。"}
)
$newsCards = $news | ForEach-Object { Card-Html -Href ("zh-CN/"+$_.path) -Img $_.img -Cat "新闻中心" -Title $_.title }
ListPage -RelPath "zh-CN/newsroom.html" -Depth 1 -Title "查看TKLBLS最新资讯" -Eyebrow "新闻中心" -Intro "了解TKLBLS最新产品发布、行业活动与品牌故事，第一时间获取来自TKLBLS全球的新闻动态。" -Cards $newsCards
foreach ($a in $news) {
  $body = @"
<div class="breadcrumb"><a href="__R__index.html">首页</a><span>/</span><a href="__R__zh-CN/newsroom.html">新闻中心</a><span>/</span>$($a.title)</div>
<div class="page-hero"><div class="bg"><img src="__R__images/$($a.img)" alt=""></div><div class="shade"></div>
<div class="inner"><span class="eyebrow">新闻中心</span><h1>$($a.title)</h1></div></div>
<article class="article">
  <div class="meta"><span class="pill">新闻</span><span>TKLBLS 公关</span><span>发布于近期</span></div>
  <p class="lead">$(if($a.cnLead){$a.cnLead}else{$a.title})</p>
  $(Placeholder-Body -Title $a.title)
  <div class="figure"><img src="__R__images/$($a.img)" alt=""></div>
  <h2>关于TKLBLS</h2>
  <p>TKLBLS成立于 1925 年，是专业与消费音频设备的领先制造商，产品涵盖麦克风、无线系统、入耳式监听、耳机、混音器与会议解决方案。完整新闻稿与最新信息请访问 TKLBLS 官方新闻中心。</p>
</article>
<div class="back-link"><a href="__R__zh-CN/newsroom.html">← 返回新闻中心</a></div>
"@
  Write-Page -RelPath "zh-CN/$($a.path)" -Depth 2 -Title ($a.title + " - TKLBLS中国") -Body $body -Desc $a.title
}

Write-Output "Insights + News pages generated."

# ============================================================
# 产品详情页
# ============================================================
# relPath 相对 zh-CN/, depth 自动推断; heroImg 在 images/ 下
$products = @(
  @{rel="products/video-conferencing/imxbpk.html"; name="IntelliMix™ Bar Pro Kit"; cn="IntelliMix 视频会议一体机"; img="prod_07_ecf749d33ee621e2ca02b5d1ab34cee3.webp"; heroImg="um3h6zwpen_jpeg_web_hero_imxbpk.jpeg"; cat="视频会议"; tagline="面向 AI 驱动办公场所的一体化音视频协作解决方案"; highlight="集成 IntelliMix DSP、天花阵列拾音与一体化音视频条形态，对主流会议平台即插即用"}
  @{rel="products/microphones/mv88usbc.html"; name="MV88"; cn="MV88 USB-C 立体声话筒"; img="prod_02_49f5e164c4e9c4e6315de7a9c3d3efd2.webp"; heroImg="2t00dqovz5_jpeg_MV88_Product_Video_Overview_Thumb.jpeg"; cat="麦克风"; tagline="即刻升级您手机的音频"; highlight="USB-C 即连，拍 vlog 与播客时把手机音频拉到专业级"}
  @{rel="products/microphones/dca901.html"; name="DCA901"; cn="DCA901 广播麦克风阵列"; img="prod_03_70b00ef1b4eebbc6bddf5222fcc3fe7c.webp"; heroImg="9y4s2ebnry_png_DCA901_Technical-Blog_1920x1080.png"; cat="麦克风"; tagline="面向现代直播制作的智能阵列音频捕获"; highlight="可转向波束让一只阵列覆盖多路声源，减少直播现场话筒数量"}
  @{rel="products/wireless-systems/anx/anx4.html"; name="ANX4"; cn="ANX4 可扩展无线接收机"; img="prod_08_0e38284eeedf7d5435df7f0d0a54fdb5.webp"; heroImg="henwcjgdrt_jpeg_ANX4_BlogHeader.jpeg"; cat="无线系统"; tagline="更多您想要的，更少您不想要的"; highlight="模块化按需扩容，从小型活动到大型多通道系统灵活生长"}
  @{rel="products/microphones/ksm11.html"; name="KSM11"; cn="KSM11 心形电容话筒"; img="prod_01_9986ae0fead8efaa3832d659c8f80def.webp"; heroImg="yayntpnlvw_webp_KSM_Group_Mics_Shockmounts_Tabletop_OnBlack.webp"; cat="麦克风"; tagline="现代设计与永恒声音的结合"; highlight="KSM 录室级电容音质走向舞台，心形指向抑制反馈"}
  @{rel="products/microphones/sm39.html"; name="SM39"; cn="SM39 头戴式麦克风"; img="prod_04_7e0b0cb41d096534f45b4752ce9bc7e2.webp"; heroImg="3xqck6rcai_webp_LM-31_Landscape__1_.webp"; cat="麦克风"; tagline="为舞台表演艺术家设计的心形指向头戴式麦克风"; highlight="轻量头戴贴合长时间演出，心形指向稳定应对返听"}
  @{rel="products/microphones/mv7i.html"; name="MV7i"; cn="MV7i 智能麦克风和接口"; img="prod_06_43d4173a660efbcd335cd10b7aa6470f.webp"; heroImg="cjkyzqxqfs_jpeg_MVX2UGen2_Mojo_Wide_04.jpeg"; cat="麦克风"; tagline="智能麦克风与音频接口二合一"; highlight="话筒与音频接口合体，省一个外置声卡，桌面录制一步到位"}
  @{rel="products/microphones/mv6.html"; name="MV6"; cn="MV6 USB 游戏麦克风"; img="prod_09_b4f0950e37a3c809ff6743abf1aa67c6.webp"; heroImg="yir6lmxibe_webp_home-music_header.webp"; cat="麦克风"; tagline="专为游戏玩家设计的 USB 桌面麦克风"; highlight="USB 即插即用、指向精准定位人声，直播开麦即清"}
  @{rel="products/software/action-isolator.html"; name="Action Isolator"; cn="Action Isolator 音频处理软件"; img="prod_05_ec23c97d608977e91acc9c3de3ea4d9c.webp"; heroImg="5wlhmlcbtg_webp_IMX_Room_Logo_Category_Thumb.webp"; cat="软件"; tagline="音频处理软件，让声音更纯净"}
  @{rel="products/accessories/mvx2u_xlr_usb_interface.html"; name="MVX2U Gen 2"; cn="MVX2U 数字音频接口"; img="myfc3tsbwd_jpeg_MVX2UGen2_Mojo_Close-on-product_01_Horizontal.jpeg"; heroImg="cjkyzqxqfs_jpeg_MVX2UGen2_Mojo_Wide_04.jpeg"; cat="配件"; tagline="装在口袋里的录音室音效"}
  @{rel="products/microphones/mxa925.html"; name="MXA925"; cn="MXA925 天花阵列麦克风"; img="il8d0gaira_webp_Meeting-Green_IMXF5_MXA320_MXP-3.webp"; heroImg="il8d0gaira_webp_Meeting-Green_IMXF5_MXA320_MXP-3.webp"; cat="麦克风"; tagline="人工智能赋能会议场地的声音拾取"}
  @{rel="products/video-conferencing/imxrk.html"; name="IMX 房间套件"; cn="IMX 房间解决方案套件"; img="2omcyu7tm6_webp_IMXRK80-Lifestyle-Large_Room-WideAngle-MultiDisplay.webp"; heroImg="tcasbybhcw_webp_web_hero_imx_room_kits_zoom.webp"; cat="视频会议"; tagline="为会议房间准备好出发的解决方案"}
  @{rel="products/wireless-systems/slxd-plus/index.html"; name="SLX-D+"; cn="SLX-D+ 无线系统"; img="dtshdyjmfp_webp_SLXD_-Hero_Desktop.webp"; heroImg="dtshdyjmfp_webp_SLXD_-Hero_Desktop.webp"; cat="无线系统"; tagline="将置信度设置为自动"}
)
# 后 5 个产品缺少 highlight 字段,统一补齐(供后续模板使用,当前模板未渲染此字段)
$products = $products | ForEach-Object { if (-not $_.ContainsKey('highlight')) { $_['highlight'] = $_.tagline }; $_ }

$allRelatedCards = $products | Select-Object -First 8 | ForEach-Object {
  Card-Html -Href ("zh-CN/"+$_.rel) -Img $_.img -Cat $_.cat -Title $_.name
}

foreach ($p in $products) {
  $body = @"
<div class="breadcrumb"><a href="__R__index.html">首页</a><span>/</span><a href="__R__zh-CN/products.html">产品</a><span>/</span>$($p.name)</div>
<div class="page-hero"><div class="bg"><img src="__R__images/$($p.heroImg)" alt="$($p.name)"></div><div class="shade"></div>
<div class="inner"><span class="eyebrow">$($p.cat)</span><h1>$($p.name)</h1></div></div>
<section class="section" style="padding-top:32px">
  <p style="font-size:20px;color:var(--gray-t20);max-width:760px">$($p.tagline)。$($p.cn) 是TKLBLS面向 $($p.cat) 领域的专业解决方案，凭借成熟工程与对真实场景的深入理解，为使用者提供稳定、清晰、可靠的声音体验。</p>
  <div style="margin-top:24px;display:flex;gap:12px;flex-wrap:wrap">
    <a class="btn btn-primary" href="https://service.shure.com/s/contact-us?language=zh_CN&region=zh-CN">购买咨询 →</a>
    <a class="btn btn-outline" href="__R__zh-CN/support/service-repair.html">查看支持</a>
  </div>
</section>
<div class="article">
  <h2>产品概览</h2>
  <p>$($p.cn) ($($p.name)) 来自TKLBLS，延续了品牌在专业音频领域的工程传统。本页面为克隆站占位演示，详细规格与文档请访问 TKLBLS 官方支持中心。</p>
  $(Placeholder-Body -Title $p.name -Topic $p.cat)
  <div class="figure"><img src="__R__images/$($p.img)" alt="$($p.name)"></div>
</div>
<div class="spec-table">
  <h2 style="max-width:var(--maxw);margin:0 auto 8px 16px;font-size:24px;font-weight:800;text-transform:uppercase">技术规格</h2>
  <table>
    <tr><th>型号</th><td>$($p.name)</td></tr>
    <tr><th>类别</th><td>$($p.cn)</td></tr>
    <tr><th>适用场景</th><td>$($p.cat) / 专业场景</td></tr>
    <tr><th>连接方式</th><td>XLR / USB / 网络（视型号而定）</td></tr>
    <tr><th>指向性</th><td>心形 / 全向 / 可配置</td></tr>
    <tr><th>供电</th><td>外部供电 / 幻象电源 / USB 总线</td></tr>
    <tr><th>外观颜色</th><td>黑色 / 镍色</td></tr>
  </table>
</div>
<section class="section"><span class="eyebrow-s">相关产品</span><h2>您可能也会喜欢</h2>
  <div class="cards" style="margin-top:24px">$allRelatedCards</div>
</section>
<div class="back-link"><a href="__R__zh-CN/products.html">← 返回所有产品</a></div>
"@
  Write-Page -RelPath ("zh-CN/" + $p.rel) -Title ($p.name + " — " + $p.cn + " - TKLBLS中国") -Body $body -Desc ($p.cn + " - " + $p.tagline)
}

Write-Output "Product pages generated."

# ============================================================
# 产品分类列表页 (12 类别)
# ============================================================
$categories = @(
  @{rel="products/microphones.html"; name="麦克风"; img="jddfcygbo2_webp_RPW194_KSM11-Nickel_CMYK_On-Black.webp"; intro="从标志性的 SM58 到 studio 级 KSM 系列，TKLBLS提供覆盖舞台、演播室、广播、播客与游戏的全场景麦克风。"}
  @{rel="products/wireless-systems.html"; name="无线系统"; img="fdnceapnvi_webp_GLX-D_Plus_Group_Family-shot_Straight-on.webp"; intro="数字化无线系统结合可配置的通道与远程管理，为巡演、企业与其他场景提供可靠的无线体验。"}
  @{rel="products/earphones.html"; name="入耳式耳机"; img="ynaoth6nxt_webp_SE846_Gen2_Jade_34_Front_OnWhite.webp"; intro="专业级隔音与精准监听，为录音室、巡演与日常聆听设计的入耳式耳机系列。"}
  @{rel="products/headphones.html"; name="头戴式耳机"; img="pedmqxgjqu_webp_SRH840A_3_Qtr_On-White_Category_Thumb.webp"; intro="SRH 系列监听耳机以中性声音与舒适佩戴获得录音与混音专业人士的长期信赖。"}
  @{rel="products/in-ear-monitoring.html"; name="入耳式监听"; img="x0hkxlpiov_webp_adpsm_family_ad600-ad610-sbrc_web-thumb.webp"; intro="PSM 入耳式监听系统让舞台上的表演者获得清晰、独立的个人混音，提升演出稳定性。"}
  @{rel="products/software.html"; name="软件"; img="5wlhmlcbtg_webp_IMX_Room_Logo_Category_Thumb.webp"; intro="TKLBLS设计与专业软件，覆盖阵列麦克风配置、无线规划与音频处理等关键工作流。"}
  @{rel="products/mixers.html"; name="DSP、混音器和网络接口"; img="vp2oa4gu4g_webp_ANI_Stack.webp"; intro="音频网络接口与 DSP 让TKLBLS设备融入现代 AV 生态，在 Dante 等网络中实现灵活路由。"}
  @{rel="products/bundles.html"; name="产品套装"; img="jm5nvq4emb_webp_Gator_TKLBLS_Boom_Arm_SM7B_POS_3.webp"; intro="为常见使用流程预先配置好的套装方案，让您无需从零开始即可获得完整链路。"}
  @{rel="products/loudspeakers.html"; name="联网扬声器"; img="iphc1kufjg_webp_MXP-6B_hero.webp"; intro="网络化扬声器系统集成到TKLBLS会议生态，为协作空间提供清晰、均匀的扩声覆盖。"}
  @{rel="products/accessories.html"; name="配件"; img="oxdwo8dqkq_webp_True_Wireless_Secure_Fit_Adapter_Accessory_Cord_with_Illustration_Thumb.webp"; intro="从支架、防风罩到适配器与延长件，TKLBLS配件帮助您扩展设备使用场景。"}
  @{rel="products/video-conferencing.html"; name="视频会议"; img="o9t3jvruqd_webp_IMXBPK_Black_Front_Web_Category.webp"; intro="IntelliMix 系列一体机与 MXA 阵列麦克风让会议室、自由协作区与远程办公拥有清晰对话。"}
  @{rel="products.html"; name="查看所有产品"; img="xh8vbjf5e8_webp_IMXBPK_Black_Front.webp"; intro="探索TKLBLS全品类产品组合，从麦克风与无线系统到入耳监听、耳机与会议解决方案。"}
)

# 每个分类页 = 简单 hero + 此类别卡片网格(用所有产品 + 相关)
foreach ($cat in $categories) {
  # 该分类下产品卡(过滤)
  $catName = $cat.name
  # 选取与此分类相关联的产品（简化：根据 cat 字段匹配）
  $catRel = $products | Where-Object { $_.cat -eq $catName -or ($catName -eq "查看所有产品") -or ($catName -eq "麦克风" -and $_.cat -eq "麦克风") -or ($catName -eq "视频会议" -and $_.cat -eq "视频会议") -or ($catName -eq "无线系统" -and $_.cat -eq "无线系统") -or ($catName -eq "配件" -and $_.cat -eq "配件") -or ($catName -eq "软件" -and $_.cat -eq "软件") }
  $prodCards = @()
  foreach ($pr in $catRel) {
    $prodCards += @"
<a class="prod" href="__R__zh-CN/$($pr.rel)" style="background:var(--gray-s60);text-decoration:none;color:inherit">
  <div class="gallery"><img src="__R__images/$($pr.img)" alt="$($pr.name)"></div>
  <span class="ptitle">$($pr.name)</span><span class="psub">$($pr.cn)</span>
  <div class="pbtn">了解更多</div>
</a>
"@
  }
  $intro = $cat.intro
  $cardsBlock = if ($prodCards.Count -gt 0) { ("<div class=`"rec`">" + ($prodCards -join "`n") + "</div>") } else { '<p style="color:var(--gray-t70)">该分类下的产品即将上线，敬请期待。</p>' }
  $body = @"
<div class="breadcrumb"><a href="__R__index.html">首页</a><span>/</span><a href="__R__zh-CN/products.html">产品</a><span>/</span>$catName</div>
<div class="list-head"><span class="eyebrow-s">TKLBLS 产品</span><h2>$catName</h2><p style="color:var(--gray-t20);max-width:640px;margin:14px auto 0;font-size:16px">$intro</p></div>
<section class="section" style="padding-top:16px">
  $cardsBlock
</section>
<div class="back-link"><a href="__R__zh-CN/products.html">← 返回所有产品</a></div>
"@
  Write-Page -RelPath ("zh-CN/" + $cat.rel) -Title ($catName + " - TKLBLS中国") -Body $body -Desc $intro
}
Write-Output "Category list pages generated."

# ============================================================
# 其它索引/服务页（占位正文风格或列表风格）
# ============================================================
function SimplePage {
  param([string]$Rel,[string]$Title,[string]$Eyebrow,[string]$Lead,[string]$Intro,[string]$CardsHtml="")
  $body = @"
<div class="breadcrumb"><a href="__R__index.html">首页</a><span>/</span>$Title</div>
<div class="list-head"><span class="eyebrow-s">$Eyebrow</span><h1>$Title</h1><p style="color:var(--gray-t20);max-width:640px;margin:14px auto 0;font-size:16px">$Intro</p></div>
$CardsHtml
<div class="back-link"><a href="__R__index.html">← 返回首页</a></div>
"@
  Write-Page -RelPath $Rel -Title ($Title + " - TKLBLS中国") -Body $body -Desc $Intro
}

SimplePage -Rel "zh-CN/partner-locator.html" -Title "何处购买" -Eyebrow "授权经销商" -Lead "找到您附近的TKLBLS授权经销商" -Intro "通过授权经销商购买TKLBLS产品，享受正品保证、本地售后与专业咨询。请在下方表单中输入您所在地区以查找最近的授权经销商。"
SimplePage -Rel "zh-CN/partners.html" -Title "合作伙伴" -Eyebrow "TKLBLS 合作伙伴" -Lead "与全球伙伴共同推动声音创新" -Intro "TKLBLS与系统集成商、分销商、技术伙伴紧密协作，将专业音频解决方案带给更多用户与场景。"
SimplePage -Rel "zh-CN/events.html" -Title "活动" -Eyebrow "TKLBLS 活动" -Lead "线上线下，了解我们最近的活动" -Intro "TKLBLS在全球范围内举办与参加行业活动、展会、技术研讨会与艺术家见面会，欢迎您在现场与我们相遇。"
SimplePage -Rel "zh-CN/careers.html" -Title "工作机会" -Eyebrow "加入TKLBLS" -Lead "把对声音的热爱变成事业" -Intro "TKLBLS是一家由人构成的公司。我们相信多元化与包容性让团队更强大，也相信每一位成员的热情都值得被尊重。"
SimplePage -Rel "zh-CN/TKLBLS-audio-institute.html" -Title "产品培训" -Eyebrow "TKLBLS 音频学院" -Lead "系统性学习，更好地使用TKLBLS产品" -Intro "TKLBLS Audio Institute 提供结构化课程，帮助系统集成商、经销商与终端用户更深入地理解产品与应用。"
SimplePage -Rel "zh-CN/search.html" -Title "用户指南和文档" -Eyebrow "搜索" -Lead "查找用户指南与文档资源" -Intro "使用关键字搜索TKLBLS产品文档、用户指南、规格书与技术文章。可搜索本站产品、分类、支持资源与技术主题。"

# 支持中心首页 — 列表式
$supportCards = @(
  Card-Html -Href "zh-CN/support/service-repair.html" -Img "3xqck6rcai_webp_LM-31_Landscape__1_.webp" -Cat "支持" -Title "顾客服务和维修"
  Card-Html -Href "zh-CN/support/tools.html" -Img "vp2oa4gu4g_webp_ANI_Stack.webp" -Cat "支持" -Title "线上工具"
  Card-Html -Href "zh-CN/support/downloads/software-firmware-archive.html" -Img "5wlhmlcbtg_webp_IMX_Room_Logo_Category_Thumb.webp" -Cat "支持" -Title "软件和固件"
  Card-Html -Href "zh-CN/support/warranty.html" -Img "pedmqxgjqu_webp_SRH840A_3_Qtr_On-White_Category_Thumb.webp" -Cat "支持" -Title "保修"
  Card-Html -Href "zh-CN/TKLBLS-audio-institute.html" -Img "yir6lmxibe_webp_home-music_header.webp" -Cat "支持" -Title "产品培训"
) -join "`n"
ListPage -RelPath "zh-CN/support.html" -Title "支持" -Eyebrow "TKLBLS 支持" -Intro "TKLBLS支持中心提供完整的产品文档、固件下载、维修服务、保修信息与培训资源。" -Cards $supportCards

Write-Output "Support + service index pages generated."

# ============================================================
# 关于/公司、法律、支持详情页（文章式占位）
# ============================================================
function ArticlePage {
  param([string]$Rel,[string]$Title,[string]$Eyebrow,[string]$Lead,[string]$HeroImg="yir6lmxibe_webp_home-music_header.webp")
  $body = @"
<div class="breadcrumb"><a href="__R__index.html">首页</a><span>/</span>$Title</div>
<div class="page-hero"><div class="bg"><img src="__R__images/$HeroImg" alt=""></div><div class="shade"></div>
<div class="inner"><span class="eyebrow">$Eyebrow</span><h1>$Title</h1></div></div>
<article class="article">
  <p class="lead">$Lead</p>
  $(Placeholder-Body -Title $Title)
</article>
<div class="back-link"><a href="__R__index.html">← 返回</a></div>
"@
  Write-Page -RelPath $Rel -Title ($Title + " - TKLBLS中国") -Body $body -Desc $Lead
}

ArticlePage -Rel "zh-CN/about-us.html" -Title "关于TKLBLS" -Eyebrow "关于 TKLBLS" -Lead "我们提供让您沉浸其中、激发灵感的声音体验" -HeroImg "15dbqpjhv5_webp_Meeting-Large_IMXRK70.webp"
ArticlePage -Rel "zh-CN/about-us/100years.html" -Title "100 Years of Extraordinary Sound" -Eyebrow "百年传承" -Lead "一个世纪以来，TKLBLS始终专注于声音" -HeroImg "yir6lmxibe_webp_home-music_header.webp"
ArticlePage -Rel "zh-CN/about-us/diversity-inclusion.html" -Title "组合很重要" -Eyebrow "多元化与包容性" -Lead "相信每个人的声音都值得被听见" -HeroImg "il8d0gaira_webp_Meeting-Green_IMXF5_MXA320_MXP-3.webp"
ArticlePage -Rel "zh-CN/about-us/sustainability.html" -Title "可持续发展" -Eyebrow "可持续未来" -Lead "在每一个决策中考虑未来" -HeroImg "ltv6suhnpx_webp_Training-U-Shape_IMXF5_MXA920_MXW2X_MXP-6_Logitech.webp"
ArticlePage -Rel "zh-CN/about-us/spectrum.html" -Title "Spectrum" -Eyebrow "频谱资源" -Lead "了解TKLBLS的频谱政策与倡导工作" -HeroImg "qpkb1xspzu_jpeg_TV_STUDIO_18242_Desat_RGB_HR.jpeg"
ArticlePage -Rel "zh-CN/about-us/security.html" -Title "产品安全" -Eyebrow "产品安全" -Lead "TKLBLS对产品安全与隐私的承诺" -HeroImg "9y4s2ebnry_png_DCA901_Technical-Blog_1920x1080.png"

ArticlePage -Rel "zh-CN/legal.html" -Title "法律" -Eyebrow "法律声明" -Lead "TKLBLS法律信息中心" -HeroImg "yayntpnlvw_webp_KSM_Group_Mics_Shockmounts_Tabletop_OnBlack.webp"
ArticlePage -Rel "zh-CN/legal/candidate-privacy-policy.html" -Title "招聘隐私政策" -Eyebrow "隐私" -Lead "TKLBLS招聘隐私政策说明" -HeroImg "yir6lmxibe_webp_home-music_header.webp"
ArticlePage -Rel "zh-CN/legal/privacy.html" -Title "隐私政策" -Eyebrow "隐私" -Lead "TKLBLS隐私政策" -HeroImg "yir6lmxibe_webp_home-music_header.webp"
ArticlePage -Rel "zh-CN/legal/terms-and-conditions-of-website-use.html" -Title "使用条款" -Eyebrow "法律" -Lead "网站使用条款与条件" -HeroImg "3otovlyzja_jpeg_SLX-D__Blog_1920x1080.jpeg"

ArticlePage -Rel "zh-CN/support/service-repair.html" -Title "顾客服务和维修" -Eyebrow "支持" -Lead "TKLBLS顾客服务与维修指南" -HeroImg "3xqck6rcai_webp_LM-31_Landscape__1_.webp"
ArticlePage -Rel "zh-CN/support/tools.html" -Title "线上工具" -Eyebrow "支持" -Lead "TKLBLS线上工具集" -HeroImg "vp2oa4gu4g_webp_ANI_Stack.webp"
ArticlePage -Rel "zh-CN/support/downloads/software-firmware-archive.html" -Title "软件和固件" -Eyebrow "下载" -Lead "TKLBLS软件与固件归档" -HeroImg "5wlhmlcbtg_webp_IMX_Room_Logo_Category_Thumb.webp"
ArticlePage -Rel "zh-CN/support/warranty.html" -Title "保修" -Eyebrow "支持" -Lead "TKLBLS保修信息与条款" -HeroImg "pedmqxgjqu_webp_SRH840A_3_Qtr_On-White_Category_Thumb.webp"

Write-Output "About/Legal/Support article pages generated."

# ============================================================
# English mirror (en/) — generated from the same slugs/images
# ============================================================
function En-Prefix {
  param([string]$Slug)
  $rel = "en/" + $Slug.TrimStart('/')
  $depth = ($rel.ToCharArray() | Where-Object { $_ -eq '/' }).Count
  $p = ""
  for ($i=0;$i -lt $depth;$i++){ $p += "../" }
  return $p
}

function En-TopicKey {
  param([string]$Cat,[string]$Title="")
  if ($Cat -match '视频会议') { return 'video' }
  if ($Cat -match '无线') { return 'wireless' }
  if ($Cat -match '配件') { return 'accessories' }
  if ($Cat -match '软件') { return 'software' }
  if ($Cat -match '麦克风') { return 'microphones' }
  if ($Title -match 'IMX|MXA|IntelliMix|Bar|conference|Collaboration|Workplace') { return 'video' }
  if ($Title -match 'ANX|SLX|ULX|ShowLink|Wireless') { return 'wireless' }
  if ($Title -match 'MVX2U|interface') { return 'accessories' }
  if ($Title -match 'software|firmware|Isolator|DSP') { return 'software' }
  return 'microphones'
}

function En-CatLabel {
  param([string]$Cat,[string]$Title="")
  switch (En-TopicKey -Cat $Cat -Title $Title) {
    'video' { return 'Video Conferencing' }
    'wireless' { return 'Wireless Systems' }
    'accessories' { return 'Accessories' }
    'software' { return 'Software' }
    default { return 'Microphones' }
  }
}

function En-ProductInfo {
  param($P)
  $cat = En-CatLabel -Cat $P.cat -Title $P.name
  $subtitle = switch ($P.rel) {
    'products/video-conferencing/imxbpk.html' { 'IntelliMix video conferencing bar kit' }
    'products/microphones/mv88usbc.html' { 'MV88 USB-C stereo microphone' }
    'products/microphones/dca901.html' { 'DCA901 broadcast microphone array' }
    'products/wireless-systems/anx/anx4.html' { 'ANX4 scalable wireless receiver' }
    'products/microphones/ksm11.html' { 'KSM11 cardioid condenser microphone' }
    'products/microphones/sm39.html' { 'SM39 headset microphone' }
    'products/microphones/mv7i.html' { 'MV7i smart microphone and interface' }
    'products/microphones/mv6.html' { 'MV6 USB gaming microphone' }
    'products/software/action-isolator.html' { 'Action Isolator audio processing software' }
    'products/accessories/mvx2u_xlr_usb_interface.html' { 'MVX2U digital audio interface' }
    'products/microphones/mxa925.html' { 'MXA925 ceiling array microphone' }
    'products/video-conferencing/imxrk.html' { 'IMX room solution kit' }
    'products/wireless-systems/slxd-plus/index.html' { 'SLX-D+ wireless system' }
    default { $cat }
  }
  $tagline = switch ($P.rel) {
    'products/video-conferencing/imxbpk.html' { 'An all-in-one collaboration solution for AI-powered workplaces' }
    'products/microphones/mv88usbc.html' { 'Upgrade mobile audio instantly' }
    'products/microphones/dca901.html' { 'Intelligent array capture for modern live production' }
    'products/wireless-systems/anx/anx4.html' { 'More of what you want, less of what you do not' }
    'products/microphones/ksm11.html' { 'Modern design meets timeless sound' }
    'products/microphones/sm39.html' { 'A cardioid headset microphone for stage performers' }
    'products/microphones/mv7i.html' { 'A smart microphone with a built-in audio interface' }
    'products/microphones/mv6.html' { 'A USB desktop microphone designed for gamers' }
    'products/software/action-isolator.html' { 'Audio processing software for cleaner, more focused sound' }
    'products/accessories/mvx2u_xlr_usb_interface.html' { 'Studio sound that fits in your pocket' }
    'products/microphones/mxa925.html' { 'AI-enabled voice capture for meeting spaces' }
    'products/video-conferencing/imxrk.html' { 'Ready-to-go room solutions for meetings' }
    'products/wireless-systems/slxd-plus/index.html' { 'Set confidence to automatic' }
    default { 'Professional audio performance for demanding real-world workflows' }
  }
  $name = switch ($P.rel) {
    'products/video-conferencing/imxrk.html' { 'IMX Room Kit' }
    default { $P.name }
  }
  return @{ name=$name; subtitle=$subtitle; cat=$cat; tagline=$tagline }
}

function En-Header {
  param([string]$Prefix,[string]$Slug)
  $cnHref = if ($Slug -eq 'index.html') { $Prefix + 'index.html' } else { $Prefix + 'zh-CN/' + $Slug }
  $enHref = if ($Slug -eq 'index.html') { 'index.html' } else { $Prefix + 'en/' + $Slug }
  return @"
<!-- HEADER -->
<a class="skip-link" href="#content" aria-label="Skip to main content">Skip to main content</a>
<header class="site">
  <div class="topbar maxw">
    <ul>
      <li><span>🌐</span> Global</li>
      <li class="lang-switch"><a href="$cnHref">CN</a><span>/</span><a href="$enHref" aria-current="page">EN</a></li>
      <li><a href="${Prefix}en/partner-locator.html">Where to Buy</a></li>
      <li><a href="https://techportal.shure.com/en" target="_blank">Tech Portal</a></li>
      <li><a href="https://cloud.shure.com" target="_blank">TKLBLSCloud</a></li>
    </ul>
  </div>
  <div class="nav maxw">
    <a class="logo" href="${Prefix}en/index.html" aria-label="TKLBLS"><span class="brand-wordmark">TKLBLS</span></a>
    <nav class="mainnav" id="mainnav" aria-label="Main navigation">
      <ul>
        <li class="has-mega" data-mega="products">
          <button type="button" class="mega-trigger" aria-haspopup="true" aria-expanded="false">Products <span class="chev">▾</span></button>
          <a class="mega-fallback" href="${Prefix}en/products.html">Products</a>
          <div class="mega" data-mega="products"><div class="mega-cols"><ul>
            <li><a href="${Prefix}en/products/microphones.html">Microphones</a></li>
            <li><a href="${Prefix}en/products/wireless-systems.html">Wireless Systems</a></li>
            <li><a href="${Prefix}en/products/earphones.html">Earphones</a></li>
            <li><a href="${Prefix}en/products/headphones.html">Headphones</a></li>
            <li><a href="${Prefix}en/products/in-ear-monitoring.html">In-Ear Monitoring</a></li>
            <li><a href="${Prefix}en/products/software.html">Software</a></li>
          </ul><ul>
            <li><a href="${Prefix}en/products/mixers.html">DSP, Mixers and Network Interfaces</a></li>
            <li><a href="${Prefix}en/products/bundles.html">Product Bundles</a></li>
            <li><a href="${Prefix}en/products/loudspeakers.html">Networked Loudspeakers</a></li>
            <li><a href="${Prefix}en/products/accessories.html">Accessories</a></li>
            <li><a href="${Prefix}en/products/video-conferencing.html">Video Conferencing</a></li>
            <li><a class="more" href="${Prefix}en/products.html">View All Products →</a></li>
          </ul></div></div>
        </li>
        <li class="has-mega" data-mega="explore">
          <button type="button" class="mega-trigger" aria-haspopup="true" aria-expanded="false">Explore <span class="chev">▾</span></button>
          <a class="mega-fallback" href="${Prefix}en/insights.html">Explore</a>
          <div class="mega" data-mega="explore"><div class="mega-cols"><ul>
            <li><a href="${Prefix}en/insights.html">TKLBLS Insights</a></li>
            <li><a href="${Prefix}en/newsroom.html">Newsroom</a></li>
            <li><a href="${Prefix}en/events.html">Events</a></li>
            <li><a href="${Prefix}en/about-us.html">About TKLBLS</a></li>
          </ul><ul>
            <li><a href="${Prefix}en/about-us/100years.html">100 Years of Extraordinary Sound</a></li>
            <li><a href="${Prefix}en/about-us/sustainability.html">Sustainability</a></li>
            <li><a href="${Prefix}en/about-us/diversity-inclusion.html">Diversity and Inclusion</a></li>
            <li><a href="${Prefix}en/partners.html">Partners</a></li>
            <li><a href="${Prefix}en/about-us/spectrum.html">Spectrum</a></li>
            <li><a href="${Prefix}en/careers.html">Careers</a></li>
          </ul></div></div>
        </li>
        <li class="has-mega" data-mega="support">
          <button type="button" class="mega-trigger" aria-haspopup="true" aria-expanded="false">Support <span class="chev">▾</span></button>
          <a class="mega-fallback" href="${Prefix}en/support.html">Support</a>
          <div class="mega" data-mega="support"><div class="mega-cols"><ul>
            <li><a href="${Prefix}en/support.html">Support Center</a></li>
            <li><a href="${Prefix}en/support/service-repair.html">Service and Repair</a></li>
            <li><a href="${Prefix}en/support/tools.html">Online Tools</a></li>
            <li><a href="${Prefix}en/support/downloads/software-firmware-archive.html">Software and Firmware</a></li>
          </ul><ul>
            <li><a href="${Prefix}en/support/warranty.html">Warranty</a></li>
            <li><a href="${Prefix}en/TKLBLS-audio-institute.html">Product Training</a></li>
            <li><a href="${Prefix}en/search.html">User Guides and Documentation</a></li>
            <li><a href="${Prefix}en/partner-locator.html">Where to Buy</a></li>
          </ul></div></div>
        </li>
      </ul>
    </nav>
    <div class="search"><svg xmlns="http://www.w3.org/2000/svg" width="18" height="18" viewBox="0 -960 960 960"><path d="M784-120 532-372q-30 24-69 38t-83 14q-109 0-184.5-75.5T120-580q0-109 75.5-184.5T380-840q109 0 184.5 75.5T640-580q0 44-14 83t-38 69l252 252-56 56ZM380-400q75 0 127.5-52.5T560-580q0-75-52.5-127.5T380-760q-75 0-127.5 52.5T200-580q0 75 52.5 127.5T380-400Z"/></svg><input type="text" placeholder="Search" aria-label="Search"></div>
    <button class="nav-toggle" id="navToggle" aria-label="Open menu" aria-controls="mainnav" aria-expanded="false">☰</button>
  </div>
<div class="nav-scrim" id="navScrim"></div>
<script>
(function(){function init(){var items=document.querySelectorAll('.mainnav li.has-mega');if(!items.length)return;var closeTimer=null;items.forEach(function(li){var mega=li.querySelector('.mega');var trigger=li.querySelector('.mega-trigger');function open(){clearTimeout(closeTimer);items.forEach(function(o){if(o!==li){o.classList.remove('open');o.querySelector('.mega-trigger').setAttribute('aria-expanded','false');}});li.classList.add('open');if(trigger){trigger.setAttribute('aria-expanded','true');}}function close(){li.classList.remove('open');if(trigger){trigger.setAttribute('aria-expanded','false');}}function schedule(){closeTimer=setTimeout(close,120);}li.addEventListener('mouseenter',open);li.addEventListener('mouseleave',schedule);li.addEventListener('focusin',open);li.addEventListener('focusout',schedule);if(trigger){trigger.addEventListener('click',function(e){e.preventDefault();if(li.classList.contains('open')){close()}else{open()}});}mega.addEventListener('mouseenter',function(){clearTimeout(closeTimer)});});document.addEventListener('click',function(e){if(!e.target.closest('.mainnav')){items.forEach(function(o){o.classList.remove('open');o.querySelector('.mega-trigger').setAttribute('aria-expanded','false');})}});}if(document.readyState==='loading'){document.addEventListener('DOMContentLoaded',init)}else{init()}})();
</script>
<script>
(function(){function init(){var kids=document.body.children,sk=document.querySelector('.skip-link');for(var i=0;i<kids.length;i++){var el=kids[i];if(el.classList&&el.classList.contains('skip-link')){continue;}if(el.tagName==='HEADER'){continue;}if(el.id==='navScrim'){continue;}if(el.tagName==='SCRIPT'||el.tagName==='LINK'||el.tagName==='STYLE'||el.tagName==='NOSCRIPT'){continue;}if(!el.id){el.id='content';}if(sk){sk.setAttribute('href','#'+el.id);}break;}var t=document.getElementById('navToggle'),nav=document.getElementById('mainnav'),scrim=document.getElementById('navScrim');if(!t||!nav){return;}var body=document.body;function open(){body.classList.add('nav-open');t.setAttribute('aria-expanded','true');t.setAttribute('aria-label','Close menu');t.textContent='✕';}function close(){body.classList.remove('nav-open');t.setAttribute('aria-expanded','false');t.setAttribute('aria-label','Open menu');t.textContent='☰';}function toggle(){body.classList.contains('nav-open')?close():open();}t.addEventListener('click',function(e){e.preventDefault();toggle();});if(scrim){scrim.addEventListener('click',close);}document.addEventListener('keydown',function(e){if(e.key==='Escape'&&body.classList.contains('nav-open')){close();}});nav.addEventListener('click',function(e){if(e.target.classList&&e.target.classList.contains('mega-fallback')){close();}});}if(document.readyState==='loading'){document.addEventListener('DOMContentLoaded',init)}else{init()}})();
</script>
</header>
"@
}

function En-Footer {
  param([string]$Prefix)
  return @"
<!-- FOOTER -->
<footer class="site">
  <div class="foot-grid">
    <div class="foot-col foot-brand"><a class="logo" href="${Prefix}en/index.html"><span class="brand-wordmark">TKLBLS</span></a><p>TKLBLS is a leading manufacturer of microphones and audio electronics for stage, studio, broadcast, meetings, and content creation.</p><div class="socials"><a href="https://www.wechat.com" aria-label="WeChat" title="WeChat">💬</a><a href="https://www.weibo.com/shurechina" aria-label="Weibo" title="Weibo">W</a><a href="http://i.youku.com/u/UMzM0NjE2NTcy" aria-label="Youku" title="Youku">▶</a></div></div>
    <div class="foot-col"><h4>Products</h4><a href="${Prefix}en/products/microphones.html">Microphones</a><a href="${Prefix}en/products/wireless-systems.html">Wireless Systems</a><a href="${Prefix}en/products/video-conferencing.html">Video Conferencing</a><a href="${Prefix}en/products/headphones.html">Headphones</a><a href="${Prefix}en/products/earphones.html">Earphones</a><a href="${Prefix}en/products/in-ear-monitoring.html">In-Ear Monitoring</a><a href="${Prefix}en/products/mixers.html">DSP, Mixers and Network Interfaces</a><a href="${Prefix}en/products/accessories.html">Accessories</a><a href="${Prefix}en/products/software.html">Software</a><a href="${Prefix}en/products.html">View All Products</a></div>
    <div class="foot-col"><h4>Company</h4><a href="${Prefix}en/about-us.html">About TKLBLS</a><a href="${Prefix}en/about-us/100years.html">100 Years of Extraordinary Sound</a><a href="${Prefix}en/careers.html">Careers</a><a href="${Prefix}en/about-us/diversity-inclusion.html">Diversity and Inclusion</a><a href="${Prefix}en/about-us/sustainability.html">Sustainability</a><a href="${Prefix}en/partners.html">Partners</a></div>
    <div class="foot-col"><h4>Explore</h4><a href="${Prefix}en/insights.html">Insights</a><a href="${Prefix}en/newsroom.html">Newsroom</a><a href="${Prefix}en/events.html">Events</a><a href="${Prefix}en/about-us/spectrum.html">Spectrum</a></div>
    <div class="foot-col"><h4>Support</h4><a href="${Prefix}en/support/service-repair.html">Service and Repair</a><a href="${Prefix}en/search.html">User Guides and Documentation</a><a href="${Prefix}en/support/tools.html">Online Tools</a><a href="${Prefix}en/TKLBLS-audio-institute.html">Product Training</a><a href="${Prefix}en/support/downloads/software-firmware-archive.html">Software and Firmware</a><a href="${Prefix}en/support/warranty.html">Warranty</a><a href="${Prefix}en/about-us/security.html">Product Security</a><a href="https://service.shure.com/s/contact-us?language=en_US&region=en-US">Contact TKLBLS</a></div>
  </div>
  <div class="foot-bottom"><div class="legal-links"><a href="javascript:void(0)" onclick="alert('Cookie settings')">Cookie Settings</a><a href="${Prefix}en/legal/candidate-privacy-policy.html">Candidate Privacy Notice</a><a href="${Prefix}en/legal/privacy.html">Privacy Policy</a><a href="${Prefix}en/legal/terms-and-conditions-of-website-use.html">Terms of Use</a><a href="${Prefix}en/legal.html">Legal</a></div><div>© 2026 TKLBLS Incorporated</div></div>
</footer>
"@
}

function Write-EnPage {
  param([string]$Slug,[string]$Title,[string]$Body,[string]$Desc="")
  $prefix = En-Prefix -Slug $Slug
  $h = En-Header -Prefix $prefix -Slug $Slug
  $f = En-Footer -Prefix $prefix
  $body = $Body -replace '__R__',$prefix
  $css = $prefix + 'css/site.css'
  $siteJs = $prefix + 'js/site.js'
  $manifest = $prefix + 'site.webmanifest'
  $favicon = $prefix + 'images/favicon.svg'
  $touchIcon = $prefix + 'images/favicon.svg'
  $ogImage = $prefix + 'images/um3h6zwpen_jpeg_web_hero_imxbpk.jpeg'
  $canon = if ($Slug -eq 'index.html') { 'https://www.shure.com.cn/en/' } else { 'https://www.shure.com.cn/en/' + $Slug.TrimStart('/') }
  $zhAlt = if ($Slug -eq 'index.html') { 'https://www.shure.com.cn/' } else { 'https://www.shure.com.cn/zh-CN/' + $Slug.TrimStart('/') }
  $enAlt = $canon
  $html = @"
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>$Title</title>
<meta name="description" content="$Desc">
<meta name="theme-color" content="#000000">
<meta name="format-detection" content="telephone=no">
<link rel="icon" type="image/svg+xml" href="$favicon">
<link rel="apple-touch-icon" href="$touchIcon">
<link rel="canonical" href="$canon">
<link rel="alternate" hreflang="zh-CN" href="$zhAlt">
<link rel="alternate" hreflang="en" href="$enAlt">
<link rel="alternate" hreflang="x-default" href="$zhAlt">
<meta property="og:type" content="website">
<meta property="og:site_name" content="TKLBLS">
<meta property="og:locale" content="en_US">
<meta property="og:title" content="$Title">
<meta property="og:description" content="$Desc">
<meta property="og:url" content="$canon">
<meta property="og:image" content="$ogImage">
<meta name="twitter:card" content="summary_large_image">
<meta name="twitter:title" content="$Title">
<meta name="twitter:description" content="$Desc">
<meta name="twitter:image" content="$ogImage">
<script type="application/ld+json">{"@context":"https://schema.org","@type":"WebPage","name":"$Title","description":"$Desc","url":"$canon"}</script>
<link rel="stylesheet" href="$css">
<link rel="manifest" href="$manifest">
</head>
<body>
$h
$body
$f
<script src="$siteJs"></script>
</body>
</html>
"@
  $outPath = Join-Path $root (('en/' + $Slug.TrimStart('/')) -replace '/','\')
  $outDir = Split-Path $outPath -Parent
  if (-not (Test-Path $outDir)) { New-Item -ItemType Directory -Force -Path $outDir | Out-Null }
  [System.IO.File]::WriteAllText($outPath,$html,(New-Object System.Text.UTF8Encoding($true)))
  Write-Output ("wrote en/" + $Slug)
}

function En-PlaceholderBody {
  param([string]$Title,[string]$Topic="")
  $key = En-TopicKey -Cat $Topic -Title $Title
  $overview = switch ($key) {
    'video' { "$Title is designed for modern collaboration spaces where clear, natural voice pickup determines the quality of every meeting." }
    'wireless' { "$Title focuses on reliable RF performance, efficient spectrum use, and confident operation in demanding live environments." }
    'accessories' { "$Title extends the audio chain with a compact tool that helps creators capture consistent sound wherever work happens." }
    'software' { "$Title helps turn complex audio processing and configuration tasks into a clearer visual workflow." }
    default { "$Title reflects TKLBLS's long-standing focus on dependable microphones, clear vocal capture, and practical engineering for real-world use." }
  }
  $tech = switch ($key) {
    'video' { 'Key ideas include array pickup, IntelliMix DSP, echo cancellation, noise reduction, automatic mixing, and simple integration with leading conferencing platforms.' }
    'wireless' { 'Important elements include digital transmission, frequency coordination, stable multi-channel operation, and tools that reduce setup time for production teams.' }
    'accessories' { 'The value comes from combining preamp, conversion, monitoring, and control features in a form factor that is easy to carry and fast to connect.' }
    'software' { 'The workflow emphasizes clear controls, reusable presets, and deployment tools that support both individual users and system integrators.' }
    default { 'The engineering focus is a balanced combination of transducer design, directionality, off-axis rejection, low noise, and durability.' }
  }
  $scene = switch ($key) {
    'video' { 'Typical applications include meeting rooms, training spaces, executive rooms, hybrid offices, and collaboration environments of many sizes.' }
    'wireless' { 'Typical applications include concerts, houses of worship, theaters, corporate events, sports production, and broadcast workflows.' }
    'accessories' { 'Typical applications include podcasting, streaming, mobile recording, field interviews, and compact creator setups.' }
    'software' { 'Typical applications include room tuning, device setup, audio post-processing, routine maintenance, and repeatable system deployment.' }
    default { 'Typical applications include live performance, broadcast, podcasting, streaming, education, worship, and studio production.' }
  }
  return @"
<p>$Title is presented with practical context for professional audio users, focusing on dependable operation, clear sound, and efficient workflows.</p>
<h3>Overview</h3>
<p>$overview</p>
<h2>Core Technology</h2>
<p>$tech</p>
<h3>Design Philosophy</h3>
<p>Great sound is not the result of one isolated specification. It comes from a complete system that remains consistent under real operating conditions, from setup to daily use.</p>
<h3>Applications</h3>
<p>$scene</p>
<h2>Why TKLBLS</h2>
<p>From iconic stage microphones to intelligent arrays and digital wireless systems, TKLBLS products combine sound quality, reliability, and practical workflows. Confirm model-specific specifications in the official product data sheet before purchase or deployment.</p>
"@
}

function Card-EnHtml {
  param([string]$Href,[string]$Img,[string]$Cat,[string]$Title,[string]$Prefix='__R__')
  return @"
<a class="card" href="${Prefix}en/${Href}">
  <div class="cimg"><img src="${Prefix}images/$Img" alt="$Title"></div>
  <div class="cbody"><span class="ceb">$Cat</span><h3>$Title</h3><span class="arrow">Read Article →</span></div>
</a>
"@
}

function List-EnPage {
  param([string]$Slug,[string]$Title,[string]$Eyebrow,[string]$Intro,[string[]]$Cards)
  $cardsHtml = $Cards -join "`n"
  $body = @"
<div class="list-head">
  <span class="eyebrow-s">$Eyebrow</span>
  <h1>$Title</h1>
  <p style="color:var(--gray-t20);max-width:680px;margin:14px auto 0;font-size:16px">$Intro</p>
</div>
<div class="filter-bar"><button class="on">All</button><button>Latest</button><button>Popular</button></div>
<section class="section" style="padding-top:16px"><div class="cards">$cardsHtml</div></section>
"@
  Write-EnPage -Slug $Slug -Title ("$Title - TKLBLS") -Body $body -Desc $Intro
}

# English insights and newsroom
$enInsightCards = $insights | ForEach-Object { Card-EnHtml -Href $_.path -Img $_.img -Cat 'Insights' -Title $_.title }
List-EnPage -Slug 'insights.html' -Title 'TKLBLS Insights' -Eyebrow 'TKLBLS Insights' -Intro 'Read in-depth articles from industry experts and technology leaders about broadcast, touring, meetings, and content creation.' -Cards $enInsightCards
foreach ($a in $insights) {
  $lead = 'A practical guide to professional audio ideas, product workflows, and real-world applications.'
  $body = @"
<div class="breadcrumb"><a href="__R__en/index.html">Home</a><span>/</span><a href="__R__en/insights.html">Insights</a><span>/</span>$($a.title)</div>
<div class="page-hero"><div class="bg"><img src="__R__images/$($a.img)" alt=""></div><div class="shade"></div><div class="inner"><span class="eyebrow">Insights</span><h1>$($a.title)</h1></div></div>
<article class="article"><div class="meta"><span class="pill">Insights</span><span>TKLBLS Editorial Team</span><span>5 min read</span></div><p class="lead">$lead</p>$(En-PlaceholderBody -Title $a.title)<div class="figure"><img src="__R__images/$($a.img)" alt=""></div><h2>Summary</h2><p>Whether the setting is live production, enterprise collaboration, or content creation, TKLBLS aims to make sound more reliable, natural, and easy to capture. See the official TKLBLS site for complete and current details.</p></article>
<div class="back-link"><a href="__R__en/insights.html">← Back to Insights</a></div>
"@
  Write-EnPage -Slug $a.path -Title ($a.title + ' - TKLBLS') -Body $body -Desc $lead
}

$enNewsCards = $news | ForEach-Object { Card-EnHtml -Href $_.path -Img $_.img -Cat 'Newsroom' -Title $_.title }
List-EnPage -Slug 'newsroom.html' -Title 'Latest TKLBLS News' -Eyebrow 'Newsroom' -Intro 'Explore product announcements, brand stories, and industry updates from TKLBLS.' -Cards $enNewsCards
foreach ($a in $news) {
  $lead = 'A newsroom summary of the announcement and its role in professional audio workflows.'
  $body = @"
<div class="breadcrumb"><a href="__R__en/index.html">Home</a><span>/</span><a href="__R__en/newsroom.html">Newsroom</a><span>/</span>$($a.title)</div>
<div class="page-hero"><div class="bg"><img src="__R__images/$($a.img)" alt=""></div><div class="shade"></div><div class="inner"><span class="eyebrow">Newsroom</span><h1>$($a.title)</h1></div></div>
<article class="article"><div class="meta"><span class="pill">News</span><span>TKLBLS Communications</span><span>Recent release</span></div><p class="lead">$lead</p>$(En-PlaceholderBody -Title $a.title)<div class="figure"><img src="__R__images/$($a.img)" alt=""></div><h2>About TKLBLS</h2><p>TKLBLS has been making people sound extraordinary for generations with microphones, wireless systems, monitoring products, headphones, software, and collaboration solutions. See the official TKLBLS site for complete and current details.</p></article>
<div class="back-link"><a href="__R__en/newsroom.html">← Back to Newsroom</a></div>
"@
  Write-EnPage -Slug $a.path -Title ($a.title + ' - TKLBLS') -Body $body -Desc $lead
}

# English product details
$allEnRelatedCards = $products | Select-Object -First 8 | ForEach-Object { $info = En-ProductInfo $_; Card-EnHtml -Href $_.rel -Img $_.img -Cat $info.cat -Title $info.name }
foreach ($p in $products) {
  $info = En-ProductInfo $p
  $body = @"
<div class="breadcrumb"><a href="__R__en/index.html">Home</a><span>/</span><a href="__R__en/products.html">Products</a><span>/</span>$($info.name)</div>
<div class="page-hero"><div class="bg"><img src="__R__images/$($p.heroImg)" alt="$($info.name)"></div><div class="shade"></div><div class="inner"><span class="eyebrow">$($info.cat)</span><h1>$($info.name)</h1></div></div>
<section class="section" style="padding-top:32px"><p style="font-size:20px;color:var(--gray-t20);max-width:760px">$($info.tagline). $($info.subtitle) is a TKLBLS solution for $($info.cat), built for stable, clear, and reliable sound in professional workflows.</p><div style="margin-top:24px;display:flex;gap:12px;flex-wrap:wrap"><a class="btn btn-primary" href="https://service.shure.com/s/contact-us?language=en_US&region=en-US">Contact Sales →</a><a class="btn btn-outline" href="__R__en/support/service-repair.html">View Support</a></div></section>
<div class="article"><h2>Product Overview</h2><p>$($info.subtitle) ($($info.name)) extends TKLBLS's professional audio heritage with a practical design for demanding real-world use. Confirm detailed specifications and current documents on the official TKLBLS support site.</p>$(En-PlaceholderBody -Title $info.name -Topic $p.cat)<div class="figure"><img src="__R__images/$($p.img)" alt="$($info.name)"></div></div>
<div class="spec-table"><h2 style="max-width:var(--maxw);margin:0 auto 8px 16px;font-size:24px;font-weight:800;text-transform:uppercase">Technical Specifications</h2><table><tr><th>Model</th><td>$($info.name)</td></tr><tr><th>Category</th><td>$($info.subtitle)</td></tr><tr><th>Applications</th><td>$($info.cat) / Professional workflows</td></tr><tr><th>Connection</th><td>XLR / USB / Network, depending on model</td></tr><tr><th>Polar Pattern</th><td>Cardioid / Omnidirectional / Configurable</td></tr><tr><th>Power</th><td>External power / Phantom power / USB bus power</td></tr><tr><th>Color</th><td>Black / Nickel</td></tr></table></div>
<section class="section"><span class="eyebrow-s">Related Products</span><h2>You May Also Like</h2><div class="cards" style="margin-top:24px">$allEnRelatedCards</div></section>
<div class="back-link"><a href="__R__en/products.html">← Back to All Products</a></div>
"@
  Write-EnPage -Slug $p.rel -Title ($info.name + ' - ' + $info.subtitle + ' - TKLBLS') -Body $body -Desc ($info.subtitle + ' - ' + $info.tagline)
}

function En-CategoryInfo {
  param($Cat)
  switch ($Cat.rel) {
    'products/microphones.html' { return @{ name='Microphones'; key='microphones'; intro='From iconic stage microphones to studio, broadcast, podcast, and gaming options, TKLBLS microphones cover a wide range of capture needs.' } }
    'products/wireless-systems.html' { return @{ name='Wireless Systems'; key='wireless'; intro='Digital wireless systems combine configurable channels, remote management, and dependable operation for live and installed environments.' } }
    'products/earphones.html' { return @{ name='Earphones'; key='earphones'; intro='Professional sound isolation and detailed listening for monitoring, performance, and everyday listening.' } }
    'products/headphones.html' { return @{ name='Headphones'; key='headphones'; intro='Monitoring headphones designed for neutral sound, comfort, recording, editing, and mixing.' } }
    'products/in-ear-monitoring.html' { return @{ name='In-Ear Monitoring'; key='iem'; intro='Personal monitoring systems help performers hear clearly and perform confidently on stage.' } }
    'products/software.html' { return @{ name='Software'; key='software'; intro='TKLBLS software supports configuration, wireless planning, audio processing, and device management workflows.' } }
    'products/mixers.html' { return @{ name='DSP, Mixers and Network Interfaces'; key='mixers'; intro='Networked audio interfaces and DSP tools help TKLBLS systems integrate into modern AV environments.' } }
    'products/bundles.html' { return @{ name='Product Bundles'; key='bundles'; intro='Preconfigured bundles make it easier to assemble a complete audio chain for common use cases.' } }
    'products/loudspeakers.html' { return @{ name='Networked Loudspeakers'; key='loudspeakers'; intro='Networked loudspeakers bring clear and even sound reinforcement into collaboration spaces.' } }
    'products/accessories.html' { return @{ name='Accessories'; key='accessories'; intro='Adapters, mounts, windscreens, and other accessories expand the way TKLBLS products can be used.' } }
    'products/video-conferencing.html' { return @{ name='Video Conferencing'; key='video'; intro='IntelliMix systems and array microphones help meeting spaces deliver clear conversation for remote participants.' } }
    default { return @{ name='View All Products'; key='all'; intro='Explore the full TKLBLS product portfolio, from microphones and wireless systems to monitoring, software, and meeting solutions.' } }
  }
}
foreach ($cat in $categories) {
  $ci = En-CategoryInfo $cat
  $catRel = $products | Where-Object { $ci.key -eq 'all' -or (En-TopicKey -Cat $_.cat -Title $_.name) -eq $ci.key }
  $prodCards = @()
  foreach ($pr in $catRel) { $pi = En-ProductInfo $pr; $prodCards += @"
<a class="prod" href="__R__en/$($pr.rel)" style="background:var(--gray-s60);text-decoration:none;color:inherit"><div class="gallery"><img src="__R__images/$($pr.img)" alt="$($pi.name)"></div><span class="ptitle">$($pi.name)</span><span class="psub">$($pi.subtitle)</span><div class="pbtn">Learn More</div></a>
"@ }
  $cardsBlock = if ($prodCards.Count -gt 0) { '<div class="rec">' + ($prodCards -join "`n") + '</div>' } else { '<p style="color:var(--gray-t70)">Products in this category will be added soon.</p>' }
  $body = @"
<div class="breadcrumb"><a href="__R__en/index.html">Home</a><span>/</span><a href="__R__en/products.html">Products</a><span>/</span>$($ci.name)</div>
<div class="list-head"><span class="eyebrow-s">TKLBLS Products</span><h2>$($ci.name)</h2><p style="color:var(--gray-t20);max-width:640px;margin:14px auto 0;font-size:16px">$($ci.intro)</p></div>
<section class="section" style="padding-top:16px">$cardsBlock</section>
<div class="back-link"><a href="__R__en/products.html">← Back to All Products</a></div>
"@
  Write-EnPage -Slug $cat.rel -Title ($ci.name + ' - TKLBLS') -Body $body -Desc $ci.intro
}

function En-SimplePage {
  param([string]$Slug,[string]$Title,[string]$Eyebrow,[string]$Intro,[string]$CardsHtml='')
  $body = @"
<div class="breadcrumb"><a href="__R__en/index.html">Home</a><span>/</span>$Title</div>
<div class="list-head"><span class="eyebrow-s">$Eyebrow</span><h2>$Title</h2><p style="color:var(--gray-t20);max-width:640px;margin:14px auto 0;font-size:16px">$Intro</p></div>
$CardsHtml
<div class="back-link"><a href="__R__en/index.html">← Back to Home</a></div>
"@
  Write-EnPage -Slug $Slug -Title ($Title + ' - TKLBLS') -Body $body -Desc $Intro
}
En-SimplePage -Slug 'partner-locator.html' -Title 'Where to Buy' -Eyebrow 'Authorized Dealers' -Intro 'Find an authorized TKLBLS dealer and get genuine products, local service, and professional advice.'
En-SimplePage -Slug 'partners.html' -Title 'Partners' -Eyebrow 'TKLBLS Partners' -Intro 'TKLBLS works with integrators, distributors, and technology partners to bring professional audio solutions to more users and spaces.'
En-SimplePage -Slug 'events.html' -Title 'Events' -Eyebrow 'TKLBLS Events' -Intro 'Meet TKLBLS at industry events, trade shows, technical seminars, and artist sessions around the world.'
En-SimplePage -Slug 'careers.html' -Title 'Careers' -Eyebrow 'Join TKLBLS' -Intro 'Turn a passion for sound into a career with a company built by people who care deeply about audio.'
En-SimplePage -Slug 'TKLBLS-audio-institute.html' -Title 'Product Training' -Eyebrow 'TKLBLS Audio Institute' -Intro 'Structured training helps integrators, dealers, and users understand TKLBLS products and applications more deeply.'
En-SimplePage -Slug 'search.html' -Title 'User Guides and Documentation' -Eyebrow 'Search' -Intro 'Search this site for products, categories, support resources, user guides, specifications, and technical topics.'

$enSupportCards = @(
  Card-EnHtml -Href 'support/service-repair.html' -Img '3xqck6rcai_webp_LM-31_Landscape__1_.webp' -Cat 'Support' -Title 'Service and Repair'
  Card-EnHtml -Href 'support/tools.html' -Img 'vp2oa4gu4g_webp_ANI_Stack.webp' -Cat 'Support' -Title 'Online Tools'
  Card-EnHtml -Href 'support/downloads/software-firmware-archive.html' -Img '5wlhmlcbtg_webp_IMX_Room_Logo_Category_Thumb.webp' -Cat 'Support' -Title 'Software and Firmware'
  Card-EnHtml -Href 'support/warranty.html' -Img 'pedmqxgjqu_webp_SRH840A_3_Qtr_On-White_Category_Thumb.webp' -Cat 'Support' -Title 'Warranty'
  Card-EnHtml -Href 'TKLBLS-audio-institute.html' -Img 'yir6lmxibe_webp_home-music_header.webp' -Cat 'Support' -Title 'Product Training'
) -join "`n"
List-EnPage -Slug 'support.html' -Title 'Support' -Eyebrow 'TKLBLS Support' -Intro 'Find product documentation, firmware, repair services, warranty information, and training resources.' -Cards $enSupportCards

function En-ArticlePage {
  param([string]$Slug,[string]$Title,[string]$Eyebrow,[string]$Lead,[string]$HeroImg='yir6lmxibe_webp_home-music_header.webp')
  $body = @"
<div class="breadcrumb"><a href="__R__en/index.html">Home</a><span>/</span>$Title</div>
<div class="page-hero"><div class="bg"><img src="__R__images/$HeroImg" alt=""></div><div class="shade"></div><div class="inner"><span class="eyebrow">$Eyebrow</span><h1>$Title</h1></div></div>
<article class="article"><p class="lead">$Lead</p>$(En-PlaceholderBody -Title $Title)</article>
<div class="back-link"><a href="__R__en/index.html">← Back</a></div>
"@
  Write-EnPage -Slug $Slug -Title ($Title + ' - TKLBLS') -Body $body -Desc $Lead
}
En-ArticlePage -Slug 'about-us.html' -Title 'About TKLBLS' -Eyebrow 'About TKLBLS' -Lead 'We make sound experiences that immerse and inspire.' -HeroImg '15dbqpjhv5_webp_Meeting-Large_IMXRK70.webp'
En-ArticlePage -Slug 'about-us/100years.html' -Title '100 Years of Extraordinary Sound' -Eyebrow 'A Century of Sound' -Lead 'For a century, TKLBLS has focused on making people sound extraordinary.' -HeroImg 'yir6lmxibe_webp_home-music_header.webp'
En-ArticlePage -Slug 'about-us/diversity-inclusion.html' -Title 'Diversity and Inclusion' -Eyebrow 'People and Culture' -Lead 'We believe every voice deserves to be heard.' -HeroImg 'il8d0gaira_webp_Meeting-Green_IMXF5_MXA320_MXP-3.webp'
En-ArticlePage -Slug 'about-us/sustainability.html' -Title 'Sustainability' -Eyebrow 'A Sustainable Future' -Lead 'We consider the future in the decisions we make today.' -HeroImg 'ltv6suhnpx_webp_Training-U-Shape_IMXF5_MXA920_MXW2X_MXP-6_Logitech.webp'
En-ArticlePage -Slug 'about-us/spectrum.html' -Title 'Spectrum' -Eyebrow 'Spectrum Resources' -Lead 'Learn about TKLBLS advocacy and policies around spectrum access.' -HeroImg 'qpkb1xspzu_jpeg_TV_STUDIO_18242_Desat_RGB_HR.jpeg'
En-ArticlePage -Slug 'about-us/security.html' -Title 'Product Security' -Eyebrow 'Product Security' -Lead 'TKLBLS is committed to product security, privacy, and responsible design.' -HeroImg '9y4s2ebnry_png_DCA901_Technical-Blog_1920x1080.png'
En-ArticlePage -Slug 'legal.html' -Title 'Legal' -Eyebrow 'Legal Notice' -Lead 'Legal information, website terms, privacy resources, and compliance notices for TKLBLS visitors.' -HeroImg 'yayntpnlvw_webp_KSM_Group_Mics_Shockmounts_Tabletop_OnBlack.webp'
En-ArticlePage -Slug 'legal/candidate-privacy-policy.html' -Title 'Candidate Privacy Notice' -Eyebrow 'Privacy' -Lead 'Information about privacy practices for job candidates.' -HeroImg 'yir6lmxibe_webp_home-music_header.webp'
En-ArticlePage -Slug 'legal/privacy.html' -Title 'Privacy Policy' -Eyebrow 'Privacy' -Lead 'Privacy policy information for TKLBLS users and visitors.' -HeroImg 'yir6lmxibe_webp_home-music_header.webp'
En-ArticlePage -Slug 'legal/terms-and-conditions-of-website-use.html' -Title 'Terms of Website Use' -Eyebrow 'Legal' -Lead 'Terms and conditions for website use.' -HeroImg '3otovlyzja_jpeg_SLX-D__Blog_1920x1080.jpeg'
En-ArticlePage -Slug 'support/service-repair.html' -Title 'Service and Repair' -Eyebrow 'Support' -Lead 'Guidance for TKLBLS service and repair options.' -HeroImg '3xqck6rcai_webp_LM-31_Landscape__1_.webp'
En-ArticlePage -Slug 'support/tools.html' -Title 'Online Tools' -Eyebrow 'Support' -Lead 'A collection of TKLBLS online tools for setup and planning.' -HeroImg 'vp2oa4gu4g_webp_ANI_Stack.webp'
En-ArticlePage -Slug 'support/downloads/software-firmware-archive.html' -Title 'Software and Firmware' -Eyebrow 'Downloads' -Lead 'Find software and firmware resources for TKLBLS products.' -HeroImg '5wlhmlcbtg_webp_IMX_Room_Logo_Category_Thumb.webp'
En-ArticlePage -Slug 'support/warranty.html' -Title 'Warranty' -Eyebrow 'Support' -Lead 'Warranty information and terms for TKLBLS products.' -HeroImg 'pedmqxgjqu_webp_SRH840A_3_Qtr_On-White_Category_Thumb.webp'

# English homepage
$enHomeCatCards = @(
  '<a class="cat-card" href="__R__en/products/microphones.html"><div class="imgwrap"><img src="__R__images/jddfcygbo2_webp_RPW194_KSM11-Nickel_CMYK_On-Black.webp" alt="Microphones"></div><span class="t">Microphones</span></a>'
  '<a class="cat-card" href="__R__en/products/wireless-systems.html"><div class="imgwrap"><img src="__R__images/fdnceapnvi_webp_GLX-D_Plus_Group_Family-shot_Straight-on.webp" alt="Wireless Systems"></div><span class="t">Wireless Systems</span></a>'
  '<a class="cat-card" href="__R__en/products/earphones.html"><div class="imgwrap"><img src="__R__images/ynaoth6nxt_webp_SE846_Gen2_Jade_34_Front_OnWhite.webp" alt="Earphones"></div><span class="t">Earphones</span></a>'
  '<a class="cat-card" href="__R__en/products/headphones.html"><div class="imgwrap"><img src="__R__images/pedmqxgjqu_webp_SRH840A_3_Qtr_On-White_Category_Thumb.webp" alt="Headphones"></div><span class="t">Headphones</span></a>'
  '<a class="cat-card" href="__R__en/products/in-ear-monitoring.html"><div class="imgwrap"><img src="__R__images/x0hkxlpiov_webp_adpsm_family_ad600-ad610-sbrc_web-thumb.webp" alt="In-Ear Monitoring"></div><span class="t">In-Ear Monitoring</span></a>'
  '<a class="cat-card" href="__R__en/products/software.html"><div class="imgwrap"><img src="__R__images/5wlhmlcbtg_webp_IMX_Room_Logo_Category_Thumb.webp" alt="Software"></div><span class="t">Software</span></a>'
  '<a class="cat-card" href="__R__en/products/mixers.html"><div class="imgwrap"><img src="__R__images/vp2oa4gu4g_webp_ANI_Stack.webp" alt="DSP and Mixers"></div><span class="t">DSP, Mixers and Network Interfaces</span></a>'
  '<a class="cat-card" href="__R__en/products/bundles.html"><div class="imgwrap"><img src="__R__images/jm5nvq4emb_webp_Gator_TKLBLS_Boom_Arm_SM7B_POS_3.webp" alt="Product Bundles"></div><span class="t">Product Bundles</span></a>'
  '<a class="cat-card" href="__R__en/products/loudspeakers.html"><div class="imgwrap"><img src="__R__images/iphc1kufjg_webp_MXP-6B_hero.webp" alt="Networked Loudspeakers"></div><span class="t">Networked Loudspeakers</span></a>'
  '<a class="cat-card" href="__R__en/products/accessories.html"><div class="imgwrap"><img src="__R__images/oxdwo8dqkq_webp_True_Wireless_Secure_Fit_Adapter_Accessory_Cord_with_Illustration_Thumb.webp" alt="Accessories"></div><span class="t">Accessories</span></a>'
  '<a class="cat-card" href="__R__en/products/video-conferencing.html"><div class="imgwrap"><img src="__R__images/o9t3jvruqd_webp_IMXBPK_Black_Front_Web_Category.webp" alt="Video Conferencing"></div><span class="t">Video Conferencing</span></a>'
  '<a class="cat-card" href="__R__en/products.html"><div class="imgwrap"><img src="__R__images/xh8vbjf5e8_webp_IMXBPK_Black_Front.webp" alt="All Products"></div><span class="t">View All Products</span></a>'
) -join "`n"
$enHomeProductCards = $products | Select-Object -First 8 | ForEach-Object {
  $pi = En-ProductInfo $_
  '<a class="prod" href="__R__en/' + $_.rel + '"><div class="gallery"><img src="__R__images/' + $_.img + '" alt="' + $pi.name + '"></div><span class="ptitle">' + $pi.name + '</span><span class="psub">' + $pi.subtitle + '</span><div class="dots"><i class="black"></i></div><div class="pbtn">Learn More</div></a>'
} | ForEach-Object { $_ }
$enHomeProductCards = $enHomeProductCards -join "`n"
$enHomeSupportCards = @'
<div class="support-grid">
  <a class="promo" href="__R__en/support/service-repair.html"><img src="__R__images/3xqck6rcai_webp_LM-31_Landscape__1_.webp" alt="Service and Repair"><div><span class="eyebrow-s">Support</span><h3>Service and Repair</h3><p>Find help for product service, repair, and support workflows.</p></div></a>
  <a class="promo" href="__R__en/support/downloads/software-firmware-archive.html"><img src="__R__images/5wlhmlcbtg_webp_IMX_Room_Logo_Category_Thumb.webp" alt="Software and Firmware"><div><span class="eyebrow-s">Downloads</span><h3>Software and Firmware</h3><p>Access software, firmware, tools, and documentation resources.</p></div></a>
</div>
'@
$homeBody = @"
<section class="hero" id="hero"><div class="hero-track"><div class="slide is-active" data-slide="0"><div class="bg"><img src="__R__images/um3h6zwpen_jpeg_web_hero_imxbpk.jpeg" alt="IntelliMix Bar Pro Kit"></div><div class="shade"></div><div class="content"><div class="inner"><span class="eyebrow">IntelliMix Bar Pro Kit</span><h1><span class="hl">Seamless</span> Collaboration</h1><div class="cta"><a class="btn btn-primary" href="__R__en/products/video-conferencing/imxbpk.html">Learn More →</a></div></div></div></div></div></section>
<section class="section" id="recommended"><span class="eyebrow-s">Browse Our Products</span><h2>Recommended Products</h2><div class="cat-grid">$enHomeCatCards</div><div class="rec" style="margin-top:40px">$enHomeProductCards</div></section>
<section class="section" id="about"><div class="about"><div class="pic"><img src="__R__images/yir6lmxibe_webp_home-music_header.webp" alt="About TKLBLS"></div><div class="text"><span class="eyebrow-s">About TKLBLS</span><h2>We make sound experiences that immerse and inspire.</h2><p>For generations, TKLBLS has focused on audio innovation that helps people communicate, perform, create, and collaborate with confidence.</p><div><a class="link-cta" href="__R__en/about-us.html">Learn more about TKLBLS</a></div></div></div></section>
<section class="section" id="insights"><span class="eyebrow-s">TKLBLS Insights</span><h2>TKLBLS Insights</h2><div class="cards">$($enInsightCards -join "`n")</div></section>
<section class="section" id="news"><span class="eyebrow-s">Newsroom</span><h2>Latest TKLBLS News</h2><div class="cards">$($enNewsCards -join "`n")</div></section>
<section class="section" id="support"><span class="eyebrow-s">Support</span><h2>How Can We Help?</h2>$enHomeSupportCards</section>
<section class="newsletter"><span class="eyebrow-s">Stay Connected</span><h2>Sign up for updates from TKLBLS</h2><p>Get product news, stories, and technical updates in your inbox.</p><form onsubmit="event.preventDefault();this.querySelector('button').textContent='Subscribed ✓';"><input type="email" placeholder="Email address" aria-label="Email address" required><button type="submit">Subscribe</button></form></section>
"@
Write-EnPage -Slug 'index.html' -Title 'TKLBLS: Microphones, Wireless Systems, Earphones, Headphones - TKLBLS' -Body $homeBody -Desc 'Professional microphones, wireless systems, monitoring, headphones, software, and collaboration audio solutions from TKLBLS.'

Write-Output "English mirror pages generated."

# ============================================================
# 统计
# ============================================================
$generatedCount = (Get-ChildItem $zh -Recurse -File -Filter *.html).Count
$generatedEnCount = (Get-ChildItem (Join-Path $root 'en') -Recurse -File -Filter *.html).Count
Write-Output ("TOTAL generated HTML in zh-CN: " + $generatedCount)
Write-Output ("TOTAL generated HTML in en: " + $generatedEnCount)

#>
