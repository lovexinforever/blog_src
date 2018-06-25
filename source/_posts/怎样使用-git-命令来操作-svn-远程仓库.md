---
title: 怎样使用 git 命令来操作 svn 远程仓库
date: 2018-05-28 13:18:09
tags:
- git
- svn
categories:
- Technology
- Git
---
之前因为转组,这个组用 `svn` 管理代码,并没有 `git` + `gerrit`来管理代码.由于习惯了使用 git, 所以就使用 `git svn` 命令来使用 git 命令管理 svn 仓库.
<!-- more -->
### 查看 svn 代码结构
```
project
   |___branches
   |___tags
   |___trunk
```
这是我项目的 svn 结构. trunk 是源码, tags 是项目打的 tag, branches 是项目的分支.

### clone 命令

```
git svn clone -r 1394873:HEAD http://svn.99bill.net/opt/99billsrc/PMD/Branches/MOB/Android/app-SmartPOS2.0  --username yang.ding@99bill.com --trunk "trunk" --tag "tags" --branch "branches" develop_smartpos
```

其中 -r 1394873  是 svn 中你需要 clone 的起始 commit.

###  使用命令

`git svn fetch`  拉去远程代码

`git svn rebase` 合并远程代码

`git svn dcommit` 提交代码

`git svn tags 'des'` 打远程 tag

`git svn branches 'branches'` 创建远程分支

其他的本地 branches 切换 创建 branches 和 git 命令一样. 主要就是和远程 repo 操作需要用到 git svn 命令.

### 效果

使用 `gitk --all` 查看 repo.

<img src="https://raw.githubusercontent.com/lovexinforever/blog_back_up/master/blog_photos/QQ20180528-142024%402x.png">

### QA
Q:如果我在 origin branch a 有个 commit 想提交到 origin branch b, 怎么提交

A:使用 git checkout 切换到 origin branch b, 然后把 commit cherry-pick 过来,再执行 git svn dcommit. 