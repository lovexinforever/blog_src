---
title: js 正则判断是否是手机号
date: 2017-09-14 11:20:14
tags:
- js
- 正则
- 判断手机号
categories:
- Technology
---
做项目时,遇到手机号注册,需要判断用户输入是否为手机号,就写了段正则判断.
<!-- more -->

js 如下
```
function checkMobile(str) {
    var re = /^1\d{10}$/
    if (re.test(str)) {
        return true;
    } else {
        return false;
    }
}
```

