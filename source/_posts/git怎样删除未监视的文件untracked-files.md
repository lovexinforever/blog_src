---
title: git怎样删除未监视的文件untracked files
date: 2017-10-31 14:49:51
tags:
- git
- untracked
categories:
- Technology
- Git
---

使用 git 中  经常需要还原文件.
<!--more-->

如果是文件是 untracked files.
则我们用 git clean 来还原
```
# 删除 untracked files
git clean -f
 
# 连 untracked 的目录也一起删掉
git clean -fd
 
# 连 gitignore 的untrack 文件/目录也一起删掉 （慎用，一般这个是用来删掉编译出来的 .o之类的文件用的）
git clean -xfd
 
# 在用上述 git clean 前，墙裂建议加上 -n 参数来先看看会删掉哪些文件，防止重要文件被误删
git clean -nxfd
git clean -nf
git clean -nfd
```

如果文件是 tracked files
则我们用 git checkout来还原
```
#还原指定文件
git checkout files

#全部还原
git checkout .

```
