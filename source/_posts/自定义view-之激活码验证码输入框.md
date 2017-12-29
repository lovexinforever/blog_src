---
title: 自定义view 之激活码验证码输入框
date: 2017-12-29 10:10:31
tags:
- android
- 激活码
- 验证码
- 自定义输入框
categories: 
- 技术
- 日志
- Android
photos: 
- /imgs/bg2.jpg
essential: true
top: 6
---

前两天接了个项目,项目中需要自定义一个激活码输入框,类似于滴滴打车那种正方形输入框.然后思考了一下怎么去做这个输入框.终于在今天搞定了.输入框接收 自定义输入框的数量,输入框的宽度,输入框之间的分割线,输入框文字颜色,输入框文字大小,输入框获取焦点的边框,每个输入框的文字个数以及输入框的透明度
<!--more-->

效果展示
----------
<img src="https://raw.githubusercontent.com/lovexinforever/blog_img/master/ezgif.com-video-to-gif.gif">

开发思路
----------
我们需要通过EditText控件接受我们的输入，界面中明显是不能看到这个控件的，所以我们需要将这个控件给设置透明。然后将接受到的输入内容设置给我们的TextView。为了满足正方形的样式，只需要给TextView设置一个背景即可。在开发过程中，我们发现验证码的个数不是固定的，有4位数的，也有6位数的。为了实现低耦合的复用性。我们需要一个自定义的属性来满足这个要求。其他具体的思路将会在具体实现的时候讲。

实现
----------
- 组合控件的布局实现

```
<?xml version="1.0" encoding="utf-8"?>
<RelativeLayout xmlns:android="http://schemas.android.com/apk/res/android"
    android:layout_width="match_parent"
    android:layout_height="match_parent">

    <LinearLayout
        android:id="@+id/container_et"
        android:layout_width="wrap_content"
        android:layout_height="match_parent"
        android:layout_centerInParent="true"
        android:gravity="center_vertical"
        android:orientation="horizontal"
        android:showDividers="middle">

    </LinearLayout>

    <EditText
        android:id="@+id/et"
        android:layout_width="match_parent"
        android:layout_height="match_parent"
        android:background="@android:color/transparent"
        android:inputType="number" />

</RelativeLayout>
```
这的LinearLayout用来存放TextVeiw ,android:showDividers=”middle”来设定我们的间隔的方式。

- 设计自定义属性

```
<?xml version="1.0" encoding="utf-8"?>
<resources>
    <declare-styleable name="ActivationCodeView">

        <attr name="icv_et_number" format="integer" />
        <!--输入框的宽度-->
        <attr name="icv_et_width" format="dimension|reference" />
        <!--输入框之间的分割线-->
        <attr name="icv_et_divider_drawable" format="reference" />
        <!--输入框文字颜色-->
        <attr name="icv_et_text_color" format="color|reference" />
        <!--输入框文字大小-->
        <attr name="icv_et_text_size" format="dimension|reference" />
        <!--输入框获取焦点时边框-->
        <attr name="icv_et_bg_focus" format="reference" />
        <!--输入框没有焦点时边框-->
        <attr name="icv_et_bg_normal" format="reference" />
        <!--每个输入框中的文字个数 -->
        <attr name="icv_text_count_num" format="integer" />
        <!--输入框背景透明度 -->
        <attr name="icv_text_bg_alpha" format="integer" />
    </declare-styleable>
</resources>
```
注释已经很清楚了，就不再解释了。

- 获取自定义属性

```
/**
     * 初始化
     * @param context
     * @param attrs
     * @param defStyleAttr
     */
    private void init(Context context, AttributeSet attrs, int defStyleAttr) {
        LayoutInflater.from(context).inflate(R.layout.layout_activation_code, this);
        mContainerLl = (LinearLayout) this.findViewById(R.id.container_et);
        mInputEt = (EditText) this.findViewById(R.id.et);

        TypedArray typedArray = context.obtainStyledAttributes(attrs, R.styleable.ActivationCodeView, defStyleAttr, 0);
        mEtNumber = typedArray.getInteger(R.styleable.ActivationCodeView_icv_et_number, 1);
        mTvCountNumber = typedArray.getInteger(R.styleable.ActivationCodeView_icv_text_count_num, 1);
        mAlpha = typedArray.getInteger(R.styleable.ActivationCodeView_icv_text_bg_alpha,255);
        mEtWidth = typedArray.getDimensionPixelSize(R.styleable.ActivationCodeView_icv_et_width, 42);
        mEtDividerDrawable = typedArray.getDrawable(R.styleable.ActivationCodeView_icv_et_divider_drawable);
        mEtTextSize = typedArray.getDimensionPixelSize(R.styleable.ActivationCodeView_icv_et_text_size, 16);
        mEtTextColor = typedArray.getColor(R.styleable.ActivationCodeView_icv_et_text_color, Color.BLACK);
        mEtBackgroundDrawableFocus = typedArray.getDrawable(R.styleable.ActivationCodeView_icv_et_bg_focus);
        mEtBackgroundDrawableNormal = typedArray.getDrawable(R.styleable.ActivationCodeView_icv_et_bg_normal);
        //释放资源
        typedArray.recycle();


        // 当xml中未配置时 这里进行初始配置默认图片
        if (mEtDividerDrawable == null) {
            mEtDividerDrawable = context.getResources().getDrawable(R.drawable.shape_divider_identifying);
        }

        if (mEtBackgroundDrawableFocus == null) {
            mEtBackgroundDrawableFocus = context.getResources().getDrawable(R.drawable.shape_icv_et_bg_focus);
        }

        if (mEtBackgroundDrawableNormal == null) {
            mEtBackgroundDrawableNormal = context.getResources().getDrawable(R.drawable.shape_icv_et_bg_normal);
        }

        initUI();
    }
```

- 初始化 TextView

```
 //初始化TextView
    private void initTextViews(Context context, int etNumber, int etWidth, Drawable etDividerDrawable, float etTextSize, int etTextColor) {
        // 设置 editText 的输入长度
        mInputEt.setCursorVisible(false);//将光标隐藏
        mInputEt.setFilters(new InputFilter[]{new InputFilter.LengthFilter(etNumber)}); //最大输入长度
        // 设置分割线的宽度
        if (etDividerDrawable != null) {
            etDividerDrawable.setBounds(0, 0, etDividerDrawable.getMinimumWidth(), etDividerDrawable.getMinimumHeight());
            mContainerLl.setDividerDrawable(etDividerDrawable);
        }
        mTextViews = new TextView[etNumber];
        for (int i = 0; i < mTextViews.length; i++) {
            TextView textView = new TextView(context);
            textView.setTextSize(etTextSize);
            textView.setTextColor(etTextColor);
            textView.setWidth(etWidth);
            textView.setHeight(etWidth);

            if (i == 0) {
                textView.setBackgroundDrawable(mEtBackgroundDrawableFocus);
            } else {
                textView.setBackgroundDrawable(mEtBackgroundDrawableNormal);
            }
            //設置透明度
            textView.getBackground().setAlpha(mAlpha);
            textView.setGravity(Gravity.CENTER);

            textView.setFocusable(false);

            mTextViews[i] = textView;
        }
    }
```
这里动态生成TextView 具体实现 注释很清楚，需要注意一点的是 textView.setFocusable(false); 不然在页面中TextView会获取焦点有一个 光标。用一个数组来存放 TextView。

- 填充盛放TextView的 LinerLayout

```
   private void initEtContainer(TextView[] mTextViews) {
        for (int i = 0; i < mTextViews.length; i++) {
             mContainerLl.addView(mTextViews[i]);
        }
    }
```

- 处理我们的输入事件 

```
 private class ActivationCodeTextWatcher implements TextWatcher {

        @Override
        public void beforeTextChanged(CharSequence s, int start, int count, int after) {

        }

        @Override
        public void onTextChanged(CharSequence s, int start, int before, int count) {

        }

        @Override
        public void afterTextChanged(Editable editable) {
            String inputStr = editable.toString();
            if (inputStr != null && !inputStr.equals("")) {
                setText(inputStr);
                mInputEt.setText("");
            }
        }
    }

     // 监听删除按键
        mInputEt.setOnKeyListener(new OnKeyListener() {
            @Override
            public boolean onKey(View v, int keyCode, KeyEvent event) {
                if (keyCode == KeyEvent.KEYCODE_DEL && event.getAction() == KeyEvent.ACTION_DOWN) {
                    onKeyDelete();
                    return true;
                }
                return false;
            }
        });
    // 给TextView 设置文字
    private void setText(String inputContent) {
        for (int i = 0; i < mTextViews.length; i++) {
            TextView tv = mTextViews[i];
            if (tv.getText().toString().trim().equals("") || tv.getText().toString().length() < mTvCountNumber) {
                tv.setText(tv.getText().toString() + inputContent);
                // 添加输入完成的监听
                if (inputCompleteListener != null) {
                    inputCompleteListener.inputComplete();
                }
                //光标跳转到下一个
                if(tv.getText().toString().length() == mTvCountNumber) {
                    tv.setBackgroundDrawable(mEtBackgroundDrawableNormal);
                    if (i < mEtNumber - 1) {
                        mTextViews[i + 1].setBackgroundDrawable(mEtBackgroundDrawableFocus);
                    }
                }

                break;
            }
        }
    }

    // 监听删除
    private void onKeyDelete() {
        for (int i = mTextViews.length - 1; i >= 0; i--) {
            TextView tv = mTextViews[i];
            if (!tv.getText().toString().trim().equals("")) {

                tv.setText(tv.getText().subSequence(0,tv.getText().length()-1));
                // 添加删除完成监听
                if (inputCompleteListener != null) {
                    inputCompleteListener.deleteContent();
                }
                tv.setBackgroundDrawable(mEtBackgroundDrawableFocus);
                if (i < mEtNumber - 1) {
                    mTextViews[i + 1].setBackgroundDrawable(mEtBackgroundDrawableNormal);
                }
                break;
            }
        }
    }
```

- 提供给外界的方法

```
 /**
     * 获取输入文本
     *
     * @return string
     */
    public String getInputContent() {
        StringBuffer buffer = new StringBuffer();
        for (TextView tv : mTextViews) {
            buffer.append(tv.getText().toString().trim());
        }
        return buffer.toString();
    }

    /**
     * 删除输入内容
     */
    public void clearInputContent() {
        for (int i = 0; i < mTextViews.length; i++) {
            if (i == 0) {
                mTextViews[i].setBackgroundDrawable(mEtBackgroundDrawableFocus);
            } else {
                mTextViews[i].setBackgroundDrawable(mEtBackgroundDrawableNormal);
            }
            mTextViews[i].setText("");
        }
    }

    /**
     * 设置输入框个数
     * @param etNumber
     */
    public void setEtNumber(int etNumber) {
        this.mEtNumber = etNumber;
        mInputEt.removeTextChangedListener(mTextWatcher);
        mContainerLl.removeAllViews();
        initUI();
    }


    /**
     * 获取输入的位数
     *
     * @return int
     */
    public int getEtNumber() {
        return mEtNumber;
    }

    // 输入完成 和 删除成功 的监听
    private InputCompleteListener inputCompleteListener;

    public void setInputCompleteListener(InputCompleteListener inputCompleteListener) {
        this.inputCompleteListener = inputCompleteListener;
    }

    public interface InputCompleteListener {
        void inputComplete();

        void deleteContent();
    }
```

下载
---------
附上 github 下载地址 <a href="https://github.com/lovexinforever/ActivationCodeView">ActivationCodeView</a>


