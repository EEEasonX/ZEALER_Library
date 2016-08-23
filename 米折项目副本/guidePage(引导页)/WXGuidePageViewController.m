//
//  WXGuidePageViewController.m
//  米折项目
//
//  Created by sh on 16/7/20.
//  Copyright © 2016年 王欣. All rights reserved.
//

#import "WXGuidePageViewController.h"
#import "AppDelegate.h"

@interface WXGuidePageViewController ()

@property(nonatomic,strong)UIScrollView * scrollView;

@end

@implementation WXGuidePageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.scrollView];
}

-(UIScrollView *)scrollView{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc]initWithFrame:self.view.frame];
        
        for (int i =0; i<4; i++) {
            UIImageView * imageV = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH * i, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
            
            imageV.image = [UIImage imageNamed:[NSString stringWithFormat:@"introduced%03d",i+1]];
            
            if (i==3) {
                //打开图片事件交互
                imageV.userInteractionEnabled = YES;
                [imageV addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showMainViewController:)]];
            
            }
            
            [_scrollView addSubview:imageV];
        }
                 
        _scrollView.contentSize = CGSizeMake(SCREEN_WIDTH * 4, SCREEN_HEIGHT);
        _scrollView.contentOffset = CGPointMake(0, 0);
        _scrollView.pagingEnabled = YES;
        _scrollView.showsHorizontalScrollIndicator = NO;
        
    }
    return _scrollView;
}

//当点击了最后一张引导页时，应该显示主界面
-(void)showMainViewController:(UITapGestureRecognizer *)tap{
    NSLog(@"点击了最后一张引导页");
    
    //获取AppDelegate类的对象，它的对象是一个单例类的对象
    AppDelegate * app = [UIApplication sharedApplication].delegate;
    
    //切换跟视图
    [app setWindowRootViewController];
    
    //设置一个引导页已经运行过的标志 并把这个标志保存到本地
    [[NSUserDefaults standardUserDefaults] setObject:@(YES) forKey:@"WX_USER_GUIDE_STATUS"];
    
    //为了防止这种本地数据持久化的方式没有及时的将数据保存，添加如下代码，一般不写也不错，最好写上
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    
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
