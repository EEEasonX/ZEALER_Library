//
//  WXNNPViewController.m
//  米折项目
//
//  Created by sh on 16/7/20.
//  Copyright © 2016年 王欣. All rights reserved.
//

#import "WXNNPViewController.h"

#import "XLastViewController.h"
#import "XNNineViewController.h"
#import "XTNineViewController.h"
#import "XSelectionViewController.h"



@interface WXNNPViewController ()<UIScrollViewDelegate>
{
    UIButton * _temp_bt;
}
@property (nonatomic,strong)UILabel * lab;

@property (nonatomic,strong)UIScrollView * scrollView;

@property (nonatomic,strong)NSMutableArray * button_arr;
@end

@implementation WXNNPViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self createCategoryView];
    [self.view addSubview:self.scrollView];

}

- (void)createCategoryView{
    UIView * vi =  [[UIView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, CURRENT_SIZE(30))];
    
    NSArray * cate_arr = @[@"精选",@"9.9包邮",@"29.9包邮",@"最后疯抢"];
    CGRect  rect = [self rectWithText:@"精选" WithFountSize:15];
    float width = SCREEN_WIDTH/4.0;
    for (int i = 0; i < cate_arr.count; i++) {
        
        UIButton * bt = [[UIButton alloc] initWithFrame:CGRectMake(width * i, 0, width, 28)];
        [bt setTitle:cate_arr[i] forState:UIControlStateNormal];
        //非选中状态 字体颜色
        [bt setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        bt.titleLabel.font = [UIFont systemFontOfSize:15];
        bt.tag = 100 +i;
        
        [self.button_arr addObject:bt];
        
        [bt addTarget:self action:@selector(selectCategoryAction:) forControlEvents:UIControlEventTouchDown];
        
       //选中状态 字体颜色
        if (i == 0) {
            [bt setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
            _temp_bt = bt ;
            
            self.lab.frame = CGRectMake(bt.titleLabel.frame.origin.x-15 , 28, rect.size.width, 2);
            self.lab.backgroundColor = [UIColor orangeColor];
        }
        
        [vi addSubview:bt];
    }
    [vi addSubview:self.lab];
    [self.view addSubview:vi];
}

/** 类别的点击事件 */
- (void)selectCategoryAction:(UIButton *)bt{
    if (bt == _temp_bt) {
        return;
    }
    [bt setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    
    [_temp_bt setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _temp_bt = bt ;
    
    float x = SCREEN_WIDTH /4.0 * (bt.tag-100) +bt.titleLabel.frame.origin.x;
    
    CGRect rect = [self rectWithText:bt.titleLabel.text WithFountSize:15];
    [UIView animateWithDuration:0.3 animations:^{
        self.lab.frame = CGRectMake(x, 28, rect.size.width,2);
        /** 关联 button和scrollView */
        self.scrollView.contentOffset = CGPointMake(SCREEN_WIDTH * (bt.tag-100), 0);
        
    } completion:^(BOOL finished) {
        
    }];
}
/** 计算字符串长度的方法 */
- (CGRect)rectWithText:(NSString *)text WithFountSize:(CGFloat)fontSize
{
    NSDictionary * dic = @{NSFontAttributeName:[UIFont systemFontOfSize:fontSize]};
    CGSize size = CGSizeMake([UIScreen mainScreen].bounds.size.width, 3000);
    CGRect rect = [text boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil];
    return rect;
}

#pragma mark ----------- 懒加载 ---------------
-(UIScrollView *)scrollView{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 94, SCREEN_WIDTH, SCREEN_HEIGHT-49)];
        
        XLastViewController * last = [[XLastViewController alloc]init];
        XNNineViewController * nn = [[XNNineViewController alloc]init];
        XTNineViewController * tnn = [[XTNineViewController alloc]init];
        XSelectionViewController * selection =[[XSelectionViewController alloc]init];
        
        [self addChildViewController:last];
        [self addChildViewController:nn];
        [self addChildViewController:tnn];
        [self addChildViewController:selection];
        
        NSArray * arr_view = @[selection.view, nn.view, tnn.view, last.view];
        for (int i = 0;  i < arr_view.count; i++) {
            UIView  * view = arr_view[i];
            view.frame = CGRectMake(SCREEN_WIDTH * i, 0, SCREEN_WIDTH , SCREEN_HEIGHT-94-49);
            [_scrollView addSubview:arr_view[i]];
            
        }
        _scrollView.contentSize = CGSizeMake(SCREEN_WIDTH * arr_view.count, SCREEN_HEIGHT - 94-49);
        _scrollView.pagingEnabled = YES;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.contentOffset = CGPointMake(0, 0);
        _scrollView.delegate = self;
    }
    return _scrollView;
}

- (UILabel *)lab{
    if (!_lab) {
        _lab = [[UILabel alloc]init];
        _lab.backgroundColor = [UIColor orangeColor];
    }
    return _lab;
}

- (NSMutableArray *)button_arr{
    if (!_button_arr) {
        _button_arr = [NSMutableArray array];
    }
    return _button_arr;
}

//当scrollview减速完成时 调用该方法
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    //获取第几页
    int page = scrollView.contentOffset.x / SCREEN_WIDTH;
    
    //从数组中拿出当前scrollview的button
    UIButton * bt = (UIButton *)self.button_arr[page];
    //设置连续两次无法点击同一个
    if (bt == _temp_bt) {
        return;
    }
    
    [bt setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    
    [_temp_bt setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    _temp_bt = bt;
    
    float x = SCREEN_WIDTH /4.0 * (bt.tag-100) +bt.titleLabel.frame.origin.x;
    
    CGRect rect = [self rectWithText:bt.titleLabel.text WithFountSize:15];
    [UIView animateWithDuration:0.3 animations:^{
        self.lab.frame = CGRectMake(x, 28, rect.size.width,2);
        /** 关联 button和scrollView */
        self.scrollView.contentOffset = CGPointMake(SCREEN_WIDTH * (bt.tag-100), 0);
        
    }];
    
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
