//
//  AutoCarusel.m
//  驴妈妈
//
//  Created by sh on 16/6/21.
//  Copyright © 2016年 王欣. All rights reserved.
//

#import "AutoCarusel.h"
#import "UIImageView+WebCache.h"

@interface AutoCarusel ()<UIScrollViewDelegate>

@property(nonatomic,strong)UIScrollView * scrollView;

//页面控制
@property(nonatomic,strong)UIPageControl * pageControl;

@end

@implementation AutoCarusel

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)createCaruseWithFrame:(CGRect)rect WithImageUrlArr:(NSArray *)imageUrlArr WithSuperView:(UIView *)superView WithPlaceholederImage:(NSString *)imageName WithInterval:(NSInteger)interval{
    self.scrollView = [[UIScrollView alloc]initWithFrame:rect];
    
    self.scrollView.backgroundColor = [UIColor yellowColor];
    
    for (int i = 0; i<imageUrlArr.count + 2; i++) {
        UIImageView * imageV = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH * i, 0, SCREEN_WIDTH, self.scrollView.frame.size.height)];
        if (i == 0) {
            [imageV sd_setImageWithURL:[NSURL URLWithString:imageUrlArr.lastObject] placeholderImage:[UIImage imageNamed:imageName]];
        }else if (i == imageUrlArr.count + 1){
            [imageV sd_setImageWithURL:[NSURL URLWithString:imageUrlArr.firstObject] placeholderImage:[UIImage imageNamed:imageName]];

        }else{
            [imageV sd_setImageWithURL:[NSURL URLWithString:imageUrlArr[i-1]] placeholderImage:[UIImage imageNamed:imageName]];

        }
        imageV.tag = 10000 + i;
        
        imageV.userInteractionEnabled = YES;
        
        [imageV addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageViewGestureAction:)]];
        
        [self.scrollView addSubview:imageV];
    }
     self.scrollView.delegate = self;
    self.scrollView.pagingEnabled = YES;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.contentSize = CGSizeMake(SCREEN_WIDTH * (imageUrlArr.count+2), self.scrollView.frame.size.height);
    self.scrollView.contentOffset = CGPointMake(SCREEN_WIDTH, 0);
       
    [self createTimerWithTimeInterval:interval];
    [superView addSubview:self.scrollView];
}

- (void)imageViewGestureAction:(UITapGestureRecognizer *)tap{
    [self.delegate pushNextWith:tap.view.tag - 10000];
       // self.imageActionBlock(tap.view.tag - 10000);
}

- (void)createPageControlWithFrame:(CGRect)rect WithSuperView:(UIView *)superView WithPageNum:(NSInteger)pageNum WithCurrentColor:(UIColor *)currentColor WithTintColor:(UIColor *)tintColor{
    
    self.pageControl = [[UIPageControl alloc] initWithFrame:rect];
    
    self.pageControl.currentPageIndicatorTintColor = tintColor;
    
    self.pageControl.pageIndicatorTintColor = currentColor;
    
    self.pageControl.numberOfPages = pageNum;
    
    [superView addSubview:self.pageControl];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    NSLog(@"这里开始拖动");
    [self.timer setFireDate:[NSDate distantFuture]];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    
    [self.timer setFireDate:[NSDate distantPast]];
}


- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    if (scrollView == self.scrollView) {
        NSInteger maxPage = scrollView.contentSize.width / scrollView.frame.size.width;
        NSInteger page = scrollView.contentOffset.x / scrollView.frame.size.width;
        if (page == 1) {
            
            scrollView.contentOffset = CGPointMake(self.scrollView.frame.size.width * (maxPage - 1), 0);
            self.pageControl.currentPage = maxPage - 2;
            
        }else if (page == maxPage - 1){
            scrollView.contentOffset = CGPointMake(self.scrollView.frame.size.width, 0);
            self.pageControl.currentPage = 0;
        }else{
            self.pageControl.currentPage = page - 1;
        }
    }
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    [self scrollViewDidEndDecelerating:scrollView];
}

- (void)createTimerWithTimeInterval:(NSInteger)interval{
    
    self.timer = [[NSTimer alloc] init];
    
    self.timer = [NSTimer timerWithTimeInterval:interval target:self selector:@selector(changePage) userInfo:nil repeats:YES];
    
    [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}

- (void)changePage{
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
