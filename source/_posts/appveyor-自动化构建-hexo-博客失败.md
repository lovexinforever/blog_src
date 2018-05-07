---
title: appveyor 自动化构建 hexo 博客失败
date: 2018-05-07 12:38:37
tags:
- 持续集成
- 版本管理
- CI
- AppVeyor
categories:
- 技术
---
因为之前是 appveyor 来自动构建我的博客的.至于怎么用  appveyor 构建 hexo 博客,可以移步<a href="https://timding.top/2017/09/13/Hexo%E7%9A%84%E7%89%88%E6%9C%AC%E6%8E%A7%E5%88%B6%E4%B8%8E%E6%8C%81%E7%BB%AD%E9%9B%86%E6%88%90">Hexo的版本控制与持续集成</a>
    <!--more-->
今天突然发现更的博客和相册没有在网站上面发现更新.就去 appveyor. 一看才知道 构建失败了.
错误日志

```
Build started
git clone -q --depth=5 --branch=master https://github.com/lovexinforever/blog_src.git C:\projects\blog-src
git checkout -qf 5b6eaa0b3536784eb24fc766ae22cf0e9f2da1fc
Running Install scripts
node --version
v4.8.7
npm --version
2.15.11
npm install
> fsevents@1.2.3 install C:\projects\blog-src\node_modules\fsevents
> node install
> nunjucks@3.1.2 postinstall C:\projects\blog-src\node_modules\nunjucks
> node postinstall-build.js src
npm install hexo-cli -g
npm WARN engine hexo-fs@0.2.3: wanted: {"node":">=6.9.0"} (current: {"node":"4.8.7","npm":"2.15.11"})
npm WARN optional dep failed, continuing fsevents@1.2.3
C:\Users\appveyor\AppData\Roaming\npm\hexo -> C:\Users\appveyor\AppData\Roaming\npm\node_modules\hexo-cli\bin\hexo
hexo-cli@1.1.0 C:\Users\appveyor\AppData\Roaming\npm\node_modules\hexo-cli
├── abbrev@1.1.1
├── object-assign@4.1.1
├── command-exists@1.2.6
├── minimist@1.2.0
├── tildify@1.2.0 (os-homedir@1.0.2)
├── chalk@1.1.3 (escape-string-regexp@1.0.5, supports-color@2.0.0, ansi-styles@2.2.1, strip-ansi@3.0.1, has-ansi@2.0.0)
├── bluebird@3.5.1
├── resolve@1.7.1 (path-parse@1.0.5)
├── hexo-fs@0.2.3 (escape-string-regexp@1.0.5, graceful-fs@4.1.11, chokidar@1.7.0)
├── hexo-util@0.6.3 (html-entities@1.2.1, striptags@2.2.1, camel-case@3.0.0, cross-spawn@4.0.2, highlight.js@9.12.0)
└── hexo-log@0.2.0 (hexo-bunyan@1.0.0)
npm install hexo -save
npm WARN engine hexo@3.7.1: wanted: {"node":">=6.9.0"} (current: {"node":"4.8.7","npm":"2.15.11"})
hexo@3.7.1 node_modules\hexo
└── hexo-cli@1.1.0 (chalk@1.1.3)
npm install hexo-wordcount@2 --save
hexo-wordcount@2.0.1 node_modules\hexo-wordcount
npm install hexo-generator-sitemap --save
hexo-generator-sitemap@1.2.0 node_modules\hexo-generator-sitemap
└── nunjucks@2.5.2
npm install hexo-generator-baidu-sitemap --save
npm WARN deprecated ejs@1.0.0: Critical security bugs fixed in 2.5.5
hexo-generator-baidu-sitemap@0.1.2 node_modules\hexo-generator-baidu-sitemap
├── hexo-generator-baidu-sitemap@0.0.8
└── ejs@1.0.0
npm install hexo-generator-searchdb --save
npm WARN deprecated ejs@1.0.0: Critical security bugs fixed in 2.5.5
hexo-generator-searchdb@1.0.8 node_modules\hexo-generator-searchdb
├── striptags@3.1.1
└── ejs@1.0.0
hexo generate
ERROR Local hexo not found in C:\projects\blog-src
ERROR Try running: 'npm install hexo --save'
Command exited with code 2
```
刚开始以为要执行
```
npm install hexo --save
```
结果发现还是不行
就仔细看了日志,发现
```
npm WARN engine hexo@3.7.1: wanted: {"node":">=6.9.0"} (current: {"node":"4.8.7","npm":"2.15.11"})
```
原来是 版本升级问题, 是 hexo 的版本要 node.js>=6的.
于是就升级了  appveyor.yml.
```
environment:
    nodejs_version: "6"
```
在 environment 下面增加 nodejs 版本
```
install:
    - ps: Install-Product node $env:nodejs_version
```
在 install 第一行添加如上代码.

然后重新构建就 ok 了