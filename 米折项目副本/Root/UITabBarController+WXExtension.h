//
//  UITabBarController+WXExtension.h
//  米折项目
//
//  Created by sh on 16/7/20.
//  Copyright © 2016年 王欣. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITabBarController (WXExtension)

/**
 *快速添加跟视图控制器的方法
 */

-(void)addViewController:(UIViewController *)controller
                   title:(NSString *)title
               imageName:(NSString *)imageName
        seletedImageName:(NSString *)selectedImageName;

@end
