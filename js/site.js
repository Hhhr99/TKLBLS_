(function () {
  'use strict';

  var isEnglish = document.documentElement.lang.toLowerCase().indexOf('en') === 0;
  var root = (function () {
    var script = document.currentScript;
    return script && script.src ? script.src.replace(/js\/site\.js(?:\?.*)?$/, '') : '../../';
  }());

  var pages = [
    ['products/microphones.html', '麦克风 Microphones', '舞台、录音室、广播、播客和游戏麦克风'],
    ['products/wireless-systems.html', '无线系统 Wireless Systems', '专业数字无线麦克风和接收机'],
    ['products/video-conferencing.html', '视频会议 Video Conferencing', '会议室麦克风、DSP 与协作解决方案'],
    ['products/headphones.html', '头戴式耳机 Headphones', '录音、监听和日常聆听'],
    ['products/earphones.html', '入耳式耳机 Earphones', '隔音耳机与高保真聆听'],
    ['products/microphones/mv88usbc.html', 'MV88 USB-C', '便携式立体声麦克风 stereo microphone'],
    ['products/microphones/dca901.html', 'DCA901', '广播麦克风阵列 broadcast microphone array'],
    ['products/microphones/ksm11.html', 'KSM11', '心形指向电容麦克风 condenser microphone'],
    ['products/microphones/sm39.html', 'SM39', '舞台头戴式麦克风 headset microphone'],
    ['products/microphones/mv7i.html', 'MV7i', '智能麦克风与音频接口 smart microphone and interface'],
    ['products/microphones/mv6.html', 'MV6', 'USB 游戏麦克风 gaming microphone'],
    ['products/microphones/mxa925.html', 'MXA925', '天花阵列麦克风 ceiling array microphone'],
    ['products/wireless-systems/anx/anx4.html', 'ANX4', '可扩展无线接收机 scalable wireless receiver'],
    ['products/video-conferencing/imxbpk.html', 'IntelliMix Bar Pro Kit', '一体化视频会议条形音视频套件'],
    ['products/video-conferencing/imxrk.html', 'IMX Room Kit', '会议室协作解决方案'],
    ['products/accessories/mvx2u_xlr_usb_interface.html', 'MVX2U', 'XLR to USB 数字音频接口'],
    ['products/software/action-isolator.html', 'Action Isolator', '音频处理软件 audio processing software'],
    ['support.html', '支持 Support', '维修、保修、软件、固件和技术文档'],
    ['support/downloads/software-firmware-archive.html', '软件和固件 Software and Firmware', '下载与版本资源'],
    ['about-us.html', '关于TKLBLS About TKLBLS', '品牌、历史、创新与企业责任']
  ];

  function localeUrl(slug) {
    return root + (isEnglish ? 'en/' : 'zh-CN/') + slug;
  }

  function setupHeaderSearch() {
    document.querySelectorAll('.search input').forEach(function (input) {
      input.addEventListener('keydown', function (event) {
        if (event.key !== 'Enter') return;
        var value = input.value.trim();
        if (value) window.location.href = localeUrl('search.html') + '?q=' + encodeURIComponent(value);
      });
    });
  }

  function setupMegaMenuGeometry() {
    var header = document.querySelector('header.site');
    if (!header) return;
    function update() {
      document.documentElement.style.setProperty('--desktop-header-bottom', Math.max(0, Math.round(header.getBoundingClientRect().bottom)) + 'px');
    }
    update();
    window.addEventListener('resize', update, {passive:true});
    document.querySelectorAll('.mainnav .mega-trigger').forEach(function (trigger) {
      trigger.addEventListener('pointerenter', update);
      trigger.addEventListener('focus', update);
    });
  }

  function setupSearchPage() {
    if (!/\/(?:en|zh-CN)\/search\.html$/.test(location.pathname)) return;
    var heading = document.querySelector('.list-head');
    if (!heading) return;
    var panel = document.createElement('section');
    panel.className = 'tool-panel';
    panel.innerHTML = '<form class="site-search-form" role="search">' +
      '<label for="siteSearch">' + (isEnglish ? 'Search products and support' : '搜索产品与支持资源') + '</label>' +
      '<div><input id="siteSearch" type="search" autocomplete="off" placeholder="' + (isEnglish ? 'Try MV7i, wireless, firmware…' : '输入 MV7i、无线、固件…') + '">' +
      '<button class="btn btn-primary" type="submit">' + (isEnglish ? 'Search' : '搜索') + '</button></div></form>' +
      '<p id="resultCount" class="result-count" aria-live="polite"></p><div id="searchResults" class="search-results"></div>';
    heading.insertAdjacentElement('afterend', panel);
    var input = panel.querySelector('input');
    var form = panel.querySelector('form');
    var results = panel.querySelector('#searchResults');
    var count = panel.querySelector('#resultCount');
    var searchPages = pages;
    function escapeHtml(value) { return String(value).replace(/[&<>"']/g, function (char) { return {'&':'&amp;','<':'&lt;','>':'&gt;','"':'&quot;',"'":'&#39;'}[char]; }); }
    function highlight(value, terms) {
      if (!terms.length) return escapeHtml(value);
      var expression = new RegExp('(' + terms.map(function (term) { return term.replace(/[.*+?^${}()|[\]\\]/g, '\\$&'); }).join('|') + ')', 'ig');
      return String(value).split(expression).map(function (part, index) { return index % 2 ? '<mark>' + escapeHtml(part) + '</mark>' : escapeHtml(part); }).join('');
    }
    function render(query) {
      var terms = query.toLowerCase().split(/\s+/).filter(Boolean);
      var matched = !terms.length ? searchPages.slice(0, 12) : searchPages.filter(function (page) {
        var haystack = page.join(' ').toLowerCase();
        return terms.every(function (term) { return haystack.indexOf(term) !== -1; });
      });
      count.textContent = isEnglish ? matched.length + ' results' : '找到 ' + matched.length + ' 条结果';
      results.innerHTML = matched.map(function (page) {
        return '<a class="search-result" href="' + localeUrl(page[0]) + '"><strong>' + highlight(page[1], terms) + '</strong><span>' + highlight(page[2], terms) + '</span></a>';
      }).join('') || '<div class="no-results">' + (isEnglish ? 'No matching page. Try a product model or category.' : '未找到匹配页面，请尝试产品型号或分类。') + '</div>';
    }
    form.addEventListener('submit', function (event) { event.preventDefault(); render(input.value.trim()); });
    var initial = new URLSearchParams(location.search).get('q') || '';
    input.value = initial;
    render(initial);
    fetch(root + 'search-index.json').then(function (response) {
      if (!response.ok) throw new Error('Search index unavailable');
      return response.json();
    }).then(function (index) {
      var selected = index[isEnglish ? 'en' : 'zh'];
      if (Array.isArray(selected) && selected.length) searchPages = selected;
      render(input.value.trim());
    }).catch(function () { /* The compact built-in index remains available offline. */ });
  }

  function setupDealerPage() {
    if (!/\/(?:en|zh-CN)\/partner-locator\.html$/.test(location.pathname)) return;
    var heading = document.querySelector('.list-head');
    if (!heading) return;
    var section = document.createElement('section');
    section.className = 'tool-panel dealer-panel';
    section.innerHTML = '<div class="dealer-grid">' +
      '<article><h2>' + (isEnglish ? 'Find an authorized partner' : '查找授权经销商') + '</h2><p>' + (isEnglish ? 'Use TKLBLS’s official locator for current authorized partner information.' : '通过TKLBLS官方渠道查询最新的授权经销商信息。') + '</p><a class="btn btn-primary" href="https://www.shure.com.cn/zh-CN/partner-locator">' + (isEnglish ? 'Open Official Locator' : '打开官方查询') + ' ↗</a></article>' +
      '<article><h2>' + (isEnglish ? 'Talk to TKLBLS' : '联系TKLBLS') + '</h2><p>' + (isEnglish ? 'Get product selection, system design, service, and purchasing guidance.' : '获取产品选型、系统设计、服务与采购建议。') + '</p><a class="btn btn-outline" href="https://service.shure.com/s/contact-us?language=' + (isEnglish ? 'en_US&region=en-US' : 'zh_CN&region=zh-CN') + '">' + (isEnglish ? 'Contact TKLBLS' : '联系我们') + ' ↗</a></article></div>';
    heading.insertAdjacentElement('afterend', section);
  }

  var productData = {
    'mv7i': {cn:'MV7i 智能麦克风和音频接口',en:'MV7i Smart Microphone & Interface',featuresCn:['一支麦克风、双通道音频，直接发送到平板电脑或智能手机','将两个音频通道录制到电脑','内置 DSP 减少后期编辑'],featuresEn:['One microphone, two audio channels, direct to a computer or mobile device','Record two audio channels through one streamlined setup','Built-in DSP reduces editing time'],specs:[['通道 / Channels','2'],['连接 / Connection','USB-C; combo XLR / 6.3 mm input'],['应用 / Applications','Podcasting, streaming, music and content creation']]},
    'mv88usbc': {cn:'MV88 USB-C 立体声麦克风',en:'MV88 USB-C Stereo Microphone',featuresCn:['USB-C 直连手机与平板','可调立体声宽度','适合视频、采访与现场音乐'],featuresEn:['Direct USB-C connection for phones and tablets','Adjustable stereo width','Designed for video, interviews and live music'],specs:[['连接 / Connection','USB-C'],['类型 / Type','Digital stereo condenser microphone'],['控制 / Control','TKLBLS MOTIV apps']]},
    'dca901': {cn:'DCA901 广播麦克风阵列',en:'DCA901 Broadcast Microphone Array',featuresCn:['可转向拾音波束','面向体育与现场广播','减少场地内多支话筒的部署复杂度'],featuresEn:['Steerable pickup lobes','Designed for sports and live broadcast','Reduces the complexity of deploying many microphones'],specs:[['类型 / Type','Broadcast microphone array'],['拾音 / Capture','Multiple steerable lobes'],['网络 / Network','Professional networked audio workflow']]},
    'anx4': {cn:'ANX4 可扩展无线接收机',en:'ANX4 Scalable Wireless Receiver',featuresCn:['支持 Axient Digital 和 ULX-D 系统','按需扩展通道','集中部署与远程管理'],featuresEn:['Supports Axient Digital and ULX-D systems','Scales channel capacity as requirements grow','Centralized deployment and remote management'],specs:[['类型 / Type','Scalable wireless receiver'],['系统 / Systems','Axient Digital; ULX-D'],['架构 / Architecture','Channel-scalable platform']]},
    'ksm11': {cn:'KSM11 心形电容话筒',en:'KSM11 Cardioid Condenser Microphone',featuresCn:['舞台级心形电容拾音','高一致性的离轴响应','适合专业现场人声'],featuresEn:['Stage-ready cardioid condenser capture','Consistent off-axis response','Designed for professional live vocals'],specs:[['换能器 / Transducer','Condenser'],['指向性 / Pattern','Cardioid'],['应用 / Application','Professional live vocals']]},
    'sm39': {cn:'SM39 心形指向头戴式麦克风',en:'SM39 Cardioid Headset Microphone',featuresCn:['轻量头戴式结构','心形指向有助于抑制现场噪声','LEMO3 与 TQG 型号可选'],featuresEn:['Lightweight headset design','Cardioid pattern helps reject stage noise','LEMO3 and TQG variants available'],specs:[['类型 / Type','Headset microphone'],['指向性 / Pattern','Cardioid'],['接口 / Variants','LEMO3; TQG']]},
    'mv6': {cn:'MV6 USB 游戏麦克风',en:'MV6 USB Gaming Microphone',featuresCn:['USB-C 即插即用','针对桌面游戏与直播','配合 MOTIV Mix 软件控制'],featuresEn:['Plug-and-play USB-C','Built for desktop gaming and streaming','Control through MOTIV Mix software'],specs:[['连接 / Connection','USB-C'],['应用 / Application','Gaming and streaming'],['软件 / Software','MOTIV Mix']]},
    'mxa925': {cn:'MXA925 天花阵列麦克风',en:'MXA925 Ceiling Array Microphone',featuresCn:['天花安装阵列拾音','面向混合会议空间','融入TKLBLS网络音频与 DSP 生态'],featuresEn:['Ceiling-mounted array capture','Designed for hybrid meeting spaces','Integrates with TKLBLS networked audio and DSP'],specs:[['类型 / Type','Ceiling array microphone'],['应用 / Application','Meeting and collaboration spaces'],['音频 / Audio','Networked audio workflow']]},
    'imxbpk': {cn:'IntelliMix Bar Pro Kit',en:'IntelliMix Bar Pro Kit',featuresCn:['一体化会议条形解决方案','IntelliMix 数字信号处理','面向 AI 驱动的现代协作空间'],featuresEn:['All-in-one conferencing bar solution','Integrated IntelliMix digital signal processing','Built for modern AI-enabled collaboration spaces'],specs:[['类型 / Type','All-in-one collaboration kit'],['处理 / Processing','IntelliMix DSP'],['应用 / Application','Professional meeting rooms']]},
    'imxrk': {cn:'IMX 房间解决方案套件',en:'IMX Room Kit',featuresCn:['针对不同规模会议室的预配套件','整合拾音、处理与控制','降低系统设计与部署复杂度'],featuresEn:['Preconfigured kits for multiple room sizes','Combines capture, processing and control','Reduces system design and deployment complexity'],specs:[['类型 / Type','Room solution kit'],['空间 / Rooms','Multiple room sizes'],['应用 / Application','Video collaboration']]},
    'mvx2u_xlr_usb_interface': {cn:'MVX2U 数字音频接口',en:'MVX2U Digital Audio Interface',featuresCn:['将 XLR 麦克风连接到 USB 设备','便携式前置放大与数字转换','支持 MOTIV 软件工作流'],featuresEn:['Connects an XLR microphone to a USB device','Portable preamp and digital conversion','Works with the MOTIV software workflow'],specs:[['输入 / Input','XLR'],['输出 / Output','USB'],['类型 / Type','Portable digital audio interface']]},
    'action-isolator': {cn:'Action Isolator 音频处理软件',en:'Action Isolator Audio Processing Software',featuresCn:['聚焦目标声音元素','面向制作与后期工作流','以软件方式简化复杂音频处理'],featuresEn:['Focuses selected elements within a mix','Designed for production and post workflows','Simplifies complex audio processing in software'],specs:[['类型 / Type','Audio processing software'],['应用 / Application','Production and post-production'],['交付 / Delivery','Software']]},
    'slxdplus': {cn:'SLX-D+ 无线系统',en:'SLX-D+ Wireless System',featuresCn:['专业数字无线音频','面向现场、教育、企业与礼拜场景','简化频率协调与日常管理'],featuresEn:['Professional digital wireless audio','For live, education, corporate and worship applications','Simplified frequency coordination and daily management'],specs:[['类型 / Type','Digital wireless system'],['应用 / Application','Live and installed sound'],['管理 / Management','Networked wireless workflow']]}
  };

  var productMedia = {
    mv7i:['prod_06_43d4173a660efbcd335cd10b7aa6470f.webp','cjkyzqxqfs_jpeg_MVX2UGen2_Mojo_Wide_04.jpeg','myfc3tsbwd_jpeg_MVX2UGen2_Mojo_Close-on-product_01_Horizontal.jpeg','kdxoasbecu_jpeg_MVX2UGen2_Mojo_Close-on-product_micdrop.jpeg'],
    mv88usbc:['prod_02_49f5e164c4e9c4e6315de7a9c3d3efd2.webp','2t00dqovz5_jpeg_MV88_Product_Video_Overview_Thumb.jpeg','tndfm9vkyk_webp_MV88_Android_Samsung_Vlogging_David_Close_Up_Sky.webp','d8mmjotfrf_jpeg_MV88_iPhone_Video_River_Irie_Close_Up.jpeg'],
    dca901:['prod_03_70b00ef1b4eebbc6bddf5222fcc3fe7c.webp','9y4s2ebnry_png_DCA901_Technical-Blog_1920x1080.png','hprdq88gnk_webp_DCA901_EdgeSound_Blog_1920x1080.webp','cudotyridw_jpeg_DCA901_HoW_Blog_1920x1080_1.jpeg'],
    anx4:['prod_08_0e38284eeedf7d5435df7f0d0a54fdb5.webp','henwcjgdrt_jpeg_ANX4_BlogHeader.jpeg','1ppd2pvrip_webp_SLXD1__with_Rack__Live_Performance_.webp'],
    ksm11:['prod_01_9986ae0fead8efaa3832d659c8f80def.webp','jddfcygbo2_webp_RPW194_KSM11-Nickel_CMYK_On-Black.webp','yayntpnlvw_webp_KSM_Group_Mics_Shockmounts_Tabletop_OnBlack.webp'],
    sm39:['prod_04_7e0b0cb41d096534f45b4752ce9bc7e2.webp','z3dwm2skxk_jpeg_Bad_Bunny_with_TKLBLS_SM39_Headset_Microphone.jpeg','3xqck6rcai_webp_LM-31_Landscape__1_.webp'],
    mv6:['prod_09_b4f0950e37a3c809ff6743abf1aa67c6.webp','yir6lmxibe_webp_home-music_header.webp','v2r2rqigmn_webp_MV7i_solo_guitar_laptop_Mid_squared_Create_7.webp'],
    imxbpk:['prod_07_ecf749d33ee621e2ca02b5d1ab34cee3.webp','um3h6zwpen_jpeg_web_hero_imxbpk.jpeg','xh8vbjf5e8_webp_IMXBPK_Black_Front.webp','vrwrqvivq3_jpeg_IMXBPK-B_Large_Room_5.jpeg'],
    imxrk:['2omcyu7tm6_webp_IMXRK80-Lifestyle-Large_Room-WideAngle-MultiDisplay.webp','tcasbybhcw_webp_web_hero_imx_room_kits_zoom.webp','15dbqpjhv5_webp_Meeting-Large_IMXRK70.webp','ltv6suhnpx_webp_Training-U-Shape_IMXF5_MXA920_MXW2X_MXP-6_Logitech.webp'],
    mvx2u_xlr_usb_interface:['myfc3tsbwd_jpeg_MVX2UGen2_Mojo_Close-on-product_01_Horizontal.jpeg','cjkyzqxqfs_jpeg_MVX2UGen2_Mojo_Wide_04.jpeg','kdxoasbecu_jpeg_MVX2UGen2_Mojo_Close-on-product_micdrop.jpeg','mh8zvukymm_webp_MVX2UGen2_Mojo_Wide_03.webp'],
    'action-isolator':['prod_05_ec23c97d608977e91acc9c3de3ea4d9c.webp','5wlhmlcbtg_webp_IMX_Room_Logo_Category_Thumb.webp','vp2oa4gu4g_webp_ANI_Stack.webp'],
    slxdplus:['dtshdyjmfp_webp_SLXD_-Hero_Desktop.webp','1ppd2pvrip_webp_SLXD1__with_Rack__Live_Performance_.webp','3otovlyzja_jpeg_SLX-D__Blog_1920x1080.jpeg','en4kzp3a8f_jpeg_SLX-D__ShowLinkEase_Blog_1920x1080.jpeg']
  };

  function setupStandardProductMasthead(key, data, hero, name, features) {
    if (key === 'mxa925') return;
    var media = productMedia[key] || [];
    if (!media.length) return;
    var intro = hero.nextElementSibling;
    var category = (hero.querySelector('.eyebrow') || {}).textContent || (isEnglish ? 'TKLBLS Product' : 'TKLBLS产品');
    var masthead = document.createElement('section');
    masthead.className = 'mxa-masthead standard-product-masthead';
    var thumbs = media.map(function (file, index) { var src = root + 'images/' + file; return '<button class="' + (index === 0 ? 'is-active' : '') + '" data-image="' + src + '"><img src="' + src + '" alt="' + name + ' ' + (isEnglish ? 'gallery image ' : '图库图片 ') + (index + 1) + '"></button>'; }).join('');
    masthead.innerHTML = '<div class="mxa-gallery"><div class="mxa-stage"><img class="standard-main-image" src="' + root + 'images/' + media[0] + '" alt="' + name + '"></div><div class="mxa-thumbs" aria-label="' + (isEnglish ? 'Product gallery' : '产品图库') + '">' + thumbs + '</div></div><div class="mxa-summary"><p class="eyebrow-s">' + category + '</p><h1>' + name + '</h1><p class="mxa-deck">' + features[0] + '。</p><div class="variant-group"><span>' + (isEnglish ? 'Product gallery' : '查看产品与应用') + '</span><p>' + features[1] + '</p></div><div class="mxa-actions"><a class="btn btn-primary" href="https://service.shure.com/s/contact-us?language=' + (isEnglish ? 'en_US&region=en-US' : 'zh_CN&region=zh-CN') + '">' + (isEnglish ? 'Contact Sales' : '联系销售') + ' →</a><a class="btn btn-outline" href="#documents">' + (isEnglish ? 'Documents' : '文档与支持') + '</a></div></div>';
    hero.replaceWith(masthead);
    if (intro && intro.matches('.section')) intro.remove();
    masthead.querySelectorAll('[data-image]').forEach(function (button) { button.addEventListener('click', function () { var image = masthead.querySelector('.standard-main-image'); image.classList.add('is-changing'); setTimeout(function () { image.src = button.getAttribute('data-image'); image.classList.remove('is-changing'); }, 140); masthead.querySelectorAll('[data-image]').forEach(function (item) { item.classList.toggle('is-active', item === button); }); }); });

    var advantages = document.querySelector('.product-advantages');
    if (advantages && media[1]) {
      var story = document.createElement('section');
      story.className = 'mxa-story standard-product-story';
      story.innerHTML = '<div><img src="' + root + 'images/' + media[1] + '" alt="' + name + ' ' + (isEnglish ? 'application' : '应用场景') + '"></div><div><span class="eyebrow-s">' + (isEnglish ? 'Designed for the workflow' : '为工作流而设计') + '</span><h2>' + features[1] + '</h2><p>' + features[2] + '</p></div>';
      advantages.insertAdjacentElement('afterend', story);
    }
    var specs = document.querySelector('.spec-table');
    if (specs && !document.getElementById('documents')) {
      var docs = document.createElement('section');
      docs.id = 'documents';
      docs.className = 'mxa-documents';
      docs.innerHTML = '<span class="eyebrow-s">' + (isEnglish ? 'Support' : '支持') + '</span><h2>' + (isEnglish ? 'Documents and resources' : '文档与资源') + '</h2><div><a href="' + root + (isEnglish ? 'en/search.html' : 'zh-CN/search.html') + '?q=' + encodeURIComponent(name) + '"><strong>' + (isEnglish ? 'Search documentation' : '搜索产品文档') + '</strong><span>→</span></a><a href="' + root + (isEnglish ? 'en/support.html' : 'zh-CN/support.html') + '"><strong>' + (isEnglish ? 'Product support' : '产品支持') + '</strong><span>→</span></a></div>';
      specs.insertAdjacentElement('afterend', docs);
    }
  }

  function setupProductPage() {
    var match = location.pathname.match(/\/([^/]+)\.html$/);
    var key = /\/slxd-plus\/?(?:index\.html)?$/.test(location.pathname) ? 'slxdplus' : match && match[1];
    if (!key || !productData[key]) return;
    var data = productData[key];
    var hero = document.querySelector('.page-hero');
    var article = document.querySelector('.article');
    var specs = document.querySelector('.spec-table');
    if (!hero || !article || !specs) return;
    document.body.classList.add('product-page');
    var name = isEnglish ? data.en : data.cn;
    var features = isEnglish ? data.featuresEn : data.featuresCn;
    var media = productMedia[key] || [];
    var detailImage = media[0] ? root + 'images/' + media[0] : '';
    var nav = document.createElement('nav');
    nav.className = 'product-subnav';
    nav.setAttribute('aria-label', isEnglish ? 'Product sections' : '产品页导航');
    nav.innerHTML = '<strong>' + name + '</strong><div><a href="#overview">' + (isEnglish ? 'Overview' : '概览') + '</a><a href="#advantages">' + (isEnglish ? 'Benefits' : '产品优势') + '</a><a href="#specifications">' + (isEnglish ? 'Specifications' : '规格') + '</a><a href="#documents">' + (isEnglish ? 'Downloads' : '下载') + '</a></div>';
    var breadcrumb = document.querySelector('.breadcrumb');
    (breadcrumb || hero).insertAdjacentElement('beforebegin', nav);
    article.id = 'overview';
    article.className = 'product-overview';
    article.innerHTML = '<span class="eyebrow-s">' + (isEnglish ? 'Product Overview' : '产品概览') + '</span><h2>' + name + '</h2><p class="lead">' + features[0] + '</p>';
    var advantages = document.createElement('section');
    advantages.id = 'advantages';
    advantages.className = 'product-advantages';
    advantages.innerHTML = '<span class="eyebrow-s">' + (isEnglish ? 'Why it matters' : 'TKLBLS产品优势') + '</span><h2>' + (isEnglish ? 'Built for the workflow' : '为真实工作流而设计') + '</h2><div>' + features.map(function (feature, index) { return '<article><span>0' + (index + 1) + '</span><h3>' + feature + '</h3></article>'; }).join('') + '</div>';
    article.insertAdjacentElement('afterend', advantages);
    specs.id = 'specifications';
    specs.innerHTML = '<span class="eyebrow-s">' + (isEnglish ? 'At a glance' : '主要规格') + '</span><h2>' + (isEnglish ? 'Product specifications' : '产品规格') + '</h2><table>' + data.specs.map(function (row) { return '<tr><th>' + row[0] + '</th><td>' + row[1] + '</td></tr>'; }).join('') + '</table><p class="spec-note">' + (isEnglish ? 'Confirm detailed technical data and current documents on the official TKLBLS product page.' : '详细技术数据、型号变体和当前文档请以TKLBLS官方产品页为准。') + '</p>';
    setupStandardProductMasthead(key, data, hero, name, features);
  }

  function setupMXA925Page() {
    if (!/\/products\/microphones\/mxa925\.html$/.test(location.pathname)) return;
    var hero = document.querySelector('.page-hero');
    var intro = hero && hero.nextElementSibling;
    var overview = document.querySelector('.product-overview');
    var advantages = document.querySelector('.product-advantages');
    var specs = document.querySelector('.spec-table');
    if (!hero || !overview || !advantages || !specs) return;
    document.body.classList.add('mxa925-page');
    var base = root + 'images/mxa925/';
    var masthead = document.createElement('section');
    masthead.className = 'mxa-masthead';
    masthead.innerHTML = '<div class="mxa-gallery"><div class="mxa-stage"><img id="mxaMainImage" src="' + base + 'product-round-black.webp" alt="MXA925 黑色圆形天花板阵列麦克风"></div><div class="mxa-thumbs" aria-label="' + (isEnglish ? 'Product gallery' : '产品图库') + '"><button class="is-active" data-image="' + base + 'product-round-black.webp"><img src="' + base + 'product-round-black.webp" alt="' + (isEnglish ? 'Black round model' : '黑色圆形款') + '"></button><button data-image="' + base + 'product-square-black.webp"><img src="' + base + 'product-square-black.webp" alt="' + (isEnglish ? 'Black square model' : '黑色方形款') + '"></button><button data-image="' + base + 'product-round-white.webp"><img src="' + base + 'product-round-white.webp" alt="' + (isEnglish ? 'White round model' : '白色圆形款') + '"></button><button data-image="' + base + 'lifestyle-01.webp"><img src="' + base + 'lifestyle-01.webp" alt="' + (isEnglish ? 'MXA925 meeting room application' : 'MXA925 会议室应用') + '"></button></div></div>' +
      '<div class="mxa-summary"><span class="product-badge">' + (isEnglish ? 'NEW' : '新品') + '</span><p class="eyebrow-s">' + (isEnglish ? 'Ceiling Array Microphone' : '天花板阵列麦克风') + '</p><h1>MXA925</h1><p class="mxa-deck">' + (isEnglish ? 'AI-powered premium voice capture, camera tracking, and voice lift for modern meeting spaces.' : '适用于现代会议空间的 AI 赋能高级语音采集、摄像头跟踪和语音增强功能。') + '</p><div class="variant-group"><span>' + (isEnglish ? 'Choose a finish' : '选择外观') + '</span><div><button class="variant-choice is-active" data-image="' + base + 'product-round-black.webp">' + (isEnglish ? 'Black / Round' : '黑色 / 圆形') + '</button><button class="variant-choice" data-image="' + base + 'product-square-black.webp">' + (isEnglish ? 'Black / Square' : '黑色 / 方形') + '</button><button class="variant-choice" data-image="' + base + 'product-round-white.webp">' + (isEnglish ? 'White / Round' : '白色 / 圆形') + '</button></div></div><div class="mxa-actions"><a class="btn btn-primary" href="https://service.shure.com/s/contact-us?language=' + (isEnglish ? 'en_US&region=en-US' : 'zh_CN&region=zh-CN') + '">' + (isEnglish ? 'Contact Sales' : '联系销售') + ' →</a><a class="btn btn-outline" href="#documents">' + (isEnglish ? 'Downloads' : '文档与下载') + '</a></div></div>';
    hero.replaceWith(masthead);
    if (intro && intro.matches('.section')) intro.remove();

    var awards = document.createElement('section');
    awards.className = 'mxa-awards';
    awards.innerHTML = '<span class="eyebrow-s">' + (isEnglish ? 'Awards' : '奖项') + '</span><h2>' + (isEnglish ? 'Recognized innovation' : '获得行业认可的创新') + '</h2><div><img src="' + base + 'award-best-infocomm.webp" alt="Best of InfoComm 2026"><img src="' + base + 'award-best-show.webp" alt="InfoComm Best of Show 2026"><img src="' + base + 'award-sipa.webp" alt="SCN Stellar Service Product Award 2026"></div>';
    masthead.insertAdjacentElement('afterend', awards);

    overview.innerHTML = '<span class="eyebrow-s">' + (isEnglish ? 'Product overview' : '产品概览') + '</span><h2>' + (isEnglish ? 'AI-powered audio for modern rooms' : 'AI 赋能的现代会议音频') + '</h2><p class="lead">' + (isEnglish ? 'MXA925 builds on TKLBLS’s proven ceiling array platform with AI-powered IntelliMix DSP for clear, natural speech and scalable, IT-friendly deployment.' : 'MXA925 天花板阵列麦克风基于TKLBLS久经考验的吸顶阵列平台打造，采用 AI 赋能的 IntelliMix® 数字信号处理，可提供清晰、自然的语音。') + '</p><p>' + (isEnglish ? 'Dual RJ45 ports, enterprise security, and TKLBLSCloud remote management make it a future-ready solution for organizations that need reliable audio performance.' : '双 RJ45 端口、企业级安全性和 TKLBLSCloud 远程管理功能，使其成为对 IT 友好、面向未来的可扩展解决方案。') + '</p>';

    advantages.innerHTML = '<span class="eyebrow-s">' + (isEnglish ? 'TKLBLS product benefits' : 'TKLBLS产品优势') + '</span><h2>' + (isEnglish ? 'Coverage, clarity, and control' : '覆盖、清晰度与控制') + '</h2><div><article><span>01</span><h3>Automatic Coverage™</h3><p>' + (isEnglish ? 'A default 30 x 30 ft (9 x 9 m) coverage area enables fast setup, with up to eight configurable coverage areas.' : '默认覆盖 30 英尺 × 30 英尺（9 米 × 9 米），并可配置最多 8 个覆盖区域。') + '</p></article><article><span>02</span><h3>AI IntelliMix® DSP</h3><p>' + (isEnglish ? 'AI acoustic echo cancellation, noise reduction, and reverberation processing keep speech clear and natural.' : 'AI 声学回声消除、AI 降噪与 AI 混响处理，使语音保持清晰自然。') + '</p></article><article><span>03</span><h3>' + (isEnglish ? 'Enterprise-ready' : '企业级部署') + '</h3><p>' + (isEnglish ? 'Dual RJ45 ports, 802.1X, audio encryption, and TKLBLSCloud support secure, scalable deployment.' : '双 RJ45、802.1X、音频加密和 TKLBLSCloud 支持安全、可扩展的部署。') + '</p></article></div>';

    var story = document.createElement('section');
    story.className = 'mxa-story';
    story.innerHTML = '<div><img src="' + base + 'lifestyle-02.webp" alt="MXA925 ' + (isEnglish ? 'in a modern meeting room' : '现代会议室应用') + '"></div><div><span class="eyebrow-s">' + (isEnglish ? 'Designed for IT and AV' : '为 IT 与 AV 而设计') + '</span><h2>' + (isEnglish ? 'Flexible by design' : '灵活的系统设计') + '</h2><p>' + (isEnglish ? 'Separate audio and control traffic when required, monitor devices remotely, and keep firmware current through TKLBLSCloud.' : '可根据需要分离音频与控制流量，远程监控设备，并通过 TKLBLSCloud 管理固件更新。') + '</p><ul><li>' + (isEnglish ? 'Black or white finish' : '黑色或白色外观') + '</li><li>' + (isEnglish ? 'Round or square form factor' : '圆形或方形外形') + '</li><li>' + (isEnglish ? 'Compatible with MXA920 mounting accessories' : '兼容 MXA920 安装配件') + '</li></ul></div>';
    advantages.insertAdjacentElement('afterend', story);

    specs.innerHTML = '<span class="eyebrow-s">' + (isEnglish ? 'At a glance' : '主要规格') + '</span><h2>' + (isEnglish ? 'MXA925 specifications' : 'MXA925 规格') + '</h2><table><tr><th>' + (isEnglish ? 'Default coverage' : '默认覆盖') + '</th><td>30 ft × 30 ft / 9 m × 9 m</td></tr><tr><th>' + (isEnglish ? 'Coverage areas' : '覆盖区域') + '</th><td>' + (isEnglish ? 'Up to 8 configurable areas' : '最多 8 个可配置区域') + '</td></tr><tr><th>DSP</th><td>AI AEC / AI Noise Reduction / AI De-Reverberation</td></tr><tr><th>' + (isEnglish ? 'Network' : '网络') + '</th><td>2 × RJ45</td></tr><tr><th>' + (isEnglish ? 'Security' : '安全') + '</th><td>802.1X / ' + (isEnglish ? 'Audio encryption' : '音频加密') + '</td></tr><tr><th>' + (isEnglish ? 'Management' : '管理') + '</th><td>TKLBLSCloud</td></tr><tr><th>' + (isEnglish ? 'Finishes' : '外观') + '</th><td>' + (isEnglish ? 'Black or white; round or square' : '黑色或白色；圆形或方形') + '</td></tr></table>';

    var docs = document.createElement('section');
    docs.id = 'documents';
    docs.className = 'mxa-documents';
    docs.innerHTML = '<span class="eyebrow-s">' + (isEnglish ? 'Documents and tools' : '文档与工具') + '</span><h2>' + (isEnglish ? 'Downloads' : '下载') + '</h2><div><a href="https://www.shure.com/en-US/docs/guide/mxa925"><strong>MXA925 User Guide</strong><span>HTML ↗</span></a><a href="https://www.shure.com/en-US/docs/commandstrings/mxa925"><strong>MXA925 Command Strings</strong><span>HTML ↗</span></a><a href="https://shure.widen.net/s/6kqxk7xpzs/shure_mxa925_cad"><strong>MXA925 CAD</strong><span>ZIP ↗</span></a><a href="https://shure.widen.net/s/cpktdxcnxm/mxa925_specsheet_en"><strong>MXA925 Specification Sheet</strong><span>PDF ↗</span></a></div>';
    specs.insertAdjacentElement('afterend', docs);

    function selectImage(src, button) {
      var image = masthead.querySelector('#mxaMainImage');
      image.classList.add('is-changing');
      setTimeout(function () { image.src = src; image.classList.remove('is-changing'); }, 140);
      masthead.querySelectorAll('.mxa-thumbs button,.variant-choice').forEach(function (item) { item.classList.toggle('is-active', item === button || item.getAttribute('data-image') === src); });
    }
    masthead.querySelectorAll('[data-image]').forEach(function (button) { button.addEventListener('click', function () { selectImage(button.getAttribute('data-image'), button); }); });
  }

  function finalizeProductDetailFlow() {
    if (!document.body.classList.contains('product-page')) return;
    var match = location.pathname.match(/\/([^/]+)\.html$/);
    var key = /\/slxd-plus\/?(?:index\.html)?$/.test(location.pathname) ? 'slxdplus' : match && match[1];
    var data = key && productData[key];
    if (!data) return;
    var name = isEnglish ? data.en : data.cn;
    var features = isEnglish ? data.featuresEn : data.featuresCn;
    var overview = document.querySelector('.product-overview');
    var advantages = document.querySelector('.product-advantages');
    if (!overview || !advantages) return;

    var detailsTitle = isEnglish ? 'Details' : '详细信息';
    var packageTitle = isEnglish ? 'In the box' : '包装清单';
    var subnavLinks = document.querySelector('.product-subnav div');
    if (subnavLinks) subnavLinks.innerHTML = '<a href="#overview">' + detailsTitle + '</a><a href="#advantages">' + (isEnglish ? 'Benefits' : '产品优势') + '</a><a href="#related-products">' + (isEnglish ? 'Related products' : '相关产品') + '</a>';
    document.querySelectorAll('.mxa-actions a[href="#documents"]').forEach(function (link) { link.remove(); });
    var details = document.createElement('section');
    details.id = 'overview';
    details.className = 'product-information';
    details.innerHTML = '<div class="product-accordion"><article class="is-open"><button type="button" aria-expanded="true"><strong>' + detailsTitle + '</strong><span>−</span></button><div class="product-detail-panel"><div class="product-detail-copy"><p>' + features.join(isEnglish ? '. ' : '。') + (isEnglish ? '.' : '。') + '</p><ul>' + data.specs.map(function (row) { return '<li><b>' + row[0] + '</b><span>' + row[1] + '</span></li>'; }).join('') + '</ul></div>' + (detailImage ? '<figure class="product-detail-media"><img src="' + detailImage + '" alt="' + name + '"></figure>' : '<figure class="product-detail-media" aria-hidden="true"></figure>') + '</div></article><article><button type="button" aria-expanded="false"><strong>' + packageTitle + '</strong><span>＋</span></button><div hidden><ul><li><b>' + name + '</b><span>× 1</span></li><li><b>' + (isEnglish ? 'Quick start guide' : '快速入门指南') + '</b><span>× 1</span></li><li><b>' + (isEnglish ? 'Safety and warranty information' : '安全与保修信息') + '</b><span>× 1</span></li></ul><small>' + (isEnglish ? 'Included items may vary by model and region.' : '包装内容可能因具体型号和销售地区而异。') + '</small></div></article></div>';
    overview.replaceWith(details);
    details.querySelectorAll('.product-accordion button').forEach(function (button) {
      button.addEventListener('click', function () {
        var item = button.parentElement;
        var panel = button.nextElementSibling;
        var open = button.getAttribute('aria-expanded') === 'true';
        if (!open) {
          details.querySelectorAll('.product-accordion article.is-open').forEach(function (other) {
            if (other === item) return;
            var otherButton = other.querySelector('button');
            var otherPanel = otherButton && otherButton.nextElementSibling;
            other.classList.remove('is-open');
            otherButton.setAttribute('aria-expanded', 'false');
            otherButton.querySelector('span').textContent = '＋';
            if (otherPanel) otherPanel.hidden = true;
          });
        }
        button.setAttribute('aria-expanded', String(!open));
        button.querySelector('span').textContent = open ? '＋' : '−';
        item.classList.toggle('is-open', !open);
        panel.hidden = open;
      });
    });

    document.querySelectorAll('.mxa-awards,.mxa-story,.mxa-documents,.spec-table').forEach(function (section) { section.remove(); });
    var related = Array.prototype.find.call(document.querySelectorAll('section.section'), function (section) {
      var heading = section.querySelector('h2');
      return heading && /您可能也会喜欢|You may also like/i.test(heading.textContent);
    });
    if (!related) return;
    related.id = 'related-products';
    related.className = 'product-related';
    var relatedHeading = related.querySelector('h2');
    if (relatedHeading) relatedHeading.textContent = isEnglish ? 'Related products' : '相关产品';
    var eyebrow = related.querySelector('.eyebrow-s');
    if (eyebrow) eyebrow.remove();
    var track = related.querySelector('.cards');
    if (track) {
      track.classList.add('related-track');
      var viewport = document.createElement('div');
      viewport.className = 'related-viewport';
      track.parentNode.insertBefore(viewport, track);
      viewport.appendChild(track);
      var controls = document.createElement('div');
      controls.className = 'related-controls';
      controls.innerHTML = '<button type="button" aria-label="' + (isEnglish ? 'Previous products' : '上一组产品') + '">←</button><button type="button" aria-label="' + (isEnglish ? 'Next products' : '下一组产品') + '">→</button>';
      related.insertBefore(controls, viewport);
      var buttons = controls.querySelectorAll('button');
      buttons[0].addEventListener('click', function () { viewport.scrollBy({left:-viewport.clientWidth * .8,behavior:'smooth'}); });
      buttons[1].addEventListener('click', function () { viewport.scrollBy({left:viewport.clientWidth * .8,behavior:'smooth'}); });
    }
    advantages.insertAdjacentElement('afterend', related);
  }

  function setupIcons() {
    var globe = '<svg viewBox="0 0 24 24" aria-hidden="true"><circle cx="12" cy="12" r="9"/><path d="M3 12h18M12 3c3 3.4 3 14.6 0 18M12 3c-3 3.4-3 14.6 0 18"/></svg>';
    document.querySelectorAll('.topbar li:first-child span').forEach(function (span) { span.innerHTML = globe; span.className = 'ui-icon'; });
    document.querySelectorAll('.socials a').forEach(function (link) {
      var label = (link.getAttribute('aria-label') || '').toLowerCase();
      if (label === 'wechat') link.innerHTML = '<svg viewBox="0 0 24 24" aria-hidden="true"><path d="M9.5 5C5.9 5 3 7.3 3 10.1c0 1.6.9 3 2.4 4l-.6 2.1 2.4-1.3c.7.2 1.5.3 2.3.3 3.6 0 6.5-2.3 6.5-5.1S13.1 5 9.5 5Z"/><path d="M14.7 9.4c3.5 0 6.3 2.2 6.3 5 0 1.5-.8 2.9-2.2 3.8l.5 1.9-2.2-1.2c-.8.3-1.6.4-2.4.4-2.5 0-4.6-1.1-5.6-2.8 4.7.1 8.4-2.7 8.4-6.3v-.4c-.8-.3-1.8-.4-2.8-.4Z"/></svg>';
      if (label === 'weibo') link.innerHTML = '<svg viewBox="0 0 24 24" aria-hidden="true"><path d="M20 12.8c0 4-4.1 7.2-9.2 7.2C6.5 20 3 17.7 3 14.8c0-1.7 1.2-3.3 3.2-4.4-.2-.5-.3-1-.1-1.4.4-.9 1.8-1.1 3.2-.5 1.1-.5 2.3-.8 3.6-.8 4 0 7.1 2.3 7.1 5.1Z"/><path d="M15.5 4.6c2.6.2 4.6 2.2 4.8 4.6M16 2c3.8.2 6.8 3.2 7 7"/></svg>';
      if (label === 'youku') link.innerHTML = '<svg viewBox="0 0 24 24" aria-hidden="true"><path d="m9 6 9 6-9 6V6Z"/></svg>';
    });
  }

  function setupCookiePreferences() {
    var links = Array.prototype.filter.call(document.querySelectorAll('.legal-links a'), function (link) {
      return /cookie/i.test(link.textContent) || /更改Cookie/.test(link.textContent);
    });
    if (!links.length) return;
    links.forEach(function (link) {
      link.removeAttribute('onclick');
      link.href = '#cookie-preferences';
      link.addEventListener('click', function (event) { event.preventDefault(); openDialog(); });
    });
    function openDialog() {
      var saved = {};
      try { saved = JSON.parse(localStorage.getItem('TKLBLS-cookie-preferences') || '{}'); } catch (ignore) {}
      var dialog = document.createElement('dialog');
      dialog.className = 'cookie-dialog';
      dialog.innerHTML = '<form method="dialog"><div class="dialog-head"><h2>' + (isEnglish ? 'Cookie preferences' : 'Cookie 偏好设置') + '</h2><button value="cancel" aria-label="' + (isEnglish ? 'Close' : '关闭') + '">×</button></div><p>' + (isEnglish ? 'Choose which optional browser storage this static site may use. Essential storage is required for basic preferences.' : '选择本静态站点可以使用的可选浏览器存储。基本偏好需要必要存储。') + '</p>' +
        '<label><span><strong>' + (isEnglish ? 'Essential' : '必要') + '</strong><small>' + (isEnglish ? 'Language and privacy choices' : '语言与隐私选择') + '</small></span><input type="checkbox" checked disabled></label>' +
        '<label><span><strong>' + (isEnglish ? 'Preferences' : '偏好') + '</strong><small>' + (isEnglish ? 'Remember form and interface choices' : '记住表单与界面选择') + '</small></span><input name="preferences" type="checkbox" ' + (saved.preferences ? 'checked' : '') + '></label>' +
        '<label><span><strong>' + (isEnglish ? 'Analytics' : '分析') + '</strong><small>' + (isEnglish ? 'Anonymous usage measurement' : '匿名使用情况测量') + '</small></span><input name="analytics" type="checkbox" ' + (saved.analytics ? 'checked' : '') + '></label>' +
        '<div class="dialog-actions"><button class="btn btn-outline" value="reject">' + (isEnglish ? 'Essential only' : '仅必要') + '</button><button class="btn btn-primary" value="save">' + (isEnglish ? 'Save choices' : '保存选择') + '</button></div></form>';
      document.body.appendChild(dialog);
      dialog.addEventListener('close', function () {
        if (dialog.returnValue === 'save') {
          localStorage.setItem('TKLBLS-cookie-preferences', JSON.stringify({preferences:dialog.querySelector('[name="preferences"]').checked, analytics:dialog.querySelector('[name="analytics"]').checked, updated:new Date().toISOString()}));
        }
        if (dialog.returnValue === 'reject') localStorage.setItem('TKLBLS-cookie-preferences', JSON.stringify({preferences:false,analytics:false,updated:new Date().toISOString()}));
        dialog.remove();
      });
      dialog.showModal();
    }
    var hasCookieChoice = false;
    try { hasCookieChoice = !!localStorage.getItem('TKLBLS-cookie-preferences'); } catch (ignore) {}
    if (!hasCookieChoice) {
      var banner = document.createElement('aside');
      banner.className = 'cookie-banner';
      banner.setAttribute('aria-label', isEnglish ? 'Cookie notice' : 'Cookie 提示');
      banner.innerHTML = '<p><strong>' + (isEnglish ? 'Your privacy choices' : '您的隐私选择') + '</strong><span>' + (isEnglish ? 'This site uses essential browser storage and optional preference storage.' : '本站使用必要的浏览器存储，并可选使用偏好存储。') + '</span></p><div><button class="btn btn-outline" data-cookie="essential">' + (isEnglish ? 'Essential only' : '仅必要') + '</button><button class="btn btn-outline" data-cookie="settings">' + (isEnglish ? 'Settings' : '设置') + '</button><button class="btn btn-primary" data-cookie="accept">' + (isEnglish ? 'Accept preferences' : '接受偏好') + '</button></div>';
      document.body.appendChild(banner);
      banner.addEventListener('click', function (event) {
        var action = event.target.getAttribute('data-cookie');
        if (!action) return;
        if (action === 'settings') { openDialog(); banner.remove(); return; }
        try { localStorage.setItem('TKLBLS-cookie-preferences', JSON.stringify({preferences:action === 'accept',analytics:false,updated:new Date().toISOString()})); } catch (ignore) {}
        banner.classList.add('is-hiding');
        setTimeout(function () { banner.remove(); }, 250);
      });
    }
  }

  function setupForms() {
    document.querySelectorAll('.newsletter form').forEach(function (form) {
      form.removeAttribute('onsubmit');
      form.addEventListener('submit', function (event) {
        event.preventDefault();
        var input = form.querySelector('input[type="email"]');
        var button = form.querySelector('button');
        if (!input || !input.checkValidity()) { if (input) input.reportValidity(); return; }
        try { localStorage.setItem('TKLBLS-newsletter-email', input.value.trim()); } catch (ignore) {}
        button.textContent = isEnglish ? 'Saved ✓' : '已保存 ✓';
        button.disabled = true;
        var status = document.createElement('span');
        status.className = 'form-status';
        status.setAttribute('role', 'status');
        status.textContent = isEnglish ? 'Your email preference was saved on this device. No message has been sent.' : '邮箱偏好已保存在本设备，尚未向远程服务发送。';
        form.insertAdjacentElement('afterend', status);
      });
    });
  }

  function setupFilterBars() {
    document.querySelectorAll('.filter-bar').forEach(function (bar) {
      var cards = Array.prototype.slice.call((bar.nextElementSibling || document).querySelectorAll('.card'));
      if (!cards.length) { bar.hidden = true; return; }
      var buttons = Array.prototype.slice.call(bar.querySelectorAll('button'));
      buttons.forEach(function (button, index) {
        button.setAttribute('aria-pressed', index === 0 ? 'true' : 'false');
        button.addEventListener('click', function () {
          buttons.forEach(function (item) { item.classList.remove('on'); item.setAttribute('aria-pressed', 'false'); });
          button.classList.add('on');
          button.setAttribute('aria-pressed', 'true');
          cards.forEach(function (card, cardIndex) {
            card.hidden = index === 1 ? cardIndex >= 6 : index === 2 ? cardIndex < Math.max(0, cards.length - 6) : false;
          });
        });
      });
    });
  }

  function setupPageTransitions() {
    var layer = document.createElement('div');
    layer.className = 'page-transition is-entering';
    layer.setAttribute('role', 'status');
    layer.setAttribute('aria-live', 'polite');
    layer.innerHTML = '<span class="transition-mark">TKLBLS</span><span class="transition-line"></span><span class="sr-only">' + (isEnglish ? 'Loading page' : '正在加载页面') + '</span>';
    document.body.appendChild(layer);
    requestAnimationFrame(function () { requestAnimationFrame(function () { layer.classList.remove('is-entering'); }); });
    window.addEventListener('pageshow', function () { layer.classList.remove('is-leaving'); document.documentElement.classList.remove('is-navigating'); document.body.removeAttribute('aria-busy'); });
    document.addEventListener('click', function (event) {
      var link = event.target.closest('a[href]');
      if (!link || event.defaultPrevented || event.button !== 0 || event.metaKey || event.ctrlKey || event.shiftKey || event.altKey) return;
      var raw = link.getAttribute('href');
      if (!raw || raw.charAt(0) === '#' || /^(?:javascript:|mailto:|tel:)/i.test(raw) || link.target === '_blank' || link.hasAttribute('download')) return;
      var target;
      try { target = new URL(link.href, location.href); } catch (ignore) { return; }
      if (target.origin !== location.origin || (target.pathname === location.pathname && target.search === location.search)) return;
      event.preventDefault();
      document.documentElement.classList.add('is-navigating');
      document.body.setAttribute('aria-busy', 'true');
      layer.classList.add('is-leaving');
      setTimeout(function () { location.href = target.href; }, window.matchMedia('(prefers-reduced-motion: reduce)').matches ? 0 : 320);
    });
  }

  function setupMediaLoading() {
    document.querySelectorAll('img').forEach(function (img, index) {
      var isCritical = index < 2 || !!img.closest('.slide.is-active,.page-hero');
      img.loading = isCritical ? 'eager' : 'lazy';
      img.decoding = 'async';
      if (isCritical) img.fetchPriority = 'high';
      var parent = img.parentElement;
      if (!parent) return;
      parent.classList.add('image-loading');
      function done() { parent.classList.add('image-loaded'); }
      if (img.complete) done(); else { img.addEventListener('load', done, {once:true}); img.addEventListener('error', done, {once:true}); }
    });
  }

  function setupMobileNavigationAccessibility() {
    var nav = document.getElementById('mainnav');
    var toggle = document.getElementById('navToggle');
    if (!nav || !toggle) return;
    var wasOpen = document.body.classList.contains('nav-open');
    new MutationObserver(function () {
      var open = document.body.classList.contains('nav-open');
      if (open && !wasOpen) {
        var first = nav.querySelector('button,a');
        if (first) setTimeout(function () { first.focus(); }, 30);
      }
      if (!open && wasOpen && nav.contains(document.activeElement)) toggle.focus();
      wasOpen = open;
    }).observe(document.body, {attributes:true,attributeFilter:['class']});
    nav.addEventListener('keydown', function (event) {
      if (event.key !== 'Tab' || !document.body.classList.contains('nav-open')) return;
      var focusable = Array.prototype.slice.call(nav.querySelectorAll('a[href],button:not([disabled])')).filter(function (item) { return item.offsetParent !== null; });
      if (!focusable.length) return;
      var first = focusable[0], last = focusable[focusable.length - 1];
      if (event.shiftKey && document.activeElement === first) { event.preventDefault(); last.focus(); }
      else if (!event.shiftKey && document.activeElement === last) { event.preventDefault(); first.focus(); }
    });
  }

  setupHeaderSearch();
  setupMegaMenuGeometry();
  setupSearchPage();
  setupDealerPage();
  setupProductPage();
  setupMXA925Page();
  finalizeProductDetailFlow();
  setupIcons();
  setupCookiePreferences();
  setupForms();
  setupFilterBars();
  setupPageTransitions();
  setupMediaLoading();
  setupMobileNavigationAccessibility();
}());
