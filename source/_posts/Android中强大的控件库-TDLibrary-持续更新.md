---
title: Android中强大的控件库 TDLibrary(持续更新)
date: 2018-12-05 19:15:07
tags:
- Hexo
- android
- 控件库
- tdlibrary
categories:
- Technology
- Android
photos: 
- /imgs/bg2.jpg
top: 10
essential: true
---
Android 项目中最强大的控件库 TDLibrary, 持续更新中, 继承各方的控件和工具类,让你无需在使用控件而烦恼.
<!-- more -->

# TDLibrary


TDLibrary 是一个 android 上面经常用到的控件库和一些工具类.

## License

TDLibrary is licensed under the Apache 2.0 License

Copyright 2018 TIMDING


## Installation

### JCenter 引用

Add TDLibrary as a dependency to your `build.gradle`
```groovy
dependencies {
    implementation 'com.tim:tdlibrary:1.0.3'
}
```

### jitpack 引用

Add it in your root build.gradle at the end of repositories:
```
allprojects {
		repositories {
			...
			maven { url 'https://jitpack.io' }
		}
	}
```

 Add the dependency
 ```
 dependencies {
	        implementation 'com.github.lovexinforever:TDLibrary:v1.0.3'
	}
 ```

## Usage

### 可控输入个数的验证码输入框

#### 效果
![验证码](https://raw.githubusercontent.com/lovexinforever/blog_img/master/ezgif.com-video-to-gif.gif)
#### 使用

在 xml 中引入控件
```
<com.tim.tdlibrary.ActivationCodeView
        android:id="@+id/icv"
        android:layout_width="match_parent"
        android:layout_height="60dp"
        android:layout_centerHorizontal="true"
        android:layout_marginLeft="10dp"
        android:layout_marginRight="10dp"
        android:layout_marginTop="26dp"
        app:icv_et_bg_focus="@drawable/shape_icv_et_bg_focus"
        app:icv_et_bg_normal="@drawable/shape_icv_et_bg_normal"
        app:icv_et_divider_drawable="@drawable/shape_divider_identifying"
        app:icv_et_number="5"
        app:icv_text_bg_alpha="100"
        app:icv_et_text_color="#fff"
        app:icv_text_count_num="4"
        app:icv_et_width="60dp"/>
```
java 中监听输入框内容变化
```
 mActivationCodeView.setInputCompleteListener(new ActivationCodeView.InputCompleteListener() {
            @Override
            public void inputComplete() {
                updateViewAfterInput();
            }

            @Override
            public void deleteContent() {
                updateViewAfterInput();
            }
        });
```

### 横向滚动的跑马灯

#### 效果
![跑马灯](https://raw.githubusercontent.com/lovexinforever/blog_back_up/master/blog_photos/marquee_text.gif)

#### 使用
在 xml 中引用控件
```
<com.tim.tdlibrary.marquee.MarqueeTextView
        android:id="@+id/text"
        app:text_color="#ff77dd"
        app:text_size="@dimen/sp_15"
        android:layout_width="match_parent"
        android:layout_height="match_parent" />
```
java 中调用 setText 方法
```
MarqueeTextView marqueeTextView = findViewById(R.id.text);

        marqueeTextView.setText("测试测试测试发的卡积分考虑到撒酒疯林科大实际付款老司机发的可使肌肤都是框架范德萨开了房觉得上路");
```

### 视图标签

#### 效果
![视图标签](https://raw.githubusercontent.com/lovexinforever/blog_back_up/master/blog_photos/Screenshot_1544007966.png)
#### 使用
在 xml 中引用控件
```
<com.tim.tdlibrary.laberview.LabelButtonView
            android:id="@+id/labelbutton"
            android:layout_width="200dp"
            android:layout_height="48dp"
            android:background="#03a9f4"
            android:gravity="center"
            android:text="Button"
            android:textColor="#ffffff"
            app:label_backgroundColor="#C2185B"
            app:label_distance="20dp"
            app:label_height="20dp"
            app:label_orientation="RIGHT_TOP"
            app:label_text="HD"
            app:label_textSize="12sp"
            app:label_textStyle="BOLD"/>

            <com.tim.tdlibrary.laberview.LabelTextView
            android:id="@+id/text"
            android:layout_width="wrap_content"
            android:layout_height="48dp"
            android:layout_gravity="center"
            android:layout_marginTop="8dp"
            android:background="#212121"
            android:gravity="center"
            android:padding="16dp"
            android:text="TextView"
            android:textColor="#ffffff"
            app:label_backgroundColor="#03A9F4"
            app:label_distance="15dp"
            app:label_orientation="LEFT_TOP"
            app:label_text="POP"
            app:label_textSize="10sp"
            app:label_textStyle="BOLD_ITALIC"/>
```





## 关于我
[BLOG](https://timding.top)


