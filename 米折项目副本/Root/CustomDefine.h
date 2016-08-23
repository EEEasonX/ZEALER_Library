//
//  CustomDefine.h
//  米折项目
//
//  Created by sh on 16/7/20.
//  Copyright © 2016年 王欣. All rights reserved.
//

#ifndef CustomDefine_h
#define CustomDefine_h

/**
 *defin: 颜色设置的宏定义
 *prame: _r --> RGB的红
 *prame: _g --> RGB的绿
 *prame: _b --> RGB的蓝
 *prame: _alpha --> RGB的透明度
 */

#define SELECT_COLOR(_r,_g,_b,_alpha) [UIColor colorWithRed:_r/255.0 green:_g/255.0 blue:_b/255.0 alpha:_alpha]

/**
 *define：获取屏幕的宽
 */

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width


/**
 *define：获取屏幕的高
 */

#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height


/**
 *define：iOS 7.0的版本判断
 */

#define iOS7_OR_LATER  [UIDevice currentDevice].systemVersion.floatValue >=7.0

/**
 *define：iOS 8.0的版本判断
 */

#define iOS8_OR_LATER  [UIDevice currentDevice].systemVersion.floatValue >=8.0


/**
 *define：屏幕适配
 */

#define CURRENT_SIZE(_size) (_size/375.f) * SCREEN_WIDTH

#define CURRENT_SIZE2(_size) (_size/320.f) * SCREEN_WIDTH







#endif /* CustomDefine_h */
