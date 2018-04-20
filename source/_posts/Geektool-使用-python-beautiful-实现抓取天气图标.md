---
title: Geektool 使用 python + beautiful 实现抓取天气图标
date: 2018-04-20 15:36:36
tags:
- python
- geektool
- 天气
- beautifulsoup
categories:
- 技术
- Python
top: 7
essential: true
---
<img src="https://raw.githubusercontent.com/lovexinforever/blog_back_up/master/blog_photos/WechatIMG1.jpeg" class="full-image"/>
上篇文章 <a href="https://lovexinforever.github.io/2018/04/19/Geektool-%E4%BD%BF%E7%94%A8-python-%E6%8A%93%E5%8F%96%E5%A4%A9%E6%B0%94%E6%98%BE%E7%A4%BA/">Geektool 使用 python+beautifulsoup 抓取天气显示</a> 讲解了怎样爬取天气网站的天气.但是界面上显示宗师感觉不好看,想显示天气的图标,翻看了几个天气网站,并没有我满意的天气图标.于是就打算自己去做一个了.
<!--more-->

开发思路
----------
首先上篇文章已经爬取到天气状态如晴朗,局部多云等. 由于也是刚刚弄,并不知道天气状态到底对应几个.目前也只是遇到三种,后面遇到的话再加下逻辑.然后根据天气状态下载对应的天气图标到计算机本地目录,最后用 geektool 显示本地图片.

脚本
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
	tagToday=soup.find('div',attrs={'class':'today_nowcard-phrase'})
	url=''
	if "晴朗" == tagToday.get_text():
		url='https://raw.githubusercontent.com/lovexinforever/blog_back_up/master/blog_photos/20101027235021742.png'
	elif "局部多云" == tagToday.get_text():
		url='https://raw.githubusercontent.com/lovexinforever/blog_back_up/master/blog_photos/20101027235020501.png'
	elif "大部多云" == tagToday.get_text():
		url='https://raw.githubusercontent.com/lovexinforever/blog_back_up/master/blog_photos/20101027235019364.png'
	else:
		url='https://raw.githubusercontent.com/lovexinforever/blog_back_up/master/blog_photos/20101027235020136.png'
	urllib.urlretrieve(url, '/tmp/weather.png')
	print(tagToday.get_text())
```
url 对应相应状态的 天气图标地址.目前我只遇到过这三种,后面遇到其他的再添加对应的状态.

相应的天气图标可以在我的 github 上面下载. <a href="https://github.com/lovexinforever/blog_back_up/tree/master/blog_photos">天气图标</a>