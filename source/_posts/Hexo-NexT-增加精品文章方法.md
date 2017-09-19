---
title: Hexo+NexT 增加精品文章方法
date: 2017-09-19 17:09:10
tags:
- Hexo
- NexT
- 相册
- Photo
categories:
- 技术
- Hexo
essential: true
---

捣鼓了一下 置顶方法,又想折腾精品文章.和置顶方法类似.
<!--more-->
精品 style
----------
首先增加精品的样式文件.
在next 主题下面的 post.swig 找到如下代码.
```
{% if theme.post_wordcount.wordcount or theme.post_wordcount.min2read %}
    <div class="post-wordcount">
        {% if theme.post_wordcount.wordcount %}
        {% if not theme.post_wordcount.separated_meta %}
            <span class="post-meta-divider">|</span>
        {% endif %}
        <span class="post-meta-item-icon">
            <i class="fa fa-file-word-o"></i>
        </span>
        {% if theme.post_wordcount.item_text %}
            <span class="post-meta-item-text">{{ __('post.wordcount') }}&#58;</span>
        {% endif %}
        <span title="{{ __('post.wordcount') }}">
            {{ wordcount(post.content) }}
        </span>
        {% endif %}

        {% if theme.post_wordcount.wordcount and theme.post_wordcount.min2read %}
        <span class="post-meta-divider">|</span>
        {% endif %}

        {% if theme.post_wordcount.min2read %}
        <span class="post-meta-item-icon">
            <i class="fa fa-clock-o"></i>
        </span>
        {% if theme.post_wordcount.item_text %}
            <span class="post-meta-item-text">{{ __('post.min2read') }} &asymp;</span>
        {% endif %}
        <span title="{{ __('post.min2read') }}">
            {{ min2read(post.content) }}
        </span>
        {% endif %}
    </div>
    {% endif %}
```
在后面添加以下代码

```
{% if post.top %}
    <span class="post-meta-item-icon">
            <i class="fa fa-thumb-tack zhidingtop">置顶</i>
        </span>
    
    {% endif %}
    {% if post.top&&post.essential %}
    <span class="post-meta-divider">|</span>
    {% endif %}
    {% if post.essential%}
    <span class="post-meta-item-icon">
            <i class="fa fa-newspaper-o jingping">精品</i>
    </span>
    
{% endif %}
```

增加 `jingping` css 样式
----------
```
.jingping{
  background : #00a8c3;
  padding:2px 4px 2px 4px;
  color: #fff;
}
```

到此就完成了精品的设置.只要在文章的 md 文件中 加入如下代码
```
essential: true
```
就能看到设置的精品文章了

效果
----------
<img src="http://obqo5zeui.bkt.clouddn.com/QQ20170919-171922@2x.png" />