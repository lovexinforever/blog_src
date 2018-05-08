---
title: Geektool 使用 python+beautifulsoup 抓取天气显示
date: 2018-04-19 19:14:32
tags:
- python
- geektool
- 天气
- beautifulsoup
categories:
- 技术
- Python
essential: true
---
<img src="https://raw.githubusercontent.com/lovexinforever/blog_back_up/master/photos/2018-4-19_%E6%B1%BD%E8%BD%A6.jpeg" />
闲来无事,就想着捣鼓捣鼓电脑,想在电脑桌面实时显示天气状况.就用 geektool + python + beautifulsoup 写了一个抓取天气网站的脚本来显示.
<!--more-->

效果
----------
先看实现出来的效果
<img src="https://raw.githubusercontent.com/lovexinforever/blog_back_up/master/blog_photos/QQ20180420-091325%402x.png" class="full-image">

实现思路
----------
用 python 去爬取天气网站的内容,解析抓取到的内容,提取今日的温度信息和天气天气,然后显示在 geektool 上面

天气网站
----------
我这边选用的是 <a href="https://weather.com/">weather channel</a>
在网站里面把地址切换到你想抓取的地区.
<img src="https://raw.githubusercontent.com/lovexinforever/blog_back_up/master/blog_photos/QQ20180420-095735%402x.png" class="full-image">
如图,可以看到实时温度现在
```
<div class="today_nowcard-temp"><span class="">25<sup>°</sup></span></div>
```
所以我们只要抓取 class为 `today_nowcard-temp`的标签,获取标签下面的文本内容 就是我们想要的温度信息.
同理天气状况  只要抓取
```
<div class="today_nowcard-phrase">晴朗</div>
```
的内容

准备开发
----------
使用  `beautifulsoup` 去抓取页面内容.所以我们需要安装.由于 geektool 使用python 的版本是 2.7.10的.所以我们要在 python2.7里面安装 beautifulsoup.
安装命令
```
python -m pip install beautifulsoup4
```
然后查看有没有安装成功
```
python -m pip list
```
如果有显示 beautifulsoup4的包就是安装成功了.如果没有的话就没有安装成功.

如果你那么不幸运没有安装成功.就只能去 <a href="https://www.crummy.com/software/BeautifulSoup/bs4/download/4.0/"> beautifulsoup download</a> 去下载源码.
然后切换到beautifulsoup的setup.py 的命令目录
执行
```
python setup.py build
python setup.py install
```
执行成功后
在查看安装的包,就看到安装成功了.

执行脚本
----------
```
#!/usr/bin/env python
#-*- coding: UTF-8 -*-  
import sys
reload(sys)
sys.setdefaultencoding('utf-8')
import urllib
import os
from bs4 import BeautifulSoup
import re
if __name__ == '__main__':
	resp=urllib.urlopen('https://weather.com/zh-CN/weather/today/l/5ef652409badc75c97292b401c6db8e8e55a3157f300dc0997bea96343e4a20a')
	soup=BeautifulSoup(resp,'html.parser')
	tagToday=soup.find('div',attrs={'class':'today_nowcard-temp'})
	print(tagToday.span.get_text())
```
可以看到 geektool 输出温度信息了,然后在 geektool 里面修改样式就好了
天气信息同理

