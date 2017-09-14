---
title: CSS实现单行、多行文本溢出显示省略号（…）
date: 2017-09-14 17:00:00
tags:
- CSS3
- CSS
- HTML5
- 单行显示
categories:
- 技术
- HTML5
- CSS3
---
如果实现单行文本的溢出显示省略号同学们应该都知道用text-overflow:ellipsis属性来，当然还需要加宽度width属来兼容部分浏览。
<!--more-->
单行显示
----------
### 实现方法
```
 .singer {
            overflow: hidden;
            text-overflow: ellipsis;
            white-space: nowrap;
        }
```
### 效果如图
<img src="http://obqo5zeui.bkt.clouddn.com/QQ20170914-170831@2x.png" />

但是这个属性只支持单行文本的溢出显示省略号，如果我们要实现多行文本溢出显示省略号呢。

多行显示
----------
### 实现方法
```
 .multiline {
            margin-top: 20px;
            display: -webkit-box;
            -webkit-box-orient: vertical;
            -webkit-line-clamp: 3;
            overflow: hidden;
            width: 300px;
        }
```
### 效果如图
<img src="http://obqo5zeui.bkt.clouddn.com/QQ20170914-171043@2x.png" />


<a href="https://github.com/lovexinforever/blog_demo/tree/master/css%E4%B8%80%E8%A1%8C%E6%88%96%E5%A4%9A%E8%A1%8C%E6%98%BE%E7%A4%BA">代码下载</a>
