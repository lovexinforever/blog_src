---
title: Hexo+NexT 博客搭建相册(一)
date: 2017-09-18 10:40:02
tags:
- Hexo
- NexT
- 相册
- Photo
categories:
- 技术
- Hexo
top: 5
essential: true
---
<img src="http://pic.58pic.com/58pic/15/37/17/12n58PICyI3_1024.jpg" class="full-image" />
  用Hexo + NexT 搭建了博客之后,就想搭建一个相册.ps:真是瞎折腾!.自己上网查了些资料,摸索摸索,终于搭建好了.这里写个教程,由于东西比较多,教程分为两部分.
<!--more-->

实现想法
-----------
在 github 上面创建一个相册库,当有更新时,提交到 github 上面,同时在博客 resource 下面生成一个 data.json来生成所有相册文件的 json 文件,博客读取 data.json 来展示相册

创建相册库
-----------
在 github 上面创建一个仓库,命名为 `blog_back_up` (仓库名字随便). 用 `git clone` 把仓库 clone 到本地来.
> cd blog_back_up

创建 `photos` 和 `min_photos` 两个目录,把要上传的相册图片 放到 photos 文件夹下面.
> 相册图片命名方式 : `yyyy-MM-dd_des.jpg/png/jpef/gif`. eg: 2017-9-18_蝴蝶. jpg

处理图片
-----------
图片的处理 我用 python 脚本来处理,这样每次只要执行脚本就可以了.
- 裁剪图片
```
def cut_photo():
    """裁剪算法
    
    ----------
    调用Graphics类中的裁剪算法，将src_dir目录下的文件进行裁剪（裁剪成正方形）
    """
    src_dir = "photos/"
    if directory_exists(src_dir):
        if not directory_exists(src_dir):
            make_directory(src_dir)
        # business logic
        file_list = list_img_file(src_dir)
        # print file_list
        if file_list:
            print_help()
            for infile in file_list:
                img = Image.open(src_dir+infile)
                Graphics(infile=src_dir+infile, outfile=src_dir + infile).cut_by_ratio()            
        else:
            pass
    else:
        print("source directory not exist!")     

```

- 压缩图片
```
def compress_photo():
    '''调用压缩图片的函数
    '''
    src_dir, des_dir = "photos/", "min_photos/"
    
    if directory_exists(src_dir):
        if not directory_exists(src_dir):
            make_directory(src_dir)
        # business logic
        file_list_src = list_img_file(src_dir)
    if directory_exists(des_dir):
        if not directory_exists(des_dir):
            make_directory(des_dir)
        file_list_des = list_img_file(des_dir)
        # print file_list
    '''如果已经压缩了，就不再压缩'''
    for i in range(len(file_list_des)):
        if file_list_des[i] in file_list_src:
            file_list_src.remove(file_list_des[i])
    compress('4', des_dir, src_dir, file_list_src)
```

- 根据图片信息生成 json
```
def handle_photo():
    '''根据图片的文件名处理成需要的json格式的数据
    
    -----------
    最后将data.json文件存到博客的source/photos文件夹下
    '''
    src_dir, des_dir = "photos/", "min_photos/"
    file_list = list_img_file(src_dir)
    list_info = []
    for i in range(len(file_list)):
        filename = file_list[i]
        date_str, info = filename.split("_")
        info, _ = info.split(".")
        date = datetime.strptime(date_str, "%Y-%m-%d")
        year_month = date_str[0:7]            
        if i == 0:  # 处理第一个文件
            new_dict = {"date": year_month, "arr":{'year': date.year,
                                                                   'month': date.month,
                                                                   'link': [filename],
                                                                   'text': [info],
                                                                   'type': ['image']
                                                                   }
                                        } 
            list_info.append(new_dict)
        elif year_month != list_info[-1]['date']:  # 不是最后的一个日期，就新建一个dict
            new_dict = {"date": year_month, "arr":{'year': date.year,
                                                   'month': date.month,
                                                   'link': [filename],
                                                   'text': [info],
                                                   'type': ['image']
                                                   }
                        }
            list_info.append(new_dict)
        else:  # 同一个日期
            list_info[-1]['arr']['link'].append(filename)
            list_info[-1]['arr']['text'].append(info)
            list_info[-1]['arr']['type'].append('image')
    list_info.reverse()  # 翻转
    final_dict = {"list": list_info}
    with open("../../blog/blog_src/source/photos/data.json","w") as fp:
        json.dump(final_dict, fp)
```

其中 `../../blog/blog_src/source/photos/data.json` 是我博客地址,这里换成你的博客地址.
完成的 python 下载地址 <a href="https://github.com/lovexinforever/blog_back_up/blob/master/tool.py" target="">tool.py</a>

使用
-----------
`python3 tool.py`
因为我用的是 python3 这里可以根据你的 python 版本来使用

QA:
-----------
如果出现 `from PIL import Image` 这里报错.说明没有 PIL 这个库.
执行 `python3 -m pip install Pillow`

结束语
-----------
目前为止,相册库已经处理完毕,接下来会更新 hexo 怎么使用相册库. 
<a href="https://lovexinforever.github.io/2017/09/18/Hexo-NexT-博客搭建相册-二/">Hexo+NexT 博客搭建相册(二)</a>

