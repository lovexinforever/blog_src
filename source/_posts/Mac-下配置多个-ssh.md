---
title: Mac 下配置多个 ssh
date: 2017-09-12 15:51:23
updated: 2017-09-13 09:16:23
tags:
- mac
- ssh
categories:
- 技术
---
<img src="https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1505216036950&di=c1bfa3cd3158568e4ebaa0280b5cacf8&imgtype=0&src=http%3A%2F%2Fimg.hb.aicdn.com%2Fc70036ee95575d39ee6131a9757e19cb9a569c9f20f39-KFwh21_fw580" class="full-image" />

<blockquote class="blockquote-center"><h2>人的一切痛苦，本质上都是对自己无能的愤怒</h2></br>总有刁民想害朕</blockquote>

<!--more -->
### 我们每个人都有多个仓库来提交代码,工作中的和个人的.本篇文章就教你怎样管理多个 ssh 来提交代码.

查看 **.ssh** 文件夹下面的文件
-----------
一种是直接进入 .ssh 文件目录
> cd ~/.ssh

或者 直接查看 .ssh 文件夹
> ls ~/.ssh

<img src="http://obqo5zeui.bkt.clouddn.com/QQ20170912-170511@2x.png" />
生成一个SSH-Key
-----------
> ssh-keygen -t rsa -C "tim_ding@qq.com"

<img src="http://obqo5zeui.bkt.clouddn.com/QQ20170912-174951@2x.png" />
如果 .ssh 文件下已经有文件了 ,最好重新命名
密码建议填空

成功生成 SSH-KEY
-----------
<img src="http://obqo5zeui.bkt.clouddn.com/QQ20170912-175312@2x.png" />

配置 SSH-KEY
-----------
在~/.ssh/目录下会生成id-rsa_hostname和id-rsa_hostname.pub私钥和公钥。 我们将id-rsa_hostname.pub中的内容粘帖到服务器的SSH-key的配置中。
> cat ~/.ssh/github_blog_rsa.pub

<img src="http://obqo5zeui.bkt.clouddn.com/QQ20170913-085838@2x.png" />
在GitHub的设置中粘贴公钥
<img src="http://obqo5zeui.bkt.clouddn.com/QQ20170913-090143@2x.png" />

至此, ssh 就配置完成了.
验证配置是否成功
-----------
> ssh -T git@github.com

笔者出现了如下错误
<img src="http://obqo5zeui.bkt.clouddn.com/QQ20170913-090537@2x.png" />
那是因为目录下有多个 ssh, 需要配置 config

打开 config 文件
-----------
> vim ~/.ssh/config

<img src="http://obqo5zeui.bkt.clouddn.com/QQ20170913-090743@2x.png" />
添加如下
>  Host github.com
   HostName github.com
   User timding
   IdentityFile ~/.ssh/github_blog_rsa

然后保存.再执行 `ssh -T git@github.com` 就成功了.






