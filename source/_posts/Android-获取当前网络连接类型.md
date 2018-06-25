---
title: Android 获取当前网络连接类型
date: 2017-09-22 09:49:14
tags:
- wifi
- android
- 安卓
- 网络
categories: 
- Technology
- Journal
- Android
photos: 
- /imgs/bg2.jpg
---
android 开发项目中,有时候需要风控为了尽量手机信息,需要传递当前的网络连接类型,就整理了一下 android 中怎样获取网络连接类型
<!--more-->
用到的类
----------
- `ConnectivityManager`主要管理和网络连接相关的操作 
- `相关的TelephonyManager`则管理和手机、运营商等的相关信息；WifiManager则管理和wifi相关的信息。
- `NetworkInfo`类包含了对wifi和mobile两种网络模式连接的详细描述,通过其getState()方法获取的State

添加权限
----------
想访问网络状态，首先得添加权限`<uses-permission android:name="android.permission.ACCESS_NETWORK_STATE"/>`  

获取系统的网络服务
----------
首先要获取到系统的网络服务
```
ConnectivityManager connManager = (ConnectivityManager) context.getSystemService(Context.CONNECTIVITY_SERVICE);
```
如果 connManager 为空,则是无网络.

获取网络类型
----------
获取当前网络类型，如果为空，返回无网络
```
NetworkInfo activeNetInfo = connManager.getActiveNetworkInfo();
```
判断 wifi
----------
判断是不是连接的是不是wifi
```
 NetworkInfo wifiInfo = connManager.getNetworkInfo(ConnectivityManager.TYPE_WIFI);
        if (null != wifiInfo) {
            NetworkInfo.State state = wifiInfo.getState();
            if (null != state)
                if (state == NetworkInfo.State.CONNECTED || state == NetworkInfo.State.CONNECTING) {
                    return NETWORN_WIFI;
                }
        }
```
判断是不是 2g 3g 4g 等
----------
如果不是wifi，则判断当前连接的是运营商的哪种网络2g、3g、4g等
```
 NetworkInfo networkInfo = connManager.getNetworkInfo(ConnectivityManager.TYPE_MOBILE);
        if (null != networkInfo) {
            NetworkInfo.State state = networkInfo.getState();
            String strSubTypeName = networkInfo.getSubtypeName();
            if (null != state)
                if (state == NetworkInfo.State.CONNECTED || state == NetworkInfo.State.CONNECTING) {
                    switch (activeNetInfo.getSubtype()) {
                        //如果是2g类型
                        case TelephonyManager.NETWORK_TYPE_GPRS: // 联通2g
                        case TelephonyManager.NETWORK_TYPE_CDMA: // 电信2g
                        case TelephonyManager.NETWORK_TYPE_EDGE: // 移动2g
                        case TelephonyManager.NETWORK_TYPE_1xRTT:
                        case TelephonyManager.NETWORK_TYPE_IDEN:
                            return NETWORN_2G;
                        //如果是3g类型
                        case TelephonyManager.NETWORK_TYPE_EVDO_A: // 电信3g
                        case TelephonyManager.NETWORK_TYPE_UMTS:
                        case TelephonyManager.NETWORK_TYPE_EVDO_0:
                        case TelephonyManager.NETWORK_TYPE_HSDPA:
                        case TelephonyManager.NETWORK_TYPE_HSUPA:
                        case TelephonyManager.NETWORK_TYPE_HSPA:
                        case TelephonyManager.NETWORK_TYPE_EVDO_B:
                        case TelephonyManager.NETWORK_TYPE_EHRPD:
                        case TelephonyManager.NETWORK_TYPE_HSPAP:
                            return NETWORN_3G;
                        //如果是4g类型
                        case TelephonyManager.NETWORK_TYPE_LTE:
                            return NETWORN_4G;
                        default:
                        //中国移动 联通 电信 三种3G制式
                            if (strSubTypeName.equalsIgnoreCase("TD-SCDMA") || strSubTypeName.equalsIgnoreCase("WCDMA") || strSubTypeName.equalsIgnoreCase("CDMA2000")) {
                                return NETWORN_3G;
                            } else {
                                return NETWORN_MOBILE;
                            }
                    }
                }
        }
```
由此就可以判断出 当前的网络连接类型了.
完整代码下载路径  <a href="https://github.com/lovexinforever/blog_back_up/blob/master/AppInfoUtils.java" >appinfoutils.java</a>