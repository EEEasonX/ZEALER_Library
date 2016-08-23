//
//  DetailViewController.m
//  MiZhe
//
//  Created by ading on 16/7/25.
//  Copyright © 2016年 阿鼎. All rights reserved.
//

#import "DetailViewController.h"

#import "WXNewViewController.h"

#import "DetailModel.h"

#import "DetailTableViewCell.h"


@interface DetailViewController ()<UITableViewDelegate,UITableViewDataSource>{
    
    BOOL _status_detail;
    
    BOOL _price_status;
    
    UIButton *_select_bt;
    
    UIButton *_moreBt;
    
    int _page;
}



@property(nonatomic,strong)MBProgressHUD *hud;

@property (weak, nonatomic) IBOutlet UILabel *label_title;

@property(nonatomic,strong)UITableView *tableview;

@property(nonatomic,strong)UIView *headerOfView;

@property(nonatomic,strong)UIImageView *big_imageview;
@property (nonatomic,strong)UIView * logo_View;

@property(nonatomic,strong)UIImageView *logo_imageview;

@property(nonatomic,strong)UILabel *brandLabel;

@property(nonatomic,strong)UILabel *num_label;

@property(nonatomic,strong)UILabel *detail_label;

@property(nonatomic,copy)NSDictionary *dic;

@property(nonatomic,strong)UIView *bt_view;

@property(nonatomic,copy)NSMutableArray *left_arr_data;

@property(nonatomic,strong)UILabel *header_label;

@property(nonatomic,strong)UIImageView *imageview;

@property(nonatomic,copy)NSMutableArray *right_arr_data;



@end

@implementation DetailViewController

- (void)viewDidLoad {
    self.view.backgroundColor=[UIColor cyanColor];
    
    
    _status_detail=YES;
    
    _price_status=YES;
    
    [super viewDidLoad];
    
    [self.view addSubview:self.tableview];
    
    [self addRefreshwithCatrgory:nil];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    
    self.navigationController.navigationBar.hidden=YES;
    self.tabBarController.tabBar.hidden=YES;
    
    _page = 1;
    [self loadDataWithPath:PATH_NEW_DETAIL(self.goods_id)];
    
}

- (IBAction)backButton:(id)sender {
    
[self.navigationController popViewControllerAnimated:YES];
    
}

- (IBAction)shareButton:(id)sender {
    
}



#pragma mark--------懒加载－－－－－－－－－
-(UITableView *)tableview{
    if (!_tableview) {
        _tableview=[[UITableView alloc]initWithFrame:CGRectMake(0,64, SCREEN_WIDTH, SCREEN_HEIGHT+CURRENT_SIZE(30)) style:UITableViewStylePlain];
        
        _tableview.delegate=self;
        
        _tableview.dataSource=self;
        
        _tableview.tableHeaderView=self.headerOfView;
    }
    return _tableview;
}

-(UIView *)headerOfView{
    if (!_headerOfView) {
        _headerOfView=[[UIView alloc]initWithFrame:CGRectMake(0, 0,SCREEN_WIDTH, 300)];
        _headerOfView.backgroundColor=[UIColor colorWithRed:0.97 green:0.97 blue:0.97 alpha:1.00];
        
        [self.headerOfView addSubview:self.big_imageview];
        
        [self.headerOfView addSubview:self.logo_imageview];
        
        [self.headerOfView addSubview:self.brandLabel];
        
        [self.headerOfView addSubview:self.num_label];
        [self.headerOfView addSubview:self.bt_view];
        
        UILabel *lab=[[UILabel alloc]initWithFrame:CGRectMake(self.num_label.frame.origin.x+self.num_label.frame.size.width, self.num_label.frame.origin.y, 80, 20)];
        
        lab.text=@"人已经购买";
        
        lab.textColor=[UIColor grayColor];
        
        lab.numberOfLines=0;
        
        lab.font=[UIFont systemFontOfSize:12];
        
        [self.headerOfView addSubview:lab];
        
        [self.headerOfView addSubview:self.detail_label];
        
        _moreBt=[[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2, self.detail_label.frame.size.height+self.detail_label.frame.origin.y+CURRENT_SIZE(5), CURRENT_SIZE(20), CURRENT_SIZE(10))];
        
        [_moreBt setBackgroundImage:[UIImage imageNamed:@"ic_cart_arrow_gray"] forState:UIControlStateNormal];
        
        [_moreBt addTarget:self action:@selector(showMoreActions:) forControlEvents:UIControlEventTouchDown];
        
        [self.headerOfView addSubview:_moreBt];
        
    }
    return _headerOfView;
    
}

-(UIImageView *)big_imageview{
    if (!_big_imageview) {
        _big_imageview=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 150)];
        
    }
          return _big_imageview;
}

-(UIImageView *)logo_imageview{
    if (!_logo_imageview) {
        _logo_imageview=[[UIImageView alloc]initWithFrame:CGRectMake(CURRENT_SIZE(10)   , CURRENT_SIZE(160), CURRENT_SIZE(67), CURRENT_SIZE(67))];
    }
    return _logo_imageview;
}

-(UILabel *)brandLabel{
    if (!_brandLabel) {
        _brandLabel=[[UILabel alloc]initWithFrame:CGRectMake(70, 160,80, 20)];
        
        _brandLabel.textColor=SELECT_COLOR(123, 123, 123, 1);
        _brandLabel.textAlignment=NSTextAlignmentCenter;
        _brandLabel.font=[UIFont systemFontOfSize:13];
    }
    return _brandLabel;
}

-(UILabel *)num_label{
    if (!_num_label) {
        _num_label=[[UILabel alloc]initWithFrame:CGRectMake(70, 180, 80, 20)];
        
        _num_label.textAlignment=NSTextAlignmentCenter;
        
        _num_label.textColor=[UIColor orangeColor];
        
        _num_label.font=[UIFont systemFontOfSize:12];
    }
    return _num_label;
    
}

-(UILabel *)detail_label{
    if (!_detail_label) {
        _detail_label=[[UILabel alloc]initWithFrame:CGRectMake(10, 200, SCREEN_WIDTH-20, 60)];
        
        _detail_label.textColor=SELECT_COLOR(93, 93, 93, 1);
        
        _detail_label.font=[UIFont systemFontOfSize:12];
        
        _detail_label.numberOfLines=2;
        
        _detail_label.lineBreakMode=NSLineBreakByClipping;
        
    }
    return _detail_label;
}

-(NSDictionary *)dic{
    if (!_dic) {
        _dic=[[NSDictionary alloc]init];
    }
    return _dic;
}

-(UIView *)bt_view{
    if (!_bt_view) {
        _bt_view=[[UIView alloc]initWithFrame:CGRectMake(0, self.detail_label.frame.origin.y+self.detail_label.frame.size.height+CURRENT_SIZE(20), SCREEN_WIDTH, 30)];
        NSArray *cateArr=@[@"综合",@"价格",@"销量",@"筛选"];
        for (int i=0; i<cateArr.count; i++) {
            UIButton *button=[[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/4*i, 0, SCREEN_WIDTH/4, 25)];
            button.tag=100+i;
            [button setTitle:cateArr[i] forState:UIControlStateNormal];
            [button.titleLabel setFont:[UIFont systemFontOfSize:15]];
            [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            if (i==0) {
                [button setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
                
                _select_bt=button;
                
            }
            [button addTarget:self action:@selector(selectButton:) forControlEvents:UIControlEventTouchDown];
            [self.bt_view addSubview:button];
        }
    }
    return _bt_view;
}

-(NSMutableArray *)left_arr_data{
    if (!_left_arr_data) {
        _left_arr_data=[[NSMutableArray alloc]init];
    }
    return _left_arr_data;
}

-(NSMutableArray *)right_arr_data{
    
    if (!_right_arr_data) {
        _right_arr_data=[[NSMutableArray alloc]init];
    }
    return _right_arr_data;
    
}

#pragma mark ------------- 点击事件 --------------
-(void)selectButton:(UIButton *)button{
    if (button.tag==103) {
        [button setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    }if (button.tag==101) {
        if (_price_status==YES) {
            [button setImage:[UIImage imageNamed:@"ic_price_down"] forState:UIControlStateNormal];
            
            [self.left_arr_data removeAllObjects];
            [self.right_arr_data removeAllObjects];
            [self loadDataWithPath:PATH_NEW_DETAIL_ASC(self.goods_id, 1, @"price_desc")];
            [self.tableview reloadData];
            
            [button setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
            button.imageEdgeInsets=UIEdgeInsetsMake(0,70, 0, 0);
            _price_status=NO;
        }else if(_price_status==NO){
            [button setImage:[UIImage imageNamed:@"ic_price_up"] forState:UIControlStateNormal];
            
            [self.left_arr_data removeAllObjects];
            [self.right_arr_data removeAllObjects];
            [self loadDataWithPath:PATH_NEW_DETAIL_ASC(self.goods_id, 1, @"price_asc")];
            [self.tableview reloadData];
            [button setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
            button.imageEdgeInsets=UIEdgeInsetsMake(0,70, 0, 0);
            _price_status=YES;
        }
    }
    if (button.tag == 102) {
        [self.left_arr_data removeAllObjects];
        [self.right_arr_data removeAllObjects];
        [self loadDataWithPath:PATH_NEW_DETAIL_ASC(self.goods_id, 1, @"sale_num")];
        [self.tableview reloadData];
    }
    if (button.tag == 100) {
        [self.left_arr_data removeAllObjects];
        [self.right_arr_data removeAllObjects];
        [self loadDataWithPath:PATH_NEW_DETAIL(self.goods_id)];
        [self.tableview reloadData];
    }
    
    if(button==_select_bt){
        return;
    }
    
    
    [button setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    
    [_select_bt setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    
    _select_bt=button;
    
    
}

//计算字符串的高度和长度
-(CGRect)rectWithText:(NSString *)text WithFontSize:(CGFloat)fontsize{
    NSDictionary *dic=@{NSFontAttributeName:[UIFont systemFontOfSize:fontsize]};
    CGSize size=CGSizeMake([UIScreen mainScreen].bounds.size.width, 3000);
    CGRect rect=[text boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil];
    return rect;
}

-(void)showMoreActions:(UIButton *)button{
    
    if (_status_detail==YES) {
        [button setBackgroundImage:[UIImage imageNamed:@"ic_cart_arrow_red"] forState:UIControlStateNormal];
        
        CGRect rect=[self rectWithText:[self.dic objectForKey:@"brand_story"] WithFontSize:12];
        
        _moreBt=[[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2, self.detail_label.frame.size.height+self.detail_label.frame.origin.y+CURRENT_SIZE(80), CURRENT_SIZE(20), CURRENT_SIZE(10))];
        
        self.detail_label.frame=CGRectMake(10,200, SCREEN_WIDTH-20,rect.size.height);
        
        self.headerOfView.frame=CGRectMake(0, 0, SCREEN_WIDTH, 300+rect.size.height-40);
        
        self.detail_label.numberOfLines=0;
        
        
        _status_detail=NO;
        
    }else if(_status_detail==NO){
        
        [button setBackgroundImage:[UIImage imageNamed:@"ic_cart_arrow_gray"] forState:UIControlStateNormal];
        
        self.headerOfView.frame=CGRectMake(0, 0,SCREEN_WIDTH, 300);
        
        self.detail_label.frame=CGRectMake(10, 200, SCREEN_WIDTH-20, 60);
        
        _moreBt=[[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2, self.detail_label.frame.size.height+self.detail_label.frame.origin.y+CURRENT_SIZE(5), CURRENT_SIZE(20), CURRENT_SIZE(10))];
        
        self.detail_label.numberOfLines=2;
        
        _detail_label.lineBreakMode=NSLineBreakByClipping;
        
        _status_detail=YES;
    }
    
    self.bt_view.frame=CGRectMake(0, self.detail_label.frame.origin.y+self.detail_label.frame.size.height+CURRENT_SIZE(5), SCREEN_WIDTH, 50);
    
    _tableview.tableHeaderView=self.headerOfView;
}
#pragma mark------协议方法－－－－－－－－－－－－

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    DetailTableViewCell *cell=[tableView cellForRowAtIndexPath:indexPath];
    
//    DetailTableViewCell     *cell=[[DetailTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"detail"];
    if (!cell) {
        cell = [[DetailTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"detail"];
    }
    
    if (self.left_arr_data > 0) {
        [cell addContentWithModel:self.left_arr_data[indexPath.row] RightModel:self.right_arr_data[indexPath.row] Tag:indexPath.row];
    }
    //设置点中状态的颜色
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    //去除（隐藏）cell的分割线
    tableView.separatorStyle =  NO;
    
    cell.block = ^(NSInteger tag){
        NSLog(@"点击了第几个%lu",tag);
    };
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPathP{
    
    return CURRENT_SIZE(240);
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.left_arr_data.count;
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, CURRENT_SIZE(20))];
    
    view.backgroundColor=[UIColor grayColor];
    
    self.header_label=[[UILabel alloc]initWithFrame:CGRectMake(CURRENT_SIZE(35), CURRENT_SIZE(2), CURRENT_SIZE(200), CURRENT_SIZE(15))];
    
    self.imageview=[[UIImageView alloc]initWithFrame:CGRectMake(CURRENT_SIZE(5), CURRENT_SIZE(2),CURRENT_SIZE(15), CURRENT_SIZE(15))];
      self.header_label.textColor=[UIColor whiteColor];
    
    self.header_label.textAlignment=NSTextAlignmentCenter;
    
   self.header_label.font=[UIFont systemFontOfSize:12];
    
    self.header_label.text=[self.dic objectForKey:@"mj_promotion"];
    [self.imageview sd_setImageWithURL:[NSURL URLWithString:[self.dic objectForKey:@"mj_icon"]] placeholderImage:nil];
    
    [view addSubview:self.imageview];
    
    [view addSubview:self.header_label];
    
    
    return view;
}

-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForHeaderInSection:(NSInteger)section{
    return 20;
}

#pragma mark--------数据请求－－－－－－

-(void)loadDataWithPath:(NSString *)path{
    
    [self.hud show:YES];
    
    AFHTTPSessionManager *manager=[AFHTTPSessionManager manager];
    manager.responseSerializer=[AFCompoundResponseSerializer serializer];
    
    [manager GET:path parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        NSLog(@"------请求成功");
        
        [self.hud hide:YES];
        
      self.dic=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        
        [self addHeaderOfContentWithDictionary:self.dic];
        
        NSArray *arr=[self.dic objectForKey:@"martshow_items"];
        
        [self analysisDataWithArr:arr];
        
        [self.tableview reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"请求失败");
    }];

}

#pragma mark-------解析数据－－－－－－－－－－－


-(void)analysisDataWithArr:(NSArray *)arr{
  
    int i=0;
    for (NSDictionary *dic in arr) {
        
        DetailModel *model=[[DetailModel alloc]init];
        
        model.product_id=[dic objectForKey:@"product_id"];
        
        model.img_name=[dic objectForKey:@"img"];
       
        model.product_title=[dic objectForKey:@"title"];
        
        model.price=[NSString stringWithFormat:@"%.2f",([[dic objectForKey:@"price"] floatValue])/100];
        
        model.sale_tip=[dic objectForKey:@"sale_tip"];
        
        if (i%2==0) {
            [self.left_arr_data addObject:model];
        }else{
            
            [self.right_arr_data addObject:model];
        }
        i++;
    }
}

-(void)addHeaderOfContentWithDictionary:(NSDictionary *)dic{
    
    self.label_title.text=[dic objectForKey:@"seller_title"];
    
    [self.big_imageview sd_setImageWithURL:[NSURL URLWithString:[dic objectForKey:@"main_img"]] placeholderImage:[UIImage imageNamed:@"default_loading_640-300"]];
    
    [self.logo_imageview sd_setImageWithURL:[NSURL URLWithString:[dic objectForKey:@"logo"]] placeholderImage:[UIImage imageNamed:@"img_loading_small@2x"]];
    
    self.brandLabel.text=[dic objectForKey:@"brand"];
    
    self.num_label.text=[NSString stringWithFormat:@"%@",[dic  objectForKey:@"show_item_total_sale_num" ]];
    
    self.detail_label.text=[dic objectForKey:@"brand_story"];
    
    
}

#pragma mark ------ 上拉加载 下拉刷新 ------
-(void)addRefreshwithCatrgory:(NSString *)categroy{
    MJRefreshNormalHeader * header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        //在该block代码块中，编写正在刷新的代码
        NSLog(@"资源正在刷新中..");
        //当上拉加载更多时 数据源中存放了好几页数据 而下拉刷新之后 要使得数据源中只有第一页数据
        [self.right_arr_data removeAllObjects];
        [self.left_arr_data removeAllObjects];
        
        [self loadDataWithPath:PATH_NEW_DETAIL_ASC(self.goods_id, _page, categroy)];
        
        _page = 1;
        
        //一段时间以后 停止刷新
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2*NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.tableview.header endRefreshing];
        });
        
    }];
    //添加下拉刷新
    self.tableview.header = header;
    
    //隐藏更新日期的那个label
    //header.lastUpdatedTimeLabel.hidden =YES;
    
    //根据下拉程度的不同，改变不同的标题
    header.automaticallyChangeAlpha =YES;
    
    //根据不同的状态，设置不同的标题
    [header setTitle:@"下拉可以刷新" forState:MJRefreshStateIdle];
    [header setTitle:@"松开立即刷新" forState:MJRefreshStatePulling];
    [header setTitle:@"正在刷新数据中..." forState:MJRefreshStateRefreshing];
    
    //上拉加载更多
    MJRefreshAutoNormalFooter * footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        //在这里完成上拉加载更多的代码编写
        NSLog(@"上拉加载更多");
        _page++;
       
        [self loadDataWithPath:PATH_NEW_DETAIL_ASC(self.goods_id, _page, categroy)];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.tableview.footer endRefreshing];
        });
        
    }];
    self.tableview.footer =footer;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
