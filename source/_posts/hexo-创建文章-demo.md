title: hexo 创建文章 demo
date: 2015-12-23 09:31:52
tags:
- hexo
- node.js
categories: 
- 技术
- 日志


---
<blockquote class="blockquote-center"><h2>千里之行,始于足下</h2></br>总有刁民想害朕</blockquote>

关于hexo 发布文章的一些标签的用法
=======
### 这部分Docs分了8块内容，分别从写作、前置声明、标签插件、资源目录、数据文件、服务器、生成器、部署。也许翻译得不得当，但是我尽量把主要内容呈现出来并加上自己的理解。
<!-- more -->
1. 写作
-----------
写作之前当然得先创建一个.md文件，使用命令<font color="#f00">`hexo new [layout] <title>`</font>，其中layout默认为post，前面提过。

（1）Layout布局

Hexo提供了3种默认的布局，<font color="#f00">`post`</font>、<font color="#f00">`page`</font>和<font color="#f00">`draft`</font>，路径分别为：<font color="#f00">`source/_posts`</font>、<font color="#f00">`source`</font>、<font color="#f00">`source/_draft`</font>。如果你将在文章前置申明中，将layout设置为false，那么这篇文章将不会有任何的布局。

（2）Filename文件名

Hexo会默认将文章的标题当做文件名，但是你可以编辑<font color="#f00">`_config.yml`</font>配置文件中的<font color="#f00">`new_post_name`</font>来改变默认的文件名。

例如：使用<font color="#f00">`hexo new hello`</font>命令创建一篇为hello文章，Hexo会默认在_posts目录下给你创建一个名为hello.md的文件。假如你将<font color="#f00">`new_post_name`</font>改为了:<font color="#f00">`year-:month-:day-:title.md`</font>，那么hexo就自动帮你创建名为2015-12-23-hello.md（当前日期为2015年12月23）
* <font color="#f00">`:title`</font> 文章标题
* <font color="#f00">`:year`</font> 创建年份
* <font color="#f00">`:month`</font> 月份，如4月为04
* <font color="#f00">`:day`</font> 日期
* <font color="#f00">`i_month`</font> 月份，单数字，比如4月就是4
* <font color="#f00">`i_day`</font> 同上

（3）Drafts草稿

Hexo提供草稿功能，在<font color="#f00">`_drafts`</font>目录下的文章不会发表到网站上，你可以通过命令<font color="#f00">`hexo publish [layout] <title>`</font>发布你的草稿，改命令会将文章移到<font color="#f00">`_posts`</font>目录下。但是也可以设置<font color="#f00">`_config.yml`</font>配置文件的<font color="#f00">`render_drafts`</font>字段，使草稿默认发布到站点中。

（4）Scaffolds模版

当你使用<font color="#f00">`new`</font>命令创建一篇文章的时候，Hexo会根据scaffolds目录中的模版帮你生成文章。假如执行<font color="#f00">`hexo new photo "My Gallery"`</font>，Hexo会尝试在scaffolds目录中去寻找photo.md的模版文件，然后基于它创建标题为My Gallery的文章。

它的用处就是能够在模版中写入你某一类文章都要添加的共同内容，这样你基于模版创建文章的时候，就不用再重复写入那部分内容。

2. 前置声明
-----------
顾名思义，就是写在文章前面的一块内容，为了对文章进行某些设置。它有两种书写方式：

1. YAML方式，以三短线结束
{% codeblock YAML lang:yaml %}
title: Hello World
date: 2015/12/23 20:46:25
---
{% endcodeblock %}
2. JSON方式，以三分号结束
{% codeblock JSON lang:json %}
"title": "Hello World",
"date": "2013/7/13 20:46:25"
;;;
{% endcodeblock %}

下面看看有哪些参数可以设定：

* <font color="#f00">`layout`</font> 布局，一般不用写，默认就行
* <font color="#f00">`title`</font> 标题，这个必须要有
* <font color="#f00">`date`</font> 时间
* <font color="#f00">`updated`</font> 修改时间
* <font color="#f00">`comments`</font> 是否开启评论，默认为true
* <font color="#f00">`tags`</font> 文章标签
* <font color="#f00">`categories`</font> 文章分类
* <font color="#f00">`permalink`</font> 文章永久链接，一般不用写，默认就行
在写标签和分类的时候，可能会有多个的情况，多个标签可以无序排列的方式书写，而分类可能会有多级分类的情况。如何书写举例如下：

{% codeblock YAML lang:yaml %}
categories: 
- Sports
- Baseball
tags:
- Injury
- Fight
- Shocking
{% endcodeblock %}

3. 标签插件
-----------
这里说的标签插件不同于文章中的标签，它可以帮助你在文章中快速嵌入一些特殊的内容。

（1）Block Quote-块引用

插入带有作者信息的应用，体现在Html上就是在<font color="#f00">`blockquote`</font>标签下加入了<font color="#f00">`footer`</font>标签。但是会给文章带来不一样的显示效果，书写格式非常简单。

{% img /images/blockquote.png %}

看下面的例子就大概知道怎么书写了，第一种最简单的方式就等于markdown里的<font color="#f00">` > `</font>语句。
{% img /images/blockquote_demo.png %}
显示效果为（主题为light-ch）：
{% img /images/blockquote_demo1.png %}
（2）Code Block代码块

在文章中插入代码块可以使用下面方式书写
{% img /images/codeblock.png %}
同样举个例子，用法一目了然。
{% img /images/codeblockdemo.png %}
显示效果如下：
{% img /images/codeblockdemo1.png %}
（3）Pull Quote

这个插件可以帮助您在文章中插入重要引述。
{% img /images/pullquote.png %}
（4）jsFiddle

在文章中嵌入jsFiddle片段。
{% img /images/jsfiddle.png %}

（5）Gist

嵌入Gist片段
{% img /images/gist.png %}
（6）iFrame

插入网页框架
{% img /images/iframe.png %}
（7）Image

插入图片，可以自定义大小
{% img /images/image.png %}
（8）Link

插入带有target="_blank"属性值的链接。
{% img /images/link.png %}
（9）Include Code

从资源目录中插入代码片段。
{% img /images/include.png %}
（10）Youtube

在文章中插入Youtube视频。天朝的孩子就不用试了
{% img /images/youtube.png %}
（11）Vimeo

在文章中插入Vimeo视频。
{% img /images/vimeo.png %}
（12）Include Posts

包含其他文章的链接。
{% img /images/include_post.png %}
（13）Include Assets

包含文章资源。(具体怎么使用，还不太明白，后续再补充)
{% img /images/include_assets.png %}
（14）Raw

一些内容不想被主题渲染，可以使用该插件呈现原始状态。
{% img /images/raw.png %}