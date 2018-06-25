---
title: Android 开发 自定义跑马灯 TextView
date: 2017-11-14 14:09:16
tags:
- android
- 跑马灯
- 自定义textview
categories: 
- Technology
- Journal
- Android
photos: 
- /imgs/bg2.jpg
---
在项目开发中,有次需要用到跑马灯,使用了系统自带的跑马灯,发现会有点问题.然后就考虑重写了一个跑马灯 textview.
<!-- more -->
主要思路是 自定义一个画笔工具,自己画出 textview

```
public class MarqueeTextView extends View {

    private static String TAG = MarqueeTextView.class.getSimpleName();

    private String mContent;

    private ValueAnimator mAnimator;

    private Paint mPaint;
    private int mOffset;
    private int mBaseLine;
    private Rect mTargetRect;
    private int mTextWidth = 0;

    public MarqueeTextView(Context context) {
        super(context);
        init();
    }

    public MarqueeTextView(Context context, AttributeSet attrs) {
        super(context, attrs);
        init();
    }

    public MarqueeTextView(Context context, AttributeSet attrs, int defStyleAttr) {
        super(context, attrs, defStyleAttr);
        init();
    }

    private void init() {
        mPaint = new Paint();
        mPaint.setTextSize(getContext().getResources().getDimension(R.dimen.sp_15));
        mPaint.setColor(Color.RED);
        mPaint.setTextAlign(Paint.Align.LEFT);
        mPaint.setAntiAlias(true);

    }

    @Override
    protected void onMeasure(int widthMeasureSpec, int heightMeasureSpec) {
        if (mContent == null) {
            super.onMeasure(widthMeasureSpec,heightMeasureSpec);
            return;
        }


        Paint.FontMetricsInt fontMetrics = mPaint.getFontMetricsInt();
        int height = fontMetrics.bottom - fontMetrics.top + getPaddingBottom() + getPaddingTop();
        setMeasuredDimension(widthMeasureSpec, MeasureSpec.makeMeasureSpec(height, MeasureSpec.EXACTLY));

        int top = getPaddingTop();
        int bottom = top + fontMetrics.bottom - fontMetrics.top;
        int left = getPaddingLeft() + mOffset;
        int right = left + mTextWidth;
        if (mTargetRect == null) {
            mTargetRect = new Rect();
        }
        mTargetRect.set(left, top, right, bottom);
        mBaseLine = (mTargetRect.bottom + mTargetRect.top - fontMetrics.bottom - fontMetrics.top) / 2;
        mAnimator.cancel();
        if (mTextWidth > getMeasuredWidth()) {
            mAnimator.start();
        }

    }

    @Override
    protected void onWindowVisibilityChanged(int visibility) {
        super.onWindowVisibilityChanged(visibility);
        if(visibility == View.VISIBLE){
            start();
        }else{
            cancel();
        }
    }

    @Override
    protected void onDraw(Canvas canvas) {
        super.onDraw(canvas);

        if (mContent == null || mTargetRect == null) {
            return;
        }

        mTargetRect.left = getPaddingLeft() + mOffset;
        mTargetRect.right = mTargetRect.left + mTextWidth;
        canvas.drawText(mContent, mTargetRect.left, mBaseLine, mPaint);
    }

    public void setText(String text) {
        mContent = text;
        mTextWidth = (int) (mPaint.measureText(mContent, 0, mContent.length())+1);
        if(null == mAnimator){
            mAnimator = ValueAnimator.ofFloat(0, mTextWidth);
            mAnimator.addUpdateListener(new ValueAnimator.AnimatorUpdateListener() {
                @Override
                public void onAnimationUpdate(ValueAnimator valueAnimator) {
                    mOffset -= 2;
                    if (mOffset < -mTextWidth) {
                        mOffset = getWidth();
                    }
                    invalidate();
                }
            });
            mAnimator.setRepeatCount(ValueAnimator.INFINITE);
            mAnimator.setRepeatMode(ValueAnimator.REVERSE);
            //5.为ValueAnimator设置目标对象并开始执行动画
            mAnimator.setTarget(this);
            mAnimator.setDuration((long) (mTextWidth));

        }

    }

    public void start(){
        if(null != mAnimator && mTextWidth > getMeasuredWidth()){
            mAnimator.start();
        }
    }

    public void cancel(){
        if(null != mAnimator && mTextWidth > getMeasuredWidth()){
            mAnimator.cancel();
        }
    }
}

```
