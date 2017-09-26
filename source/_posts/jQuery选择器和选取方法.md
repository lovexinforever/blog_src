---
title: jQuery选择器和选取方法(一)
date: 2017-09-26 16:36:10
tags:
- HTML5
- js
- JQuery
- 选择器
categories:
- 技术
- HTML5
- JS
essential: true
top: 3
---
在 h5 开发中,`JQuery` 选择器经常用到,也尤其重要,用好选择器,能让你的开发事半功倍.下面是整理的 jquery 选择的使用和方法.
<!--more-->
jQuery选择器
----------
在CSS3选择器标淮草案定义的选择器语法中，jQuery支持相当完整的一套子集，同时还添加了一些非标准但很有用的伪类。注意:本节讲述的是 jQuery选择器。其中有不少选择器(但不是全部)可以在CSS样式表中使用。选择器语法有三层结构。你肯定已经见过选择器中最简单的形式。`”#test”`选取id属性为”test”的元素。`”blockquote”`选取文档中的所有`<blockquote>`元素，而`”div.note”` 则选取所有class属性为`”note”`的`div`元素。简单选择器可以组合成“组合选择器”，比如 `“div.note>p”`和`“blockquote i”`，只要用组合字符做分隔符就行。简单选择器和组合选择器还可以分组成逗号分隔的列表。这种选择器组是传递给$()函数最常见的形式。在解释组合选择器 和选择器组之前，我们必须先了解简单选择器的语法。

简单选择器
----------
简单选择器的开头部分(显式或隐式地)是标签类型声明。例如，如果只对`<p>`元素感兴趣，简单选择器可以用`“p”`开头。如果选取的元素和标签名无关，则可以使用通配符`“*”`号来代替。如果选择器没有以标签名或通配符开头，则隐式含有一个通配符。

标签名或通配符指定了备选文档元素的一个初始集。在简单选择器中，标签类型声明之后的部分由零个或多个过滤器组成。过滤器从左到右应用，和书写顺序一致，其中每一个都会缩小选中元素集。下表列举了jQuery支持的过滤器。

<table><thead><tr><td>标签</td><td>描述</td></tr></thead><tbody><tr><td>#id</td><td>匹配id属性为id的元素。在有效的}ITML文档中，永远不会出现多个元素拥有相同的ID，因此该过滤器通常作为独立选择器来使用</td></tr><tr><td>.class</td><td>匹配class属性(是一串被解析成用空格分隔的单词列表)含有class单词的所有元素</td></tr><tr><td>[attr]</td><td>匹配拥有attr属性(和值无关)的所有元素</td></tr><tr><td>[attr=val]</td><td>匹配拥有attr属性且值为val的所有元素</td></tr><tr><td>[attr!=val]</td><td>匹配没有attr属性、或attr属性的值不为val的所有元素((jQuery的扩展)</td></tr><tr><td>[attr^=val]</td><td>匹配attr属性值以val开头的元素</td></tr><tr><td>[attr$=val]</td><td>匹配attr属性值以val结尾的元素</td></tr><tr><td>[attr*=val]</td><td>匹配attr属性值含有val的元素</td></tr><tr><td>[attr~=val]</td><td>当其attr属性解释为一个由空格分隔的单词列表时，匹配其中包含单词val的元素。因此选择器`“div.note”`与`“div [class~=note]”`相同</td></tr><tr><td>[attr|=val]</td><td>	匹配正在动画中的元素，该动画是由jQuery产生的</td></tr><tr><td>:button</td><td>匹配`<button type=”button”>`和`<input type=”button”>`元素(jQuery的扩展)</td></tr><tr><td>:checkbox</td><td>匹配`<input type=”checkbox”>`元素( jQuery的扩展)，当显式带有input标签前缀`”input:checkbox”`时，该过滤器更高效</td></tr><tr><td>:checked</td><td>匹配选中的input元素</td></tr><tr><td>:contains(text)</td><td>匹配含有指定text文本的元素(jQuery的扩展)。该过滤器中的圆括号确定了文本的范围—无须添加引号。被过滤的元素的文本是由textContent或innerText属性来决定的—这是原始文档文本，不带标签和注释</td></tr><tr><td>:disabled</td><td>匹配禁用的元素</td></tr><tr><td>:empty</td><td>匹配没有子节点、没有文本内容的元素</td></tr><tr><td>:enabled</td><td>匹配没有禁用的元素</td></tr><tr><td>:eq(n)</td><td>匹配基于文档顺序、序号从0开始的选中列表中的第n个元素(jQuery的扩展)</td></tr><tr><td>:even</td><td>匹配列表中偶数序号的元素。由于第一个元素的序号是0，因此实际上选中的是第1个、第3个、第5个等元素(jQuery的扩展)</td></tr><tr><td>:file</td><td>	匹配`<input type=”file”>`元素(jQuery的扩展)</td></tr><tr><td>:first</td><td>匹配列表中的第一个元素。和`“:eq(0)”`相同(jQuery的扩展)</td></tr><tr><td>:first-child</td><td>匹配的元素是其父节点的第一个子元素。注意:这与“:first”不同</td></tr><tr><td>:gt(n)</td><td>匹配基于文档顺序、序号从0开始的选中列表中序号大于n的元素( jQuery的扩展)</td></tr><tr><td>:has(sel)</td><td>匹配的元素拥有匹配内嵌选择器sel的子孙元素</td></tr><tr><td>:header</td><td>匹配所有头元素:`<h1>`, `<h2>`, `<h3>`, `<h4>`, `<h5>`或`<h6>` (jQuery的扩展)</td></tr><tr><td>:hidden</td><td>匹配所有在屏幕上不可见的元素:大体上可以认为这些元素的offsetWidth和offsetHeight为0</td></tr><tr><td>:image</td><td>匹配`<input type=”image”>`元素。注意该过滤器不会匹配`<img>`元素( jQuery的扩展)</td></tr><tr><td>:input</td><td>匹配用户输入元素:`<input>`, `<textarea>`, `<select>`和`<button>`</td></tr><tr><td>:last</td><td>匹配选中列表中的最后一个元素</td></tr><tr><td>:last-child</td><td>匹配的元素是其父节点的最后一个子元素。注意:这与`“:last”`不同</td></tr><tr><td>`:lt(n)`</td><td>匹配基于文档顺序、序号从0开始的选中列表中序号小于n的元素</td></tr><tr><td>:not(sel)</td><td>匹配的元素不匹配内嵌选择器sel</td></tr><tr><td>:nth(n)</td><td>与`“:eq(n)”`相同</td></tr><tr><td>:nth-child(n)</td><td>匹配的元素是其父节点的第n个子元素。。可以是数值、单词even,单词odd或计算公式。 使用`“:nth-child(even)”`来选取那些在其父节点的子元素中排行第2或第4等序号的元素。使用`“:nth-child(odd)”`来选取那 些在其父节点的子元素中排行第1、第3等序号的元素。
更常见的情况是，n是xn或x n+y这种计算公式，其中x和y是整数，n是字面量n。因此可以用`nth-child(3n+1)`来选取第1个、第4个、第7个等元素。
注意该过滤器的序号是从1开始的，因此如果一个元素是其父节点的第一个子元素，会认为它是奇数元素，匹配的是3n+1，而不是3n。要和`“:even`以及`“:odd”`过滤器区分开来，后者匹配的序号是从0开始的。</td></tr><tr><td>:odd</td><td>匹配列表中奇数(从0开始)序号的元素。注意序号为1和3的元素分别是第2个和第4个匹配元素</td></tr></tbody></table>

注意:表中列举的部分选择器在圆括号中接受参数。例如，下面这个选择器选取的元素在其父节点的子元素中排行第1或第2等，只要它们含有`“JavaScript”`单词，就不包含元素。

```
p:nth-child(3n+1): text (JavaScript):not(:has(a))
```

通常来说，指定标签类型前缀，可以让过滤器的运行更高效。例如，不要简单使用`”:radio”`来选取单选框按钮，使用`“input:radio”`会 更好。ID过滤器是个例外，不添加标签前缀时它会更高效。例如，选择器“#address”通常比更明确的“form#address”更高效。

组合选择器
----------
使用特殊操作符或“组合符”可以将简单选择器组合起来，表达文档树中元素之间的关系。下表列举了jQuery支持的组合选择器。这些组合选择器与CSS3支持的组合选择器是一样的。
下面是组合选择器的一些例子:
```
"blockquote i"              //匹配<blockquote>里的<i>元素
"ol > li"                   //<1i>元素是<of>的直接子元素
"#output+*"                 //id="output"元素后面的兄弟元素
"div.note > h1+p"           //紧跟<h1>的<P>元素，在<div class="note">里面
```
注意组合选择器并不限于组合两个选择器:组合三个甚至更多选择器也是允许的。组合选择器从左到右处理。

选择器组
----------
传递给$()函数(或在样式表中使用)的选择器就是选择器组，这是一个逗号分隔的列表，由一个或多个简单选择器或组合选择器构成。选择器组匹配的元 素只要匹配该选择器组中的任何一个选择器就行。对我们来说，一个简单选择器也可以认为是一个选择器组。下面是选择器组的一些例子:
```
"h1, h2,h3"             //匹配<h1>, <h2>和<h3>元素
"#p1, #p2, #p3"         //匹配id为p1, p2或p3的元素
"div.note, p.note"      //匹配class="note"的<div>和<P>元素
"body>p,div.note>p"     //<body>和<div class="note">的<P>子元素
```
注意:CSS和jQuery选择器语法允许在简单选择器的某些过滤器中使用圆括号，但并不允许使用圆括号来进行更常见的分组。例如，不能把选择器组或组合选择器放在圆括号中并且当成简单选择器:
```
(h1, h2, h3)+p          //非法
h1+p, h2+p, h3+p        //正确的写法
```

总结语
----------
到此讲解了 jquery 的选择器.下面一张将讲解 选择器的选取方法.

