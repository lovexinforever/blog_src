---
title: hexo + Next 怎样添加推广广告链接
date: 2018-06-11 16:09:23
tags:
- Hexo
- NexT
- 广告
categroies:
- Technology
- Hexo
top: 8
essential: true
photos: 
- https://raw.githubusercontent.com/lovexinforever/blog_back_up/master/photos/2017-10-17_%E6%88%98%E5%A3%AB%E5%9F%8E%E5%A0%A1.jpg
- https://raw.githubusercontent.com/lovexinforever/blog_back_up/master/photos/2017-10-17_%E9%B9%B0.jpg
---
闲来无事,捣鼓捣鼓博客,想加入推广链接
<!-- more -->
### 添加广告链接

在 hexo 的 root 下的`_config.yml` 添加博客链接
```
##  自定义广告
advert:
  天猫618: https://gw.alicdn.com/tfs/TB1p12MsQ9WBuNjSspeXXaz5VXa-440-180.jpg || https://s.click.taobao.com/t?e=m%3D2%26s%3DQ7%2BOxHRJNU8cQipKwQzePCperVdZeJviK7Vc7tFgwiFRAdhuF14FMSjJriMKVvzd5x%2BIUlGKNpUKzRB5pSb%2B3oLgBNn%2Fh8Y9fs5VlYBlFz5kblEZQzGoFcs%2Fhc73tO6KVYo%2BqyT%2FBa1NrKwvDJNPXkIGbLNY5ut4zueC0P1cNS9iw0%2FdWyiVaogaseAKBk0cTbU9KzMTtxpe7auY0HPYWszlTEcWhO9mCmht7GX%2FH9k%3D
  2018年618理想生活狂欢季——聚划算主会场: https://img.alicdn.com/tfs/TB125UMsMmTBuNjy1XbXXaMrVXa-440-180.jpg || https://s.click.taobao.com/t?e=m%3D2%26s%3D2c9N%2F89tPiMcQipKwQzePCperVdZeJviK7Vc7tFgwiFRAdhuF14FMXJZeCVJPqDB8sviUM61dt0KzRB5pSb%2B3oLgBNn%2Fh8Y9fs5VlYBlFz5kblEZQzGoFcs%2Fhc73tO6KVYo%2BqyT%2FBa1NrKwvDJNPXkIGbLNY5ut4zueC0P1cNS%2B%2BUEclaRYva8F8WBkZipnv9sOkOOEWZ4E%2FnCA8IhtTQhnqXdg7YFDycSpj5qSCmbA%3D
  2018年618理想生活狂欢节—消费电子主会场: https://img.alicdn.com/tfs/TB1GnfasntYBeNjy1XdXXXXyVXa-440-180.jpg || https://s.click.taobao.com/t?e=m%3D2%26s%3D5xcD%2FIEjdhYcQipKwQzePCperVdZeJviK7Vc7tFgwiFRAdhuF14FMUG5eE0BPbCdxq3IhSJN6GQKzRB5pSb%2B3oLgBNn%2Fh8Y9fs5VlYBlFz5kblEZQzGoFcs%2Fhc73tO6KVYo%2BqyT%2FBa1NrKwvDJNPXkIGbLNY5ut4zueC0P1cNS%2B6zThPYvErzhJBFs1%2FyLxVPxey8%2Bhd8pyvTW5l3DCD30V92HL3DKLNSqwyt%2BH6DtO%2FMqT4SeHHMKTHNVRq3ENViYq%2BoOM2USF%2Bn%2B1pvicu6FXll1U39L8dNcwDbqGDeU3JefVee9XDEgxYVk%2BaFSeXxiXvDf8DaRs%3D
  2018年618理想生活狂欢季-天猫超市主会场: https://gw.alicdn.com/tfs/TB1a4MnsNGYBuNjy0FnXXX5lpXa-440-180.jpg || https://s.click.taobao.com/t?e=m%3D2%26s%3DR6DyZeS%2BGoYcQipKwQzePCperVdZeJviK7Vc7tFgwiFRAdhuF14FMc2RXWXrk1qW1aH1Hk3GeOgKzRB5pSb%2B3oLgBNn%2Fh8Y9fs5VlYBlFz5kblEZQzGoFcs%2Fhc73tO6KVYo%2BqyT%2FBa1NrKwvDJNPXkIGbLNY5ut4zueC0P1cNS%2B6zThPYvErzhJBFs1%2FyLxVPxey8%2Bhd8pxWH6t8RXhbUYrLrKJVVdmfmL0G1vzYK1gI0mywmx5qSsYMXU3NNCg%2F

```

### 添加广告插件
在 next 主题目录 `layout/_macro` 下面添加  `advert.swig`
```
{# Gallery support #}
      {% if config.advert %}
        <div class="post-gallery" itemscope itemtype="http://schema.org/ImageGallery">
          {% set COLUMN_NUMBER = 3 %}
          {% for advert, link in config.advert %}
            {% if loop.index0 % COLUMN_NUMBER === 0 %}<div class="post-gallery-row">{% endif %}
              <a class="post-gallery-img fancybox"
                 href="{{ link.split('||')[1] | trim }}" rel="gallery_{{ post._id }}" target="_blank"
                 itemscope itemtype="http://schema.org/ImageObject" itemprop="url">
                <img src="{{ link.split('||')[0] | trim }}" itemprop="contentUrl" alt="{{advert}}"/>
              </a>
            {% if loop.index0 % COLUMN_NUMBER === 2 %}</div>{% endif %}
          {% endfor %}

          {# Append end tag for `post-gallery-row` when (photos size mod COLUMN_NUMBER) is less than COLUMN_NUMBER #}
          {% if config.advert.length % COLUMN_NUMBER > 0 %}</div>{% endif %}
        </div>
      {% endif %}
```

### 使用插件
修改 next 主题目录 `layout/_macro` 下面的`post.swig`
找到下面这行代码
```
{% if theme.wechat_subscriber.enabled and not is_index %}
      <div>
        {% include 'wechat-subscriber.swig' %}
      </div>
    {% endif %}
```
在这段代码上面加入
```
{% if not is_index%}
    <div>
    {% include 'advert.swig' %}
    </div>
    {% endif %}
```

### 使用
需要更改广告的话,直接修改 root 下面的  `_config.yml` 的 advert.


