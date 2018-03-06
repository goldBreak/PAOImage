//
//  UI_Config.h
//  PAOImage
//
//  Created by xsd on 2018/3/6.
//  Copyright © 2018年 com.GF. All rights reserved.
//

#ifndef UI_Config_h
#define UI_Config_h

#define kDevice_Is_iPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)

#define kScreenHeight [UIScreen mainScreen].bounds.size.height      //获取设备的物理高度
#define kScreenWidth [UIScreen mainScreen].bounds.size.width        //获取设备的物理宽度

#define kStatusBarHeight [[UIApplication sharedApplication] statusBarFrame].size.height //状态栏高度
#define kNavBarHeight 44.0
#define kTabBarHeight (kStatusBarHeight>20?83:49) //底部tabbar高度
#define kTopHeight (kStatusBarHeight + kNavBarHeight) //整个导航栏高度


#endif /* UI_Config_h */
