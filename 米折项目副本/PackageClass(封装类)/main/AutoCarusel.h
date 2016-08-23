//
//  AutoCarusel.h
//  驴妈妈
//
//  Created by sh on 16/6/21.
//  Copyright © 2016年 王欣. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AutoCaruselDelegate <NSObject>

-(void)pushNextWith:(NSInteger)tag;

@end

@interface AutoCarusel : UIViewController

/**
 *时间控制器
 *可以调用该时间控制器来决定是否执行自动轮播
 */
@property(nonatomic,strong)NSTimer * timer;

@property(nonatomic,weak)id<AutoCaruselDelegate>delegate;

/** 定义图片点击事件的block */
//@property(nonatomic,copy)void(^imageActionBlock)(NSInteger imageTag);



/**
 *该方法创建了scrollview
 *prama: rect          scrollView的位置
 *prama: imageUrlArr   存放网络请求图片的数组
 *prama: superView     要承载scrollView的父视图
 *prama: imageName     占位图的名字
 *parma: interval      轮播时间
 */
-(void)createCaruseWithFrame:(CGRect)rect
             WithImageUrlArr:(NSArray *)imageUrlArr
               WithSuperView:(UIView *)superView
       WithPlaceholederImage:(NSString *)imageName
                WithInterval:(NSInteger)interval;


/**
 *该方法创建pageControl界面控制器
 *parma: rect  规定pageControl的位置
 *parma: superView   承载pageControl的父视图
 *parma: pageNum 设置pageControl的页数，通常情况下是数据源数组的元素个数
 *parma: currentColor 非选中状态页面颜色
 *parma: tintColor 选中状态页面颜色
 */
- (void)createPageControlWithFrame:(CGRect)rect
                     WithSuperView:(UIView *)superView
                       WithPageNum:(NSInteger)pageNum
                  WithCurrentColor:(UIColor *)currentColor
                     WithTintColor:(UIColor *)tintColor;

/**
 *该方法用来创建时间控制器
 *parma: interval 设置页面跳转时间间隔
 */
- (void)createTimerWithTimeInterval:(NSInteger)interval;




@end
