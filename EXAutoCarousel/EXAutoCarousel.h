//
//  EXAutoCarousel.h
//  SuBoSports
//
//  Created by Mango on 15/8/8.
//  e-mail : eeeeeeasonx@gmail.com
//  weixin : JrMarco-x
//  Copyright © 2016年 EEEasonX. All rights reserved.
//

/**
 * 说明：该demo依赖 SDWebImage 和 AFNetworking 这两个第三方库

 */
#pragma mark ----------tag 初始值为 100 --------------
#import <UIKit/UIKit.h>

//代理
@protocol EXAutoCarouselDelegate <NSObject>

//根据tag值推出新的页面
- (void)pushViewController:(NSInteger)tag;

@end

@interface EXAutoCarousel : UIViewController

//给代理起别名
@property (nonatomic,weak) id <EXAutoCarouselDelegate> delegate;

/**
 * 时间控制器
 * 可以调用该时间控制器来决定是否执行自动轮播
 */
@property (nonatomic,strong) NSTimer * timer;

/**
 * 该方法创建轮播图 scrollView
 * parma: rect 规定 scrollView 位置
 * parma: superView 承载 scrollView 父视图
 * parma: imageUrlArr 存放网络请求图片地址的数组
 * parma: imageName 占位图的名字
 * parma: interval 轮播时间 间隔的意思
 */
- (void)createCarouselWithFrame:(CGRect)rect
                      superView:(UIView *)superView
                    imageUrlArr:(NSArray *)imageUrlArr
           placeholderImageName:(NSString *)imageName
                       interval:(NSInteger)interval;

/**
 * 该方法创建界面控制器 pageControl
 * parma: rect 规定 pageControl 位置
 * parma: superView 承载 pageControl 父视图
 * parma: pageNum 设置 pageControl 页数，通常情况下是数据源数组的元素个数
 * parma: unselectedColor 非选中状态页面颜色
 * parma: selectedColor 选中状态页面颜色
 */
- (void)createPageControlWithFrame:(CGRect)rect
                         superView:(UIView *)superView
                           pageNum:(NSInteger)pageNum
                   unselectedColor:(UIColor *)unselectedColor
                     selectedColor:(UIColor *)selectedColor;

/**
 * 该方法用来创建时间控制器
 * parma: interval 设置页面跳转时间间隔
 */
- (void)createTimerWithTimeInterval:(NSInteger)interval;

@end
