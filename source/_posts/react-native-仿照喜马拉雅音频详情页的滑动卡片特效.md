---
title: react native 仿照喜马拉雅音频详情页的滑动卡片特效
date: 2020-08-07 11:23:24
tags:
- Hexo
- react native
- 喜马拉雅
- 滑动式卡片
categories:
- Technology
- ReactNative
photos: 
- https://raw.githubusercontent.com/lovexinforever/blog_back_up/master/photos/2020-8-7_一人一牛.jpeg
- https://raw.githubusercontent.com/lovexinforever/blog_back_up/master/photos/2020-8-7_迎客松.jpg
top: 10
essential: true
---
最近听喜马拉雅, 发现喜马拉雅的详情滑动卡片效果很赞, 就很想做一个, 然后就用 react native 做了一个类似的.
<!-- more -->

## 效果
废话不多说, 先看最终实现的效果
![滑动式卡片](https://raw.githubusercontent.com/lovexinforever/blog_back_up/master/blog_photos/QQ20200807-141439.gif)

## 思路

### 页面组成
- 底部详情介绍页面
- 浮动在底部的菜单栏
- 跟随底部详情页的菜单栏 (此菜单栏和浮动的菜单栏一样)

### 详情页组成
- app header
- app detail container
- app bottom
- app float menu container
- app detail bottom menu
- app bottom (占位)
- app float menu container(占位高度)

![详情页组成](https://raw.githubusercontent.com/lovexinforever/blog_back_up/master/blog_photos/WechatIMG70.jpeg)

### 详情页页面种类
- detail container Height < screenHeight - app Header Height
- detail container Height > screenHeight - app Header Height

当中间详情页内容高度小于 屏幕高度- 头部高度时, 需要一个占位的 view 来撑满屏幕
```
{/*当前 stickHeight < scrollMin 高度时, 占位 view , 保证可滑动距离>= scrollMin*/}
                        {
                            stickHeight < scrollContainerMinHeight &&
                            <View style={{height: scrollContainerMinHeight - stickHeight}}/>
                        }
```

当滑动距离小于 screenHeight - app header height - app bottom height - app float container Height 时, 显示 float menu
```
{/*当滑动距离scollY < realContainerHeight 时, 占位, 已便让内容能滑动上来*/}
                        {
                            isShowFloatMenu &&
                            <View style={{height: bottomHeight + globalConfig.bookCardPadding}}/>
                        }
```

### 详情页实际 code

```
                <View onLayout={e => {
                    this._getHeaderHeight(e.nativeEvent.layout)
                }}>
                    <App Header>........</App Header>
                </View>
                {/*=======================header end======================*/}
                <Animated.ScrollView
                    onLayout={e => {
                        this._getHeight(e.nativeEvent.layout);
                    }}
                    ref={scroll => (this.scroll = scroll)}
                    onScroll={Animated.event(
                        [
                            {
                                nativeEvent: {contentOffset: {y: this.state.scrollY}}
                            }
                        ],
                        {useNativeDriver: true}
                    )}
                    onMomentumScrollEnd={
                        e => this._contentViewScroll(e, false)
                    }
                    scrollEnabled={contentScrollViewCanBeScroll}
                    scrollEventThrottle={0.5}
                    // scrollEnabled={false}
                >
                    <View style={[globalStyles.container]}>
                        {/* ====================== scroll container ===================*/}
                        <DetailItem detail={params}/>
                        {/* ==========detail container end ========== */}

                        {/* ====================== scroll end ===================*/}
                        {/*当前 stickHeight < scrollMin 高度时, 占位 view , 保证可滑动距离>= scrollMin*/}
                        {
                            stickHeight < scrollContainerMinHeight &&
                            <View style={{height: scrollContainerMinHeight - stickHeight}}/>
                        }

                        {/*当滑动距离scollY < realContainerHeight 时, 占位, 已便让内容能滑动上来*/}
                        {
                            isShowFloatMenu &&
                            <View style={{height: bottomHeight + globalConfig.bookCardPadding}}/>
                        }
                        <View>
                            {
                                this._renderMenu()
                            }
                        </View>
                    </View>
                </Animated.ScrollView>

                {
                    this._renderFloatMenu()
                }

                <View
                    onLayout={e => {
                        this._getBottomHeight(e.nativeEvent.layout)
                    }}
                    style={[globalStyles.horizontal_end_container, globalStyles.center, globalStyles.center3, globalStyles.container, {
                        position: 'absolute',
                        bottom: 0,
                        backgroundColor: colors.white,
                        borderTopRightRadius: 10,
                        borderTopLeftRadius: 10,
                        padding: 10,
                    }]}>
                    <App bottom>.......</app bottom>
                </View>
```

## 手势监听
通过监听手势来改变 float menu 的 translateY 值来实现根据手势滑动移动 float menu

### 手势滑动 view

```
import React, {PureComponent} from "react";
import {
    View,
    PanResponder
} from "react-native";
import * as logger from "../../utils/logger";


import PropTypes from "prop-types";
import globalConfig from "../../config/globalConfig";

class PanMoveView extends PureComponent {

    componentWillMount() {
        this._panResponder = PanResponder.create({
            onStartShouldSetPanResponder: (evt, gestureState) => {
                return this.props.isAble;
            },
            onMoveShouldSetPanResponder: (evt, gestureState) => {
                if (gestureState) {
                    const {dy, dx} = gestureState;
                    return (Math.abs(dy) >= globalConfig.panMoveConfig.moveMin || Math.abs(dx) >= globalConfig.panMoveConfig.moveMin) && this.props.isAble
                }
                return this.props.isAble;
            },
            onPanResponderGrant: (evt, gestureState) => {
                // this._highlight();
                if (this.props.handleGrant) {
                    this.props.handleGrant()
                }
            },
            onPanResponderMove: (evt, gestureState) => {
                logger.log('gsMove====>>>>>', gestureState)
                if (this.props.handleMove) {
                    this.props.handleMove(gestureState)
                }
            },
            onPanResponderRelease: (evt, gestureState) => {
                logger.log('gsRelease', gestureState)
                if (this.props.handleRelease) {
                    this.props.handleRelease(gestureState)
                }

            },
            onPanResponderTerminate: (evt, gestureState) => {
            },
        });
    }

    render() {
        const {
            children,
            style
        } = this.props;
        return (

            <View
                style={style}
                {...this._panResponder.panHandlers}
            >
                {children}
            </View>
        );
    }
}

PanMoveView.propTypes = {
    handleMove: PropTypes.func.isRequired,
    handleRelease: PropTypes.func.isRequired,
    handleGrant: PropTypes.func,
    isAble: PropTypes.bool.isRequired
}

export default PanMoveView

```

### float menu

```
 /**
     * 固定底部的 menu
     * @private
     */
    _renderFloatMenu = () => {
        const {
            scrollTabViewHeight, scrollY, nowScrollY, bottomHeight, realContainerHeight, panMoveIsTop
            , cardParentContainerHeight, isShowFloatMenu, panMoveMarginTop, panMoveViewIsAble, tabTransformY
            , scrollContainerMinHeight
        } = this.state;

        return isShowFloatMenu && <PanMoveView style={{
            position: 'absolute',
            height: cardParentContainerHeight + panMoveMarginTop,
            bottom: bottomHeight,
        }} handleMove={this._handleMove} handleRelease={this._handleRelease}
                                               handleGrant={this._handleGrant}
                                               isAble={panMoveViewIsAble}>
            <Animated.View style={{
                transform: [
                    {translateY: tabTransformY}
                ],
                height: (scrollTabViewHeight < scrollContainerMinHeight ? scrollContainerMinHeight : scrollTabViewHeight) + bottomHeight
            }
            }>
                <ScrollTabView
                    initialPage={0}
                    onChangeTab={obj => {
                        this._handleChangeTab(obj);
                    }}
                    style={[
                        {
                            height: scrollTabViewHeight,
                            backgroundColor: colors.white,
                            borderTopRightRadius: 20,
                            borderTopLeftRadius: 20,
                        }

                    ]}
                    borderBottomWidth={0}
                    renderTabBar={() => <RenderTab
                        stickyHeaderY={realContainerHeight}
                        stickyScrollY={scrollY}
                        needPadding={false}
                        nowScrollY={nowScrollY}
                        normalActiveColor={colors.theme_header_bg}
                        normalBgColor={colors.white}
                        normalUnActiveColor={colors.black36}
                        borderTopLeftRadius={20} borderTopRightRadius={20}
                        topBgColor={colors.white}
                        isShowMove={true}
                        isAbleMove={panMoveIsTop}
                        handleGrant={this._handleGrant}
                        handleMove={this._handleMove}
                        handleRelease={this._handleRelease}
                        topActiveColor={colors.theme_header_bg}
                        topUnActiveColor={colors.black36}/>}>
                    {this._renderBookList()}
                    {this._renderBookNote()}
                    {this._renderBookRelate()}
                </ScrollTabView>
            </Animated.View>
        </PanMoveView>
    }
```

### handle move
```

    _handleMove = (gs) => {

        const {dy} = gs;
        let {moveTempY, containerHeight, nowScrollY} = this.state;

        moveTempY += dy;

        if (moveTempY < 0) {
            moveTempY = 0;
        } else if (moveTempY > containerHeight) {
            moveTempY = containerHeight
        }
        const tabTransformY = moveTempY
        this.setState({
            tabTransformY
        })
        // this.forceUpdate()
    }
```

### handle Release

```
 _handleRelease = (gs) => {
        const {dy} = gs;
        let {
            moveTempY, containerHeight, panMoveIsBottom, contentScrollViewCanBeScroll, bottomHeight
            , realContainerHeight, panMoveMarginTop, nowScrollY, panMoveViewIsAble, scrollContainerMinHeight
        } = this.state;

        moveTempY += dy;
        let panMoveIsTop
        if (moveTempY < 0) {
            moveTempY = 0
            panMoveIsBottom = false;
            panMoveIsTop = true;
            panMoveViewIsAble = false
            contentScrollViewCanBeScroll = false
        } else if (moveTempY < utils.getScreenHeight() / 3) {
            moveTempY = 0
            panMoveIsBottom = false;
            panMoveIsTop = true;
            panMoveViewIsAble = false
            contentScrollViewCanBeScroll = false
        } else if (moveTempY < ((containerHeight - utils.getScreenHeight() / 3) / 2 + utils.getScreenHeight() / 3)) {
            moveTempY = utils.getScreenHeight() / 3;
            panMoveIsBottom = false;
            panMoveIsTop = false;
            panMoveViewIsAble = true
            contentScrollViewCanBeScroll = false
        } else {
            moveTempY = 0;
            panMoveIsBottom = true;
            panMoveIsTop = false;
            panMoveViewIsAble = true
            contentScrollViewCanBeScroll = true
            panMoveMarginTop = -(scrollContainerMinHeight - bottomHeight - globalConfig.bookCardPadding);
        }

        this.setState({
            moveTempY,
            tabTransformY: moveTempY,
            panMoveViewIsAble,
            panMoveIsBottom,
            panMoveIsTop,
            contentScrollViewCanBeScroll,
            panMoveMarginTop
        })
        // this.forceUpdate()
    }
```

主要是通过 move 传递过来的 dy 值来修改 float menu 的translateY 值

然后释放 release 的时候, 根据当前滑动的位置来更新页面到底是滑到中间 还是头部还是底部,
最后根据父级的 scrollview 的滑动距离来判断是否显示 float menu.


