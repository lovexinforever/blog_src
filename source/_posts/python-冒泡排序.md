---
title: python-冒泡排序
date: 2017-10-16 15:04:38
tags:
- python
- 排序
- 冒泡排序
categories:
- 技术
- python
essential: true
---

之前文章中介绍了怎样用 `hexo + next` 生成相册.由于相册图片命名方式为 `yyyy-MM-dd_des.jpg` 形式,导致在取9月和10月的时候,会发生顺序上的错误.这是由于10的排序比9的排序靠前.所以就想到了用冒泡排序来解决这个问题
<!-- more -->
冒泡排序的时间复杂度
----------
冒泡排序的时间复杂度是O(N^2)

冒泡排序的思想
----------
每次比较两个相邻的元素, 如果他们的顺序错误就把他们交换位置

比如有五个数: `12, 35, 99, 18, 76`, 从大到小排序, 对相邻的两位进行比较

第一趟:
- 第一次比较: 35, 12, 99, 18, 76
- 第二次比较: 35, 99, 12, 18, 76
- 第三次比较: 35, 99, 18, 12, 76
- 第四次比较: 35, 99, 18, 76, 12

经过第一趟比较后, 五个数中最小的数已经在最后面了, 接下来只比较前四个数, 依次类推

第二趟:
- 99, 35, 76, 18, 12

第三趟:
- 99, 76, 35, 18, 12

第四趟:
- 99, 76, 35, 18, 12

比较完成

冒泡排序原理
----------
每一趟只能将一个数归位, 如果有n个数进行排序,只需将n-1个数归位, 也就是说要进行n-1趟操作(已经归位的数不用再比较)

```
#!/usr/bin/env python
# coding:utf-8

def bubbleSort(nums):
    for i in range(len(nums)-1):    # 这个循环负责设置冒泡排序进行的次数
        for j in range(len(nums)-i-1):  # ｊ为列表下标
            if nums[j] > nums[j+1]:
                nums[j], nums[j+1] = nums[j+1], nums[j]
    return nums

nums = [5,2,45,6,8,2,1]

print bubbleSort(nums)
```
缺点
----------
冒泡排序解决了桶排序浪费空间的问题, 但是冒泡排序的效率特别低

引用
----------
打开 tool.py,添加冒泡排序方法
```
def bubble(bubbleList):
    listLength = len(bubbleList)
    while listLength > 0:
        for i in range(listLength - 1):    # 这个循环负责设置冒泡排序进行的次数
            for j in range(listLength-i-1):  # ｊ为列表下标
                if(bubbleList[j].get('arr').get('year') == bubbleList[j+1].get('arr').get('year')):
                    if bubbleList[j].get('arr').get('month') < bubbleList[j+1].get('arr').get('month'):
                
                        bubbleList[j], bubbleList[j+1] = bubbleList[j+1], bubbleList[j]
        return bubbleList
```
在 `handle_photo` 中引用 `bubble`
在 `list_info.reverse()  # 翻转` 下面添加 `bubble(list_info)`

到此就完成了 10月排在9月前面的工作.


