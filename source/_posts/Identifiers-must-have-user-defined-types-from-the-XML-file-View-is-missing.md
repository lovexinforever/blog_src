---
title: Identifiers must have user defined types from the XML file. View is missing
date: 2018-05-17 13:13:56
tags:
- android
- databinding
categories:
- 技术
- Android
---

做项目的时候,用 databinding, 遇到这么个错误
```
FAILURE: Build failed with an exception.

* What went wrong:
Execution failed for task ':mpos-cashier:compileIntegrateJavaWithJavac'.
> java.lang.RuntimeException: Found data binding errors.
  ****/ data binding error ****msg:Identifiers must have user defined types from the XML file. View is missing it file:/Users/dingyang/tim/cfs/git/develop_smartpos/mpos-cashier/src/main/res/layout/activity_home.xml loc:54:65 - 54:68 ****\ data binding error ****
```
<!-- more -->

错误原因是 xml 中没有引用 view 这个方法.
在 xml 的 `layout>data`下面引入
```
<import type="android.view.View"
```

