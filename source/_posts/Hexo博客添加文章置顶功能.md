---
title: Hexo博客添加文章置顶功能
date: 2017-09-13 19:40:12
tags:
- hexo
- 置顶
categories: 
- 技术
---
原来用的WordPress，直接很方便地管理置顶文章，Hexo只提供了按发布日期的排序，只好网上找了些资料修改。

原理：在Hexo生成首页HTML时，将top值高的文章排在前面，达到置顶功能。
<!-- more -->
修改Hexo文件夹下的`node_modules/hexo-generator-index/lib/generator.js`，在生成文章之前进行文章top值排序。

需添加的代码：
```
posts.data = posts.data.sort(function(a, b) {
    if(a.top && b.top) { // 两篇文章top都有定义
        if(a.top == b.top) return b.date - a.date; // 若top值一样则按照文章日期降序排
        else return b.top - a.top; // 否则按照top值降序排
    }
    else if(a.top && !b.top) { // 以下是只有一篇文章top有定义，那么将有top的排在前面（这里用异或操作居然不行233）
        return -1;
    }
    else if(!a.top && b.top) {
        return 1;
    }
    else return b.date - a.date; // 都没定义按照文章日期降序排
});
```
修改完成后，只需要在`front-matter`中设置需要置顶文章的`top`值，将会根据`top`值大小来选择置顶顺序`top`值越大越靠前。需要注意的是，这个文件不是主题的一部分，也不是Git管理的，备份的时候比较容易忽略。

以下是最终的generator.js内容
```
'use strict';
var pagination = require('hexo-pagination');
module.exports = function(locals){
  var config = this.config;
  var posts = locals.posts;
    posts.data = posts.data.sort(function(a, b) {
        if(a.top && b.top) {
            if(a.top == b.top) return b.date - a.date;
            else return b.top - a.top;
        }
        else if(a.top && !b.top) {
            return -1;
        }
        else if(!a.top && b.top) {
            return 1;
        }
        else return b.date - a.date;
    });
  var paginationDir = config.pagination_dir || 'page';
  return pagination('', posts, {
    perPage: config.index_generator.per_page,
    layout: ['index', 'archive'],
    format: paginationDir + '/%d/',
    data: {
      __index: true
    }
  });
};
```