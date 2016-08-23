//
//  UITabBarController+WXExtension.m
//  米折项目
//
//  Created by sh on 16/7/20.
//  Copyright © 2016年 王欣. All rights reserved.
//

#import "UITabBarController+WXExtension.h"

@implementation UITabBarController (WXExtension)

-(void)addViewController:(UIViewController *)controller title:(NSString *)title imageName:(NSString *)imageName seletedImageName:(NSString *)selectedImageName{
    
    //设置标题
    controller.title = title;
    
    //创建导航视图控制器
    UINavigationController * nav = [[UINavigationController alloc]initWithRootViewController:controller];
    
    UIImage * originalImage = [UIImage imageNamed:imageName];
    
    if (iOS7_OR_LATER) {
        originalImage = [originalImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    }
    
    UIImage * selectedImage = [UIImage imageNamed:selectedImageName];
    
    if (iOS7_OR_LATER) {
        selectedImage = [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    }
    
    nav.tabBarItem = [[UITabBarItem alloc]initWithTitle:title image:originalImage selectedImage:selectedImage];
    
    
    
    [self addChildViewController:nav];
    
}


@end
