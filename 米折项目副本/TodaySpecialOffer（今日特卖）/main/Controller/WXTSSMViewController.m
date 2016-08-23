//
//  WXTSSMViewController.m
//  米折项目
//
//  Created by sh on 16/7/20.
//  Copyright © 2016年 王欣. All rights reserved.
//

#import "WXTSSMViewController.h"

#import "WXBabyViewController.h"
#import "WXYesterdayViewController.h"
#import "WXParpareViewController.h"
#import "WXDelicacyViewController.h"
#import "WXBeautyViewController.h"
#import "WXHomedailyViewController.h"

#import "WXNvZhuangViewController.h"

#import "WXShoebagViewController.h"
#import "WXNewViewController.h"
#import "WXShowHTMLViewController.h"



@interface WXTSSMViewController ()<UIScrollViewDelegate>
{
    //用这两个中间变量 来接受点击后的控件
    UIView * _temp_view;
    UIButton * _fount_button;
 
}

@property(nonatomic,strong)UIScrollView * categaryScroll;

//文本下划线
@property(nonatomic,strong)UILabel * label;

@property(nonatomic,strong)UIScrollView * controllerScroll;

//存放所有文本button的数组
@property(nonatomic,copy)NSMutableArray * button_arr;

//红包数据源
@property(nonatomic,strong)NSMutableArray * red_dataSource;

//底部视图背景
@property(nonatomic,strong)UIView * backgroundView;

//加载动画
@property(nonatomic,strong)MBProgressHUD * hud;

@end

@implementation WXTSSMViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.categaryScroll];
    [self.view addSubview:self.controllerScroll];
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [self loadData];
    self.navigationController.navigationBarHidden = YES;
    self.tabBarController.tabBar.hidden = NO;
}

#pragma mark ------ 点击事件 ------
-(void)changeControllerAction:(UIButton *)bt{
    //设置连续两次无法点击同一个
    if (bt == _fount_button) {
        return;
    }
   
    
    [bt setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    //设置上一个按钮为非选中状态
    [_fount_button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    //重新设置选中状态的按钮
    _fount_button = bt;
    
    
    
    [UIView animateWithDuration:0.3 animations:^{
        self.label.frame = CGRectMake(bt.superview.frame.origin.x, 28, bt.frame.size.width,2);
         self.controllerScroll.contentOffset = CGPointMake(SCREEN_WIDTH * (bt.tag - 100), 0);
    } completion:^(BOOL finished) {
        
    }];
    
}

-(void)receiveRedAction:(UITapGestureRecognizer *)tap{
    NSLog(@"点击了领红包");
    //记录领取红包的界面出现过
    [[NSUserDefaults standardUserDefaults] setObject:@(YES) forKey:@"WX_USER_RED_BAG"];
    
    self.backgroundView.hidden = YES;
    
    WXShowHTMLViewController * sh = [[WXShowHTMLViewController alloc]init];
    
    sh.HTML_PATH = [self.red_dataSource.firstObject objectForKey:@"target"];
    
    sh.custom_title = [self.red_dataSource.firstObject objectForKey:@"title"];
    [self.navigationController pushViewController:sh animated:YES];

    
}

-(void)notReceiveRedAction:(UIButton *)bt{
    
    //记录领取红包的界面出现过
    [[NSUserDefaults standardUserDefaults] setObject:@(YES) forKey:@"WX_USER_RED_BAG"];

    self.backgroundView.hidden = YES;
    
}

#pragma mark ------ 支持方法 ------
//计算字符串的高度和长度
-(CGRect)rectWithText:(NSString *)text WithFontSize:(CGFloat)fontSize{
    NSDictionary * dic = @{NSFontAttributeName:[UIFont systemFontOfSize:fontSize]};
    CGSize size = CGSizeMake([UIScreen mainScreen].bounds.size.width, 3000);
    CGRect rect = [text boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil];
    return rect;
}

#pragma mark ------ 懒加载 ------
-(UIScrollView *)categaryScroll{
    if (!_categaryScroll) {
        _categaryScroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, 30)];
        _categaryScroll.backgroundColor = [UIColor whiteColor];
       
        NSArray * text_arr =@[@"上新",@"女装",@"鞋包",@"居家",@"美妆",@"美食",@"母婴童装",@"昨日热卖",@"下期预告"];
        //每个文字的位置是前面字符串长度的和
        float sum_x =10;
        
        CGRect  rect01 = [self rectWithText:text_arr.firstObject WithFontSize:15];
        //label的起始位置
        self.label = [[UILabel alloc]initWithFrame:CGRectMake(10, 28, rect01.size.width, 3)];
        self.label.backgroundColor = [UIColor orangeColor];
        
        
        for (int i =0; i<text_arr.count; i++) {
            
            CGRect rect = [self rectWithText:text_arr[i] WithFontSize:15];
            UIView * vi = [[UIView alloc]initWithFrame:CGRectMake(sum_x, 0, rect.size.width, 30)];
            vi.backgroundColor = [UIColor whiteColor];
            UIButton * bt =[[UIButton alloc]initWithFrame:CGRectMake(0, 0, vi.frame.size.width, 30)];
            [bt setTitle:text_arr[i] forState:UIControlStateNormal];
            [bt addTarget:self action:@selector(changeControllerAction:) forControlEvents:UIControlEventTouchDown];
            bt.titleLabel.font = [UIFont systemFontOfSize:15];
            [bt setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            
            bt.tag = 100+i;
            
            [self.button_arr addObject:bt];
            
            if (i == 0) {
               
                [bt setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
                _fount_button = bt;
                _temp_view = vi;
                
            }
            
            [vi addSubview:bt];
            
            sum_x += rect.size.width + 20;
            
            [_categaryScroll addSubview:vi];
            
        }
        //能容纳的大小
        _categaryScroll.contentSize = CGSizeMake(sum_x, 30);
        //默认显示位置
        _categaryScroll.contentOffset = CGPointMake(0, 0);
        //隐藏滚动条
        _categaryScroll.showsHorizontalScrollIndicator = NO;
        
        
        [_categaryScroll addSubview:self.label];
        
    }
    return _categaryScroll;
}

-(UIScrollView *)controllerScroll{
    if (!_controllerScroll) {
        _controllerScroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 94, SCREEN_WIDTH, SCREEN_HEIGHT-94-49)];
        
        WXNewViewController * new =[[WXNewViewController alloc]init];
        [self addChildViewController:new];
        
        WXNvZhuangViewController * womens =[[WXNvZhuangViewController alloc]init];
        [self addChildViewController:womens];
        
        WXShoebagViewController * shoebag =[[WXShoebagViewController alloc]init];
        [self addChildViewController:shoebag];
        
        WXHomedailyViewController * homedaily =[[WXHomedailyViewController alloc]init];
        [self addChildViewController:homedaily];
        
        WXBeautyViewController * beauty =[[WXBeautyViewController alloc]init];
        [self addChildViewController:beauty];
        
        WXDelicacyViewController * delicacy =[[WXDelicacyViewController alloc]init];
        [self addChildViewController:delicacy];
        
        WXBabyViewController * baby =[[WXBabyViewController alloc]init];
        [self addChildViewController:baby];
        
        WXYesterdayViewController * yesterday =[[WXYesterdayViewController alloc]init];
        [self addChildViewController:yesterday];
        
        WXParpareViewController * parpare =[[WXParpareViewController alloc]init];
        [self addChildViewController:parpare];
        
        NSArray * controller_arr = @[new.view,womens.view,shoebag.view,homedaily.view,beauty.view,delicacy.view,baby.view,yesterday.view,parpare.view];
        int i = 0;
        for (UIView * view in controller_arr) {
            view.frame = CGRectMake(SCREEN_WIDTH * i, 0, SCREEN_WIDTH, SCREEN_HEIGHT-94-49);
            [_controllerScroll addSubview:view];
            i++;
        }
        //设置代理
        _controllerScroll.delegate = self;
        //设置能容纳的大小
        _controllerScroll.contentSize = CGSizeMake(SCREEN_WIDTH * controller_arr.count, SCREEN_HEIGHT-94-49);
        //设置起始位置
        _controllerScroll.contentOffset = CGPointMake(0, 0);
        //设置翻页
        _controllerScroll.pagingEnabled = YES;
        _controllerScroll.showsHorizontalScrollIndicator = NO;
        
    }
    return _controllerScroll;
}

-(NSMutableArray *)button_arr{
    if (!_button_arr) {
        _button_arr = [[NSMutableArray alloc]init];
        
    }
    return _button_arr;
}

-(NSMutableArray *)red_dataSource{
    if (!_red_dataSource) {
        _red_dataSource = [[NSMutableArray alloc]init];
        
    }
    return _red_dataSource;
}

-(UIView *)backgroundView{
    if (!_backgroundView) {
        _backgroundView = [[UIView alloc]initWithFrame:[UIScreen mainScreen].bounds];
        _backgroundView.backgroundColor = SELECT_COLOR(124, 124, 124, 0.5);
        
        UIImageView * imageV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 200, 200)];
        //放在屏幕中间
        imageV.center = self.view.center;
        [imageV sd_setImageWithURL:[NSURL URLWithString:[self.red_dataSource.firstObject objectForKey:@"img"]] placeholderImage:[UIImage imageNamed:@"default_loading_100x100"]];
        //打开交互 添加点击事件
        imageV.userInteractionEnabled = YES;
        
        [imageV addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(receiveRedAction:)]];
        
        [_backgroundView addSubview:imageV];
        
        UIButton * bt = [[UIButton alloc]initWithFrame:CGRectMake(CURRENT_SIZE(170), 0, 30, 30)];
       
        [bt setTitle:@"X" forState:UIControlStateNormal];
        [bt setBackgroundColor:[UIColor blackColor]];
        [bt setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        bt.layer.cornerRadius = 15;
        [bt addTarget:self action:@selector(notReceiveRedAction:) forControlEvents:UIControlEventTouchDown];
        
        [imageV addSubview:bt];
        
    }
    return _backgroundView;
}

-(MBProgressHUD *)hud{
    if (!_hud) {
        _hud = [[MBProgressHUD alloc]initWithView:self.view];
        _hud.labelText = @"加载中...";
    
        [self.view addSubview:_hud];
    }
    return _hud;
}
#pragma mark ------ scrollView的协议方法 ------
//当scrollview减速完成时 调用该方法
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    //获取第几页
    int page = scrollView.contentOffset.x / SCREEN_WIDTH;
    
    //从数组中拿出当前scrollview的button
    UIButton * bt = (UIButton *)self.button_arr[page];
    //设置连续两次无法点击同一个
    if (bt == _fount_button) {
        return;
    }
    
    [bt setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    
    [_fount_button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _fount_button =bt;
   [UIView animateWithDuration:0.3 animations:^{
       self.label.frame =CGRectMake( bt.superview.frame.origin.x, 28, bt.frame.size.width, 2);

       if (page > 5) {
           self.categaryScroll.contentOffset = CGPointMake(25 * page, 0);
       }else{
           self.categaryScroll.contentOffset = CGPointMake(0, 0);
       }
       
       
   } completion:^(BOOL finished) {
       
   }];

}


#pragma mark ------ 数据请求 ------
-(void)loadData{
    //数据请求之前显示加载动画
    [self.hud show:YES];
    
     AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
     manager.responseSerializer = [AFCompoundResponseSerializer serializer];
    
    [manager GET:PATH_NEW parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
     
        //关闭加载动画
        [self.hud hide:YES];
        
        NSDictionary * down_dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        self.red_dataSource = [down_dic objectForKey:@"popup_ads"];
        
        //数据请求成功之后加在父视图(tabBar)上
        [self.tabBarController.view addSubview:self.backgroundView];
        
        BOOL red_ret = [[[NSUserDefaults standardUserDefaults]objectForKey:@"WX_USER_RED_BAG"]boolValue];
        
        
        if (red_ret == YES) {
            self.backgroundView.hidden = YES;
        }
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    
    
}










- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
