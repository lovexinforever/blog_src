---
title: photos
date: 2017-09-15 09:51:05
type: "photos"
comments: false
---
<link rel="stylesheet" href="./ins.css">
<div class="photos-btn-wrap">
	<a class="photos-btn active" href="javascript:void(0)">Photos</a>
	<a class="photos-btn" href="#">待续</a>
</div>
<div class="instagram itemscope">
	<a href="https://lovexinforever.github.io" target="_blank" class="open-ins">图片正在加载中…</a>
</div>
<script>
  (function() {
    var loadScript = function(path) {
      var $script = document.createElement('script')
      document.getElementsByTagName('body')[0].appendChild($script)
      $script.setAttribute('src', path)
    }
    setTimeout(function() {
      loadScript('./ins.js')
    }, 0)
  })()
</script>