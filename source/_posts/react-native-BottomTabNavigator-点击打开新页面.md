---
title: react native BottomTabNavigator 点击打开新页面
date: 2019-10-10 15:22:15
tags:
- react native
- rn
- bottomtabnavigator
categories: 
- Technology
- ReactNative
---

   最近用rn 做项目, 需要一个需求, 底部tab  中间的tab 不是切换页面, 是跳转到新页面.
   <!-- more -->

   查了下 api文档

   ```
   screen: CompanyJobManager,
        navigationOptions: {
            tabBarLabel: " ",
            tabBarIcon: ({tintColor, focused}) => (
                <Image source={require('./images/add.png')} resize="contains"
                       style={{width: 40, height: 40, marginTop: 10}}/>
            ),
            tabBarOnPress: ({navigation, defaultHandle}) => {
                navigation.push('PostJob', {isUpdate: false})
            }
        },
   ```
