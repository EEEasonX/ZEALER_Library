//
//  WXWSViewController.m
//  米折项目
//
//  Created by sh on 16/7/20.
//  Copyright © 2016年 王欣. All rights reserved.
//

#import "WXWSViewController.h"
#import "XProvinceViewController.h"

#import "XPTJvViewController.h"
#import "XPTMeiViewController.h"
#import "XPTNewViewController.h"
#import "XPTFoodViewController.h"
#import "XPTNextViewController.h"
#import "XPTChildViewController.h"
#import "XPTFreshViewController.h"
#import "XPTClothesViewController.h"



@interface WXWSViewController ()<UIScrollViewDelegate>
{
    UIButton * _temp_bt;
    float _sum_x;
}

@property (weak, nonatomic) IBOutlet UIButton *Province;

@property (nonatomic,strong)UIView * up_category_vi;
@property (nonatomic,strong)UIScrollView * up_scrollView;
@property (nonatomic,strong)UILabel * up_lab;
@property (nonatomic,copy)NSMutableArray * bt_arr;
@property (nonatomic,strong)UIScrollView * down_scrollView;
@end

@implementation WXWSViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.up_category_vi];
    [self.view addSubview:self.down_scrollView];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    self.tabBarController.tabBar.hidden = NO;
    self.navigationController.navigationBar.hidden = YES;
    [self.Province setTitle:[[NSUserDefaults standardUserDefaults]objectForKey:@"X_Province_User"] forState:UIControlStateNormal];
}

- (IBAction)ProvinceAction:(UIButton *)sender {
    XProvinceViewController *province = [[XProvinceViewController alloc]init];
    [self.navigationController pushViewController: province animated:YES];
    
}
#pragma mark ---------- 懒加载 --------------
- (UIView *)up_category_vi{
    if (!_up_category_vi) {
        _up_category_vi =  [[UIView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, 30)];
        _up_category_vi.backgroundColor = [UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1.00];
        [_up_category_vi addSubview:self.up_scrollView];
        [self.up_scrollView addSubview:self.up_lab];
    }
    return _up_category_vi;
}

- (UILabel *)up_lab{
    if (!_up_lab) {
        _up_lab = [[UILabel alloc]init];
    }
    return _up_lab;
}

- (UIScrollView *)up_scrollView{
    if (!_up_scrollView) {
        _up_scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 30)];
        NSArray * cate_arr = @[@"上新",@"生鲜",@"食品",@"居家",@"美妆",@"母婴",@"服饰",@"下期预告"];
        _sum_x = 15;
        
        for (int i = 0; i < cate_arr.count; i++) {
            CGRect  rect = [self rectWithText:cate_arr[i] WithFountSize:15];
            
            UIButton * bt = [[UIButton alloc] initWithFrame:CGRectMake(_sum_x, 0, rect.size.width, 28)];
            
            [bt setTitle:cate_arr[i] forState:UIControlStateNormal];
            [bt setTitleColor:[UIColor colorWithRed:0.27 green:0.27 blue:0.27 alpha:1.00] forState:UIControlStateNormal];
            if (i == 0) {
                [bt setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
                _temp_bt = bt;
                self.up_lab.frame = CGRectMake(bt.frame.origin.x-3, 28, bt.frame.size.width + 6, 2);
                self.up_lab.backgroundColor = [UIColor orangeColor];
            }
            [bt addTarget:self action:@selector(btAction:) forControlEvents:UIControlEventTouchDown];
            bt.titleLabel.font = [UIFont systemFontOfSize:15];
            bt.tag = 100 +i;
            
            [self.bt_arr addObject:bt];
            
            [_up_scrollView addSubview:bt];
            [_up_scrollView addSubview:self.up_lab];
            
            _sum_x = _sum_x + 15 +rect.size.width;
            
        }
        //能容纳的大小
        _up_scrollView.contentSize = CGSizeMake(_sum_x, 30);
        //默认显示位置
        _up_scrollView.contentOffset = CGPointMake(0, 0);
        //隐藏滚动条
        _up_scrollView.showsHorizontalScrollIndicator = NO;
    }
    
    return _up_scrollView;
}

-(UIScrollView *)down_scrollView{
    if (!_down_scrollView) {
        _down_scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 94, SCREEN_WIDTH, SCREEN_HEIGHT-94-49)];
        
        XPTNewViewController * new =[[XPTNewViewController alloc]init];
        [self addChildViewController:new];
        
        XPTFreshViewController * fresh =[[XPTFreshViewController alloc]init];
        [self addChildViewController:fresh];
        XPTFoodViewController * food =[[XPTFoodViewController alloc]init];
        [self addChildViewController:food];
        XPTJvViewController * jv =[[XPTJvViewController alloc]init];
        [self addChildViewController:jv ];
        XPTMeiViewController * mei =[[XPTMeiViewController alloc]init];
        [self addChildViewController:mei ];
        XPTChildViewController * child =[[XPTChildViewController alloc]init];
        [self addChildViewController:child ];
        
        XPTClothesViewController * clothes = [[XPTClothesViewController alloc]init];
        [self addChildViewController:clothes];
        XPTNextViewController * next =[[XPTNextViewController alloc]init];
        [self addChildViewController:next ];
        
        NSArray * down_scrollV_arr = @[new.view,fresh.view,food.view,jv.view,mei.view,child.view,clothes.view,next.view];
        for (int i =0; i< down_scrollV_arr.count; i++) {
            UIView * vi = down_scrollV_arr[i];
            vi.frame = CGRectMake(SCREEN_WIDTH * i, 0, SCREEN_WIDTH, SCREEN_HEIGHT-94-49);
            [_down_scrollView addSubview:vi];
            
        }
        
        _down_scrollView.delegate = self;
        //设置能容纳的大小
        _down_scrollView.contentSize = CGSizeMake(SCREEN_WIDTH * down_scrollV_arr.count, SCREEN_HEIGHT-94-49);
        //设置起始位置
        _down_scrollView.contentOffset = CGPointMake(0, 0);
        //设置翻页
        _down_scrollView.pagingEnabled = YES;
        _down_scrollView.showsHorizontalScrollIndicator = NO;
    }
    return _down_scrollView;
}

-(NSMutableArray *)bt_arr{
    if (!_bt_arr) {
        _bt_arr = [NSMutableArray array];
    }
    return _bt_arr;
}

#pragma mark ---------- 点击事件 --------------

- (void)btAction:(UIButton *)but{
    if (_temp_bt == but) {
        return;
    }
    [but setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [_temp_bt setTitleColor:[UIColor colorWithRed:0.27 green:0.27 blue:0.27 alpha:1.00] forState:UIControlStateNormal];
    _temp_bt = but;
    
    [UIView animateWithDuration:0.3 animations:^{
        self.up_lab.frame = CGRectMake(but.frame.origin.x-3, 28, but.frame.size.width+6, 2);
        
        self.down_scrollView.contentOffset = CGPointMake(SCREEN_WIDTH * (but.tag -100), 0);
        
        if (but.tag == 106) {
            self.up_scrollView.contentOffset = CGPointMake(_sum_x - SCREEN_WIDTH, 0);
        }else if (but.tag == 107) {
            self.up_scrollView.contentOffset = CGPointMake(_sum_x - SCREEN_WIDTH, 0);
        }else{
            self.up_scrollView.contentOffset = CGPointMake(0, 0);
        }
        
    } completion:^(BOOL finished) {
        
    }];
    
}

#pragma mark ---------- scrollView 的协议方法 --------------
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    int page = self.down_scrollView.contentOffset.x / SCREEN_WIDTH ;
    UIButton * but = (UIButton *)self.bt_arr[page];
    if (_temp_bt == but) {
        return;
    }
    
    [but setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [_temp_bt setTitleColor:[UIColor colorWithRed:0.27 green:0.27 blue:0.27 alpha:1.00] forState:UIControlStateNormal];
    _temp_bt = but;
    
    [UIView animateWithDuration:0.3 animations:^{
        self.up_lab.frame = CGRectMake(but.frame.origin.x-3, 28, but.frame.size.width+6, 2);
        
        if (but.tag == 106) {
            self.up_scrollView.contentOffset = CGPointMake(_sum_x - SCREEN_WIDTH, 0);
        }else if (but.tag == 107) {
            self.up_scrollView.contentOffset = CGPointMake(_sum_x - SCREEN_WIDTH, 0);
        }else{
            self.up_scrollView.contentOffset = CGPointMake(0, 0);
        }
    } completion:^(BOOL finished) {
        
    }];
}


#pragma mark ---------- 获取字符串长度的方法 --------------
- (CGRect)rectWithText:(NSString *)text WithFountSize:(CGFloat)fontSize
{
    NSDictionary * dic = @{NSFontAttributeName:[UIFont systemFontOfSize:fontSize]};
    CGSize size = CGSizeMake([UIScreen mainScreen].bounds.size.width, 3000);
    CGRect rect = [text boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil];
    return rect;
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
