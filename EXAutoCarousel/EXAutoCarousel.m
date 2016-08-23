//
//  EXAutoCarousel.m
//  SuBoSports
//
//  Created by Mango on 15/8/8.
//  e-mail : eeeeeeasonx@gmail.com
//  weixin : JrMarco-x
//  Copyright © 2016年 EEEasonX. All rights reserved.
//

#import "EXAutoCarousel.h"
#import "UIImageView+WebCache.h"

@interface EXAutoCarousel () <UIScrollViewDelegate>

/** 定义全局变量 */
@property(nonatomic,strong)UIScrollView * scrollView;

/** 页面控制 */
@property(nonatomic,strong)UIPageControl * pageControl;

@end

@implementation EXAutoCarousel

- (void)viewDidLoad {
    [super viewDidLoad];
}

//该方法创建轮播图
- (void)createCarouselWithFrame:(CGRect)rect
                      superView:(UIView *)superView
                    imageUrlArr:(NSArray *)imageUrlArr
           placeholderImageName:(NSString *)imageName
                       interval:(NSInteger)interval
{
    self.scrollView = [[UIScrollView alloc] initWithFrame:rect];
    
    for (int i = 0; i < imageUrlArr.count + 2; i++) {
        
        UIImageView * imageV = [[UIImageView alloc] initWithFrame:CGRectMake(self.scrollView.frame.size.width * i, 0, self.scrollView.frame.size.width, self.scrollView.frame.size.height)];
        
        if (i == 0) {
            
            [imageV sd_setImageWithURL:[NSURL URLWithString:[imageUrlArr lastObject]] placeholderImage:[UIImage imageNamed:imageName]];
            
        } else if (i == imageUrlArr.count + 1){
            
            [imageV sd_setImageWithURL:[NSURL URLWithString:[imageUrlArr firstObject]] placeholderImage:[UIImage imageNamed:imageName]];
            
        } else {
            
            [imageV sd_setImageWithURL:[NSURL URLWithString:imageUrlArr[i - 1]] placeholderImage:[UIImage imageNamed:imageName]];
        
        }
        
        imageV.tag = 100 + i;
        
        //打开图片交互
        imageV.userInteractionEnabled = YES;
        
        //给图片创建点击事件
        [imageV addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageViewGestureAction:)]];
        
        [self.scrollView addSubview:imageV];
    }
    
    self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width * (imageUrlArr.count + 2), self.scrollView.frame.size.height);
    
    self.scrollView.contentOffset = CGPointMake(self.scrollView.frame.size.width, 0);
    
    self.scrollView.delegate = self;
    
    self.scrollView.showsHorizontalScrollIndicator = NO;
    
    //设置翻页
    self.scrollView.pagingEnabled = YES;
    
    [self createTimerWithTimeInterval:interval];
    
    [superView addSubview:self.scrollView];
}

//图片点击事件
- (void)imageViewGestureAction:(UITapGestureRecognizer *)tap
{
    [self.delegate pushViewController:tap.view.tag];
}

//该方法创建界面控制器
- (void)createPageControlWithFrame:(CGRect)rect
                         superView:(UIView *)superView
                           pageNum:(NSInteger)pageNum
                   unselectedColor:(UIColor *)unselectedColor
                     selectedColor:(UIColor *)selectedColor
{
    self.pageControl = [[UIPageControl alloc] initWithFrame:rect];
    
    //图片显示圆点的颜色
    self.pageControl.currentPageIndicatorTintColor = selectedColor;
    
    //图片未显示圆点的颜色
    self.pageControl.pageIndicatorTintColor = unselectedColor;
    
    //设置指示器圆点个数
    self.pageControl.numberOfPages = pageNum;
    
    [superView addSubview:self.pageControl];
}

//减速结束的协议方法
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (scrollView == self.scrollView) {
        NSInteger maxPage = scrollView.contentSize.width / scrollView.frame.size.width;
        
        NSInteger page = scrollView.contentOffset.x / scrollView.frame.size.width;
        if (page == 0) {
            
            scrollView.contentOffset = CGPointMake(self.scrollView.frame.size.width * (maxPage - 1), 0);
            
            self.pageControl.currentPage = maxPage - 2;
            
        } else if (page == maxPage - 1) {
            
            scrollView.contentOffset = CGPointMake(self.scrollView.frame.size.width, 0);
            self.pageControl.currentPage = 0;
        } else {
            
            self.pageControl.currentPage = page - 1;
        }
    }
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    
    [self scrollViewDidEndDecelerating:scrollView];
    
}

//该方法用来创建时间控制器
- (void)createTimerWithTimeInterval:(NSInteger)interval
{
    
    self.timer = [[NSTimer alloc] init];
    
    self.timer = [NSTimer timerWithTimeInterval:interval target:self selector:@selector(changePage) userInfo:nil repeats:YES];
    
    [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}

- (void)changePage
{
    NSInteger maxPage = self.scrollView.contentSize.width / self.scrollView.frame.size.width;
    
    NSInteger page = self.scrollView.contentOffset.x / self.scrollView.frame.size.width;
    
    if (page == maxPage) {
        page = 0;
    }
    
    page++;
    
    [self.scrollView setContentOffset:CGPointMake(self.scrollView.frame.size.width * page, 0) animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
    [self.timer invalidate];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
