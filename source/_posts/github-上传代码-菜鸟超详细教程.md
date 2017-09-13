title: github 上传代码 菜鸟超详细教程
date: 2015-12-29 16:52:30
tags:
- git
- github
categories: 
- 技术
- 日志
---
### 由于最近需要把代码上传到github上,之前只是用来fork别人的代码.所以写了这篇文章.运行环境windows.
<!-- more -->
1. 当然需要有github账号,没有的话,请移步<a href="http://github.com"><font color="#ff0">Github</font></a>
2. 新建仓库
<img src="/imgs/blog7/img1.png"/>
图中红色部分都可以新建
3. 填写名称，简介（可选），勾选Initialize this repository with a README选项，这是自动创建REAMDE.md文件，省的你再创建.
<img src="/imgs/blog7/img2.png"/>
4. 用git shell 连接 github ssh.不会的话请移步<a href="http://timding.com/2015/12/25/%E8%AE%BE%E7%BD%AESSH-keys/#more"><font color="#ff0">设置ssh keys</font></a>
5. clone刚才新建的repository 到本地，输入命令：
<img src="/imgs/blog7/img3.png"/>
<font color="#f00">`git clone https://github.com/lovexinforever/blog.git`</font>
这时会在目录下生成：
<img src="/imgs/blog7/img4.png"/>
6. 将想上传的代码目录拷贝到此文件夹下：
<img src="/imgs/blog7/img5.png"/>
7. 切换到Git shell 命令行下，输入命令：

<font color="#f00">`git init`</font>
<font color="#f00">`git commit -m 'blog'`</font>
<font color="#f00">`git remote add origin https://github.com/lovexinforever/blog.git`</font>
<font color="#f00">`git push origin master`</font>
如果执行<font color="#f00">`git remote add origin https://github.com/lovexinforever/blog.git`</font>，出现错误：

　　<font color="#f00">`fatal: remote origin already exists`</font>
则执行以下语句：

　　<font color="#f00">`git remote rm origin`</font>
再往后执行<font color="#f00">`git remote add origin https://github.com/lovexinforever/blog.git`</font> 即可。

在执行<font color="#f00">`git push origin master`</font>时，报错：

　　<font color="#f00">`error:failed to push som refs to.......`</font>
则执行以下语句：

　　<font color="#f00">`git pull origin master`</font>
先把远程服务器github上面的文件拉先来，再push 上去。




</br>
</br>
</br>
至此,就把本地代码提交到远程github上了.  谢谢

   欢迎转载!!