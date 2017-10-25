---
title: Hexo+NexT 博客搭建相册(二)
date: 2017-09-18 14:10:24
tags:
- Hexo
- NexT
- 相册
- Photo
categories:
- 技术
- Hexo
top: 4
essential: true
---
<img src="https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1505726176244&di=4cfcaa9b699b336d366ff823c5625f32&imgtype=0&src=http%3A%2F%2Fimg10.3lian.com%2Fsc6%2Fshow%2F08%2F19%2F20110510230141386.jpg" class="full-image" />

上一篇文章 <a href="https://timding.top/2017/09/18/Hexo-NexT-%E5%8D%9A%E5%AE%A2%E6%90%AD%E5%BB%BA%E7%9B%B8%E5%86%8C-%E4%B8%80/">Hexo+NexT 博客搭建相册(一)</a> 讲解了怎样用 github 来创建相册库.现在来讲解怎样在 hexo 中使用相册库.
<!-- more-->
准备工作
----------
按照 <a href="https://timding.top/2017/09/18/Hexo-NexT-%E5%8D%9A%E5%AE%A2%E6%90%AD%E5%BB%BA%E7%9B%B8%E5%86%8C-%E4%B8%80/">Hexo+NexT 博客搭建相册(一)</a> 搭建好相册库.

增加相册style
----------
在 next 主题下面增加 photo.swig 页面.
路径如下
> next/layout

由于篇幅原因,大家可以在我的 github 上面下载 <a href="https://github.com/lovexinforever/blog_back_up/blob/master/photo.swig">photo.swig</a>

生成相册页面
----------
生成相册页面和生成分类和标签页面一样
> hexo new page "photos"

修改 photos 下的 index.md文件
由于字数限制,代码不贴出来了,大家可以在我的 github 上面下载
<a href="https://github.com/lovexinforever/blog_back_up/blob/master/index.md">index.md</a>
其中 `<a href="https://timding.top" target="_blank" class="open-ins">图片正在加载中…</a>`中的 url 替换成你的博客网址.
需要 三个 css 文件 和一个 js 文件.都在我的 github 上面 ,其中`photoswipe.css`和`default-skin.css`这 css 是查看图片插件的 css, 后面会说到,把这些 css 和 js 文件都在 photos 文件夹下面
<a href="https://github.com/lovexinforever/blog_back_up/blob/master/ins.css">ins.css</a>
<a href="https://github.com/lovexinforever/blog_back_up/blob/master/photoswipe.css">photoswipe.css</a>
<a href="hhttps://github.com/lovexinforever/blog_back_up/tree/master/default-skin">default-skin</a>
<a href="https://github.com/lovexinforever/blog_back_up/blob/master/ins.js">ins.js</a>
需要修改 `ins.js` 的 120和121行的 url 为你 github 的图片的网址.

查看相册插件 photoswipe
----------
上面 index.md 中加入了两个 css 文件,这是我们用 photoswipe 查看相册用到的.具体可以参考网址 <a href="http://photoswipe.com/">photoswipe</a>
这里我们已经把 css 文件加上了.之后我们要加上 js 文件 <a href="">photoswipe.min.js</a> 和<a href="">photoswipe-ui-default.min.js</a>
js存放路径为
> next/source/js/src

引用 js 文件
----------
在 `_layout.swig` 中插入
```
<script src="{{ url_for(theme.js) }}/src/photoswipe.min.js?v={{ theme.version }}"></script>
<script src="{{ url_for(theme.js) }}/src/photoswipe-ui-default.min.js?v={{ theme.version }}"></script>
```
放在 head 标签里面
`_layout.swig` 路径为
> next/layout

到这里已经差不多完成了相册查看,还差最后一步,在 index.html 中加入 标签.

在根目录加入标签
----------
在 _layout.swig 中 </body> 前插入
```
{% if page.type === "photos" %}
<!-- Root element of PhotoSwipe. Must have class pswp. -->
<div class="pswp" tabindex="-1" role="dialog" aria-hidden="true">
    <div class="pswp__bg"></div>
    <div class="pswp__scroll-wrap">
        <div class="pswp__container">
            <div class="pswp__item"></div>
            <div class="pswp__item"></div>
            <div class="pswp__item"></div>
        </div>
        <div class="pswp__ui pswp__ui--hidden">
            <div class="pswp__top-bar">
                <div class="pswp__counter"></div>
                <button class="pswp__button pswp__button--close" title="Close (Esc)"></button>
                <button class="pswp__button pswp__button--share" title="Share"></button>
                <button class="pswp__button pswp__button--fs" title="Toggle fullscreen"></button>
                <button class="pswp__button pswp__button--zoom" title="Zoom in/out"></button>
                <!-- Preloader demo http://codepen.io/dimsemenov/pen/yyBWoR -->
                <!-- element will get class pswp__preloader--active when preloader is running -->
                <div class="pswp__preloader">
                    <div class="pswp__preloader__icn">
                      <div class="pswp__preloader__cut">
                        <div class="pswp__preloader__donut"></div>
                      </div>
                    </div>
                </div>
            </div>
            <div class="pswp__share-modal pswp__share-modal--hidden pswp__single-tap">
                <div class="pswp__share-tooltip"></div> 
            </div>
            <button class="pswp__button pswp__button--arrow--left" title="Previous (arrow left)">
            </button>
            <button class="pswp__button pswp__button--arrow--right" title="Next (arrow right)">
            </button>
            <div class="pswp__caption">
                <div class="pswp__caption__center"></div>
            </div>
        </div>
    </div>
</div>
{% endif %}
```
至此相册查看插件 photoswipe 已经配置完毕.

整个流程使用
----------
- 在 blog_back_up 里面加入图片,图片路径在 photos 里面 图片命名方式 yyyy-MM-dd_des.jpg/jpeg/gif/png.
- 执行 python3 tool.py
- 切换到博客 resource 目录下
- 在 photos 里面生成了 data.json 文件 提交到github 上面.
- 输入网址查看照片.

效果展示
----------
<img src="http://obqo5zeui.bkt.clouddn.com/QQ20170918-162151@2x.png" />
<img src="http://obqo5zeui.bkt.clouddn.com/QQ20170918-162204@2x.png" />
<img src="http://obqo5zeui.bkt.clouddn.com/QQ20170918-162218@2x.png" />

