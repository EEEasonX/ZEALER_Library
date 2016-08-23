//
//  AppDelegate.m
//  米折项目
//
//  Created by sh on 16/7/20.
//  Copyright © 2016年 王欣. All rights reserved.
//

#import "AppDelegate.h"
#import "UITabBarController+WXExtension.h"

#import "WXBCViewController.h"
#import "WXMMViewController.h"
#import "WXWSViewController.h"
#import "WXNNPViewController.h"
#import "WXTSSMViewController.h"
#import "WXGuidePageViewController.h"


@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    
    [self.window makeKeyAndVisible];
    
    self.window.backgroundColor = [UIColor whiteColor];
    
    
    
    BOOL ret = [[[NSUserDefaults standardUserDefaults] objectForKey:@"WX_USER_GUIDE_STATUS"] boolValue];
    
    if (ret == YES) {
        
        //说明引导页已经出现过
        [self setWindowRootViewController];
        
    }else{
        
        self.window.rootViewController = [[WXGuidePageViewController alloc]init];
    }
    
    return YES;
}

//设置跟视图控制器
-(void)setWindowRootViewController{
    
    UITabBarController * tab =[[UITabBarController alloc]init];
    
    //今日特卖
    WXTSSMViewController * tssm = [[WXTSSMViewController alloc]init];
    [tab addViewController:tssm title:@"今日特卖" imageName:@"btn_nav_home" seletedImageName:@"btn_nav_home_selected"];
    
    //9.9包邮
    WXNNPViewController * nnp = [[WXNNPViewController alloc]init];
    [tab addViewController:nnp title:@"9.9包邮" imageName:@"btn_nav_99" seletedImageName:@"btn_nav_99_selected"];
    
    //拼团
    WXWSViewController * ws =[[WXWSViewController alloc]init];
    [tab addViewController:ws title:@"拼团" imageName:@"ic_fight" seletedImageName:@"ic_fight_fill"];
    
    //购物车
    WXBCViewController * bc = [[WXBCViewController alloc]init];
    [tab addViewController:bc title:@"购物车" imageName:@"btn_nav_cart" seletedImageName:@"btn_nav_cart_selected"];
    
    
    //我的
    WXMMViewController * mm = [[WXMMViewController alloc]init];
    [tab addViewController:mm title:@"我的" imageName:@"btn_nav_mine" seletedImageName:@"btn_nav_mine_selected"];
    
    tab.tabBar.tintColor = [UIColor colorWithRed:0.96 green:0.53 blue:0.20 alpha:1.00];
    
    self.window.rootViewController = tab;
    
}



- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
