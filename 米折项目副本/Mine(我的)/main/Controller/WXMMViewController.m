//
//  WXMMViewController.m
//  米折项目
//
//  Created by sh on 16/7/20.
//  Copyright © 2016年 王欣. All rights reserved.
//

#import "WXMMViewController.h"

#import "XMineTableViewCell.h"
#import "XMineTwoTableViewCell.h"
#import "XLoadingViewController.h"
#import "XRegisterViewController.h"

@interface WXMMViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSArray * _image_cell_arr;
    NSArray * _text_cell_arr;
}
@property(nonatomic,strong)UITableView * tableView;
@property(nonatomic,strong)UIView * headerView;


@end

@implementation WXMMViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
     self.view.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:self.tableView];
    [self registerCustomCell];
    [self registerCustomCellTwo];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    self.navigationController.navigationBar.hidden = YES;
    _image_cell_arr = @[@"ic_mine_group",@"ic_login_phone",@"ic_collection_red",@"ic_my_service"];
    _text_cell_arr = @[@"我的拼团",@"每日签到",@"我的收藏",@"联系客服"];
}



#pragma mark --- 注意:XIB自定义的cell需要注册 (必须注册) ---
- (void)registerCustomCell {
    //通常 我们将cell的类名作为nib的名字 原因在于类名的唯一性
    UINib * nib = [UINib nibWithNibName:@"XMineTableViewCell" bundle:nil];
    
    //用cell所在的tableView去按nib注册cell
    [self.tableView registerNib:nib forCellReuseIdentifier:@"XMineTableViewCell"];//Identifier 标识符
}

- (void)registerCustomCellTwo {
    //通常 我们将cell的类名作为nib的名字 原因在于类名的唯一性
    UINib * nib = [UINib nibWithNibName:@"XMineTwoTableViewCell" bundle:nil];
    
    //用cell所在的tableView去按nib注册cell
    [self.tableView registerNib:nib forCellReuseIdentifier:@"XMineTwoTableViewCell"];//Identifier 标识符
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    if (section == 0||section ==1) {
//        return 1;
//    }else if (section == 2){
//        return 4;
//    }else{
//        return 1;
//    }
    if (section == 2) {
        return 4;
    }else{
        return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        XMineTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"XMineTableViewCell"];
        
        if (!cell) {
            cell = [[XMineTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"XMineTableViewCell"];
        }
        return cell;
    }else if (indexPath.section == 1) {
        XMineTwoTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"XMineTwoTableViewCell"];
        
        if (!cell) {
            cell = [[XMineTwoTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"XMineTwoTableViewCell"];
        }
        return cell;
    }else {
        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"reuseID"];
        
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"reuseID"];
        }
        
        if (indexPath.section == 2) {
            cell.imageView.image = [UIImage imageNamed:_image_cell_arr[indexPath.row]];
            cell.textLabel.text = _text_cell_arr[indexPath.row];
        }else{
            cell.imageView.image = [UIImage imageNamed:@"ic_my_taobao_list"];
            cell.textLabel.text = @"淘宝返利";
        }
        
        
        return cell;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.00001;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0||indexPath.section == 1) {
        return 115;
    }else{
        return 45;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView * vi = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, 5)];
    vi.backgroundColor = [UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1.00];
    return vi;
}



- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, -24, SCREEN_WIDTH, SCREEN_HEIGHT+24) style:UITableViewStyleGrouped];
        _tableView.delegate   = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor orangeColor];
        _tableView.tableHeaderView = self.headerView;
    }
    return _tableView;
}

- (UIView *)headerView{
    if (!_headerView) {
        _headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 200)];
        _headerView.backgroundColor = SELECT_COLOR(247, 118, 0, 1);
        UIImageView * backgroud_imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 200)];
        backgroud_imageView.image = [UIImage imageNamed:@"my_bg"];
        backgroud_imageView.userInteractionEnabled = YES;
        [_headerView addSubview:backgroud_imageView];
        [self createButtonOfRegisterAndLoginWithSuperView:_headerView];
        [self createCollectionButtonWithSuperView:_headerView];
    }
    return _headerView;
}

- (void)createButtonOfRegisterAndLoginWithSuperView:(UIView *)superView{
    
    NSArray * text_arr = @[@"登录",@"注册"];
    
    for (int i =0 ; i < 2; i++) {
        UIButton * but  = [[UIButton alloc]init];
        if (i==0) {
            but.frame = CGRectMake(CURRENT_SIZE2(60) , CURRENT_SIZE2(85), 80, 30);
        }else{
            but.frame = CGRectMake(SCREEN_WIDTH / 2+CURRENT_SIZE2(20), CURRENT_SIZE2(85), 80, 30);
        }
        [but setTitle:text_arr[i] forState:UIControlStateNormal];
        [but setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        but.backgroundColor = [UIColor clearColor];
        [but addTarget:self action:@selector(butAction:) forControlEvents:UIControlEventTouchDown];
        but.tag = 100+i;
        but.layer.borderWidth = 1;
        but.layer.borderColor = [UIColor whiteColor].CGColor;
        but.layer.cornerRadius = 2;
        [superView addSubview:but];
    }
}

- (void)createCollectionButtonWithSuperView:(UIView *)superView{
    
    UIView * vi = [[UIView alloc]initWithFrame:CGRectMake(0, CURRENT_SIZE2(155), SCREEN_WIDTH, CURRENT_SIZE2(45))];
    
    NSArray * image_arr = @[@"ic_my_brand",@"ic_my_goods",@"ic_my_history",@"ic_my_qd"];
    NSArray * text_arr = @[@"收藏商品",@"收藏品牌",@"浏览记录",@"我的签到"];
    
    CGFloat  width = SCREEN_WIDTH/4.0;
    
    for (int i = 0; i < image_arr.count; i++) {
        UIView * small_vi = [[UIView alloc]initWithFrame:CGRectMake(width * i, 0, width, CURRENT_SIZE2(45))];
        
        UIImageView * imageV = [[UIImageView alloc]initWithFrame:CGRectMake(width/2-CURRENT_SIZE2(7), CURRENT_SIZE2(5), CURRENT_SIZE2(15), CURRENT_SIZE2(15))];
        imageV.image = [UIImage imageNamed:image_arr[i]];
        UILabel * lab = [[UILabel alloc]initWithFrame:CGRectMake(0, CURRENT_SIZE2(25), width, CURRENT_SIZE2(20))];
        lab.text = text_arr[i];
        lab.font = [UIFont systemFontOfSize:10];
        lab.textColor = [UIColor whiteColor];
        lab.textAlignment = NSTextAlignmentCenter;
        
        small_vi.tag =  200+i;
        
        [small_vi addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(smallViAction:)]];
        [small_vi addSubview:lab];
        [small_vi addSubview:imageV];
        [vi addSubview:small_vi];
        
    }
    
    
    vi.backgroundColor = [UIColor clearColor];
    [superView addSubview:vi];
}

-(void)butAction:(UIButton *)but{
    if (but.tag == 100) {
        NSLog(@"点击登录");
        XLoadingViewController * denglu = [[XLoadingViewController alloc]init];
        denglu.modalTransitionStyle = 2;
        [self presentViewController:denglu animated:YES completion:nil];
        
    }else{
        XRegisterViewController * denglu = [[XRegisterViewController alloc]init];
        denglu.modalTransitionStyle = 2;
        [self presentViewController:denglu animated:YES completion:nil];
        NSLog(@"点击注册");
    }
}

- (void)smallViAction:(UITapGestureRecognizer *)tap{
    switch (tap.view.tag - 200) {
        case 0:{
            NSLog(@"收藏商品");
            break;
        }
        case 1:{
            NSLog(@"收藏品牌");
            break;
        }
        case 2:{
            NSLog(@"记录");
            break;
        }
        case 3:{
            NSLog(@"签到");
            break;
        }
        default:
            break;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**
 我的拼团 ic_mine_group  每日签到   我的收藏 ic_collection_red 联系客服 ic_my_service ic_detail_consult
 
 全部订单 ic_my_all_orders  代付款ic_my_daifukuan  待收货ic_my_daishouhuo   待评价ic_my_daipingjia 我的售后ic_my_tuihuo
 我的钱包 ic_my_wallet
 
 淘宝返利 ic_my_taobao_list
 
 收藏品牌 ic_my_brand 收藏商品ic_my_goods 浏览记录ic_my_history 我的签到ic_my_qd
 */

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
