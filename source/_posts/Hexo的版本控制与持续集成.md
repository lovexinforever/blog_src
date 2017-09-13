---
title: Hexo的版本控制与持续集成
date: 2017-09-13 13:35:06
top: 3
tags:
- 持续集成
- 版本管理
- CI
- AppVeyor
- Git
categories:
- 技术
---
<img src="https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1505296567323&di=32e77172fa0656b500322d1f88a02925&imgtype=0&src=http%3A%2F%2Fimgsrc.baidu.com%2Fimage%2Fc0%253Dshijue1%252C0%252C0%252C294%252C40%2Fsign%3D4c3b2306ba51f819e5280b09b2dd2098%2F8718367adab44aed5b5a1bc9b91c8701a18bfb83.jpg" class="full-image" />

<blockquote class="blockquote-center"><h2>人生并不像火车要通过每个站似的经过每一个生活阶段。人生总是直向前行走，从不留下什么。</h2></br>—— 刘易斯</blockquote>
<!--more-->
想必很多人会把Hexo生成出来的静态网站放到GitHub Pages来进行托管。一般发布Hexo博客的流程是，首先在本地搭建Hexo的环境，编写新文章，然后利用`hexo deploy`来发布到Git。那么对于本地的Hexo的原始文件怎么管理呢？如果换电脑了怎么办？如果没有对原始文件进行备份，突然有一天你的本地环境挂了导致源文件丢失，那不就呵呵了。也许你会想到用Dropbox或者其他方案来对源文件进行备份，但是每次更新完博客，需要备份好源文件，然后执行`hexo deploy`进行发布，是不是很麻烦？换了电脑之后又要重新搭建本地环境，是不是很蛋疼？
那么接下来我们就来说说如何优雅愉快地对我们的Hexo进行版本管理和发布。
既然我们已经用了GitHub来托管我们生成出来的静态网站，那么为什么不也把Hexo博客的源文件也host在GitHub上呢。那么问题来了，如果我们把Hexo博客的源文件托管在GitHub上，我们的发布流程就会变为：
- 执行`git push`把更新的源文件push到托管源文件的GitHub Repo (我们称之为Source Repo)
- 执行`hexo deploy`来更新托管静态网站的GitHub Pages (我们称之为Content Repo)

这样看来，每次更新博客要经历两个步骤，并不是那么straightforward。那么有没有办法做到既能使用GitHub进行版本控制，又能做到一键发布呢？
答案是肯定的。这里用到了<a href="https://en.wikipedia.org/wiki/Continuous_integration" >持续集成</a>也就是我们一直所说的CI来完成一键发布：当有新的change push到Source Repo时，自动执行CI脚本，生成最新的静态网站发布到Content Repo，一气呵成。那么我使用什么CI工具来做呢？我们可以使用像Travis CI这样的Hosted CI Service，也可以使用Jenkins或者TeamCity来搭建CI server。如果自己来搭建CI Server，费时费力，又要花钱来买Server来host CI service，肯定不是一个很好的选择。那么我们选哪个Hosted CI Service呢？其实今年在公司的一个项目中我们就选择了`AppVeyor`。当初在做investigation的时候，第一个想到的就是用Travis CI，访问<a href="https://www.appveyor.com/">AppVeyor官网</a>，映入眼帘的大标题就是#1 Continuous Delivery service for Windows。刚开始的时候内心一阵嘲笑，Top 10的CI Service就你支持Windows，你不是第一那谁是第一？结果在之后的项目使用中，发现AppVeyor比Travis CI好用太多。这里就不具体展开了，继续进入正题。
使用AppVeyor来建立CI非常方便，主要是以下步骤：

注册并登陆 AppVeyor
-----------
访问<a href="https://ci.appveyor.com/login" >AppVeyor登陆页面</a>，使用你的GitHub账号登陆即可。
<img src="http://obqo5zeui.bkt.clouddn.com/QQ20170913-152205@2x.png" />

添加 Project
----------
在AppVeyor Projects页面，添加相应的GitHub Source Repo。
<img src="http://obqo5zeui.bkt.clouddn.com/QQ20170913-152503@2x.png" />

添加appveyor.yml到Source Repo
----------
接下来，你需要把appveyor.yml添加到Source Repo的根目录下。具体的appveyor.yml如下.也可以参考我的博客
<a href = "https://github.com/lovexinforever/blog_src/blob/master/appveyor.yml">AppVeyor.yml</a>

你唯一需要做的就是替换[Your GitHub Access Token]，关于生成Access Token，可以参考这篇<a href="https://help.github.com/articles/creating-a-personal-access-token-for-the-command-line/">文章</a>。在GitHub生成好Access Token之后，你需要到AppVeyor加密页面把<a href="https://ci.appveyor.com/tools/encrypt">Access Token加密</a>之后再替换[Your GitHub Access Token]

设置Appveyor
----------
添加好appveyor.yml之后，再到Appveyor portal设置以下四个变量。STATIC_SITE_REPO就是Content Repo的地址，TARGET_BRANCH就是你Content Repo的branch，一般默认就是master，GIT_USER_EMAIL和GIT_USER_NAME就是你GitHub账号的信息。

### 好了，一切大功告成！试一下git push你的change到Source Repo，几分钟内，你的博客就自动更新了！
背后的过程如下:
- Git push to Source Repo
- AppVeyor CI
- Update GitHub Pages Content Repo
- Generate your Hexo blog site

谢谢!
