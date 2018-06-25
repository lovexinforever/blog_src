---
title: 'Could not find common.jar (android.arch.core:common:1.1.0)'
date: 2018-05-29 10:28:32
tags:
- android
categories:
- Technology
- Journal
- Android
---

android studio build 报错 `Could not find common.jar (android.arch.core:common:1.1.0)`

解决办法.

打开 root build.gradle

`Add maven { url 'https://maven.google.com' } before jcenter()` in
```
allprojects {
    repositories {
        jcenter()
    }
}
```
