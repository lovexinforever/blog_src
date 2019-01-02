---
title: Mac上用geektool显示最近最近五天的天气(进阶版 根据 ip 位置来显示对应地理位置的天气)
date: 2018-12-31 12:04:20
tags:
- python
- geektool
- 天气
- beautifulsoup
categories:
- Technology
- Python
essential: true
top: 9
photos:
- https://raw.githubusercontent.com/lovexinforever/blog_back_up/master/photos/2018-5-25_%E5%A4%96%E6%98%9F%E4%BA%BA.jpeg
- https://raw.githubusercontent.com/lovexinforever/blog_back_up/master/photos/2018-5-28_%E5%BF%83%E5%BD%A2%E6%B9%96.jpeg
---
前面两篇文章<a href="https://timding.top/2018/04/19/Geektool-%E4%BD%BF%E7%94%A8-python-%E6%8A%93%E5%8F%96%E5%A4%A9%E6%B0%94%E6%98%BE%E7%A4%BA/">Geektool 使用 python+beautifulsoup 抓取天气显示</a>和<a href="https://timding.top/2018/04/20/Geektool-%E4%BD%BF%E7%94%A8-python-beautiful-%E5%AE%9E%E7%8E%B0%E6%8A%93%E5%8F%96%E5%A4%A9%E6%B0%94%E5%9B%BE%E6%A0%87/">Geektool 使用 python + beautiful 实现抓取天气图标</a> 讲解了怎样用 `python` + `geektool`来抓取天气网站信息来显示.这篇文章主要来说明怎样根据 ip 来显示地理位置的最近五天的天气.
<!-- more -->
## 效果
老规矩 先看最终效果图
![南京](https://raw.githubusercontent.com/lovexinforever/blog_back_up/master/blog_photos/WX20181231-113445%402x.png)
![广州](https://raw.githubusercontent.com/lovexinforever/blog_back_up/master/blog_photos/WX20181231-113649%402x.png)

## 设计思路
- 获取所处的外网 ip
- 根据外网 ip 获取地理位置名称
- 设计字典, 根据地理位置来获取天气的 key,
- 拼接天气 url 来获取当前 ip 的地理位置的天气.

## 获取外网所在的 ip
浏览器打开地址 `http://ip.42.pl/raw`, 可以看到当前的外网 ip.直接解析.
```
def get_ip():
    url='http://ip.42.pl/raw'
    head={}
    head['User-Agent']='Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_2) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/71.0.3578.98 Safari/537.36'
    req=urllib2.Request(url,headers=head)
    ip = urllib2.urlopen(req).read();
    return ip
```

## 根据 ip 获取所处的地理位置
```
def queryIpAddress(ipaddress):
    url='https://ip.cn/index.php?ip='+ipaddress
    head={}
    head['User-Agent']='Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_2) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/71.0.3578.98 Safari/537.36'
    req=urllib2.Request(url,headers=head)
    reaponse = urllib2.urlopen(req);
    soup=BeautifulSoup(reaponse,'html.parser');
    a = soup.find('div', attrs={'class': 'well'})
    b = a.find_all('p')[1].find('code').get_text();
    address = b.split(' ')[0]
    return address
```

## 创建城市字典
由于常年呆在南京, 就只写了几个城市码, 如果没有你所在的城市, 自己去创建下
```
{
	"江苏省南京市": "5ef652409badc75c97292b401c6db8e8e55a3157f300dc0997bea96343e4a20a",
	"广东省珠海市": "ba75fa9fa1fb4e2709d1c5a015354ac188cc2a50902610a80f9d28dce8eb8e40",
	"广东省广州市": "8531a23947fdad24dcfb9cd37e6d6bd77617fa7c8b242e4773c74381cf55845b"
}
```

## 根据城市名字获取城市的天气 key
因为我在南京,所以如果没有取到 key 的话, 我会默认给南京的 key
```
def queryCode(key):
    f = open("/Users/dingyang/python/geektool/city.json")
    origin = json.load(f);
    if(key in origin):
        # 获取城市编码
        code = origin[key];
    # 如果城市编码为空, 默认给南京编码
    else:
        code = "5ef652409badc75c97292b401c6db8e8e55a3157f300dc0997bea96343e4a20a"
    return code;
```
## 根据返回的key, 组装 url,获取天气展示.

```
def getDate():
    addr = address.queryIpAddress(address.get_ip())
    code = city.queryCode(addr)
    url = "https://weather.com/zh-CN/weather/5day/l/"+code
    respFive=urllib.urlopen(url);
    
    soupFive=BeautifulSoup(respFive,'html.parser');
    
    # 最近五天
    fives=soupFive.find_all('tr',attrs={'class':'clickable'});
    week=fives[1].find_all('td',attrs={'class':'twc-sticky-col'})[1];

    weekDate=week.find('span',attrs={'class':'day-detail'});
    return weekDate.get_text();
```

## geektool 输出信息.
用 geektool 输出天气信息,然后自己调整样式.
