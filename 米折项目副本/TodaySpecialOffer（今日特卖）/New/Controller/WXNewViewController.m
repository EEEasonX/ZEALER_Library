//
//  WXNewViewController.m
//  米折项目
//
//  Created by sh on 16/7/20.
//  Copyright © 2016年 王欣. All rights reserved.
//

#import "WXNewViewController.h"

#import "AutoCarusel.h"

#import "WXShowHTMLViewController.h"

#import "WXNewNineModel.h"

#import "WXNienNewTableViewCell.h"

#import "DetailViewController.h"

@interface WXNewViewController ()<UITableViewDelegate,UITableViewDataSource,AutoCaruselDelegate,UIScrollViewDelegate>
{
    int _page;
    //记录cell的个数
    NSInteger _num_cell;
    UILabel * up_lab;
}

@property(nonatomic,strong)UITableView * tableView;

/** tableView的头视图 */
@property(nonatomic,strong)UIView * headerView;

/** 米折活动的视图 */
@property(nonatomic,strong)UIView * MZAcvicityView;

/** 限量秒杀的视图 */
@property(nonatomic,strong)UIView * seckillingView;

/** 显示第几个cell的视图 */
@property(nonatomic,strong)UIView * showNumCell;

/** 置顶按钮 */
@property(nonatomic,strong)UIButton * setTop_button;


/** 9.9源抢爆款 */
@property(nonatomic,strong)UIImageView * NineNineImageV;

@property(nonatomic,strong)MBProgressHUD * hud;


/** 广告页数据源数组 */
@property(nonatomic,strong)NSMutableArray * ads_dataSource;

/** 米折活动的数据源数组 */
@property(nonatomic,strong)NSArray * acv_dataSource;

/** 限量秒杀的数据源数组 */
@property(nonatomic,strong)NSArray * sec_dataSource;

/** 9.9元抢爆款的数据源数组 */
@property(nonatomic,strong)NSArray * nn_dataSource;

/** 9点上新的数据源 */
@property(nonatomic,strong)NSMutableArray * nineNew_dataSource;



@end

@implementation WXNewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.setTop_button];
    [self.view addSubview:self.showNumCell];
    [self addRefresh];
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [self loadData];
    [self loadNewNineDataWithPath:PATH_NEW_NINE(1)];
   
    _page = 1;

}

-(void)viewWillDisAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [self.nineNew_dataSource removeAllObjects];
}
#pragma mark ------ tableView的协议方法 ------
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.nineNew_dataSource.count;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return CURRENT_SIZE(215);
}

-(WXNienNewTableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    WXNienNewTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"reuseID"];
   
    //复用 节省内存
    if (!cell) {
        cell = [[WXNienNewTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"reuseID"];
    }
    //渲染
    WXNewNineModel * model = self.nineNew_dataSource[indexPath.row];
    [cell addContentForCellWithModel:model];

    //当界面即将出现第indexPath.row cell时，将这个值 赋给全局变量
    _num_cell = indexPath.row;
    //当界面滑动结束之后 再加载数据 防止界面卡顿
    if (self.tableView.dragging == NO && self.tableView.decelerating == NO) {
           }
    
    
     return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    DetailViewController * newDetail = [[DetailViewController alloc]init];
    WXNewNineModel * model = self.nineNew_dataSource[indexPath.row];
    newDetail.goods_id = model.martshows_id;
    
    [self.navigationController pushViewController:newDetail animated:YES];
}

//减速完成时
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    if (_num_cell >10) {
        self.setTop_button.hidden = NO;
        self.showNumCell.hidden = YES;
    }else{
        self.setTop_button.hidden =YES;
        self.showNumCell.hidden = YES;
    }
    
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    self.showNumCell.hidden = YES;
    if (_num_cell > 10) {
        self.setTop_button.hidden = YES;
        self.showNumCell.hidden = NO;
        up_lab.text = [NSString stringWithFormat:@"%ld",_num_cell];
    }
}

#pragma mark ------ 懒加载 ------
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-94-49) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableHeaderView = self.headerView;
        
    }
    return _tableView;
}

-(UIView *)headerView{
    if (!_headerView) {
        _headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, CURRENT_SIZE(565))];
        _headerView.backgroundColor = SELECT_COLOR(221, 221, 221, 1);
        
        UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(0, CURRENT_SIZE(535), SCREEN_WIDTH, CURRENT_SIZE(30))];
        label.text =@"- 今日特卖·每天9点上新 -";
        label.font = [UIFont systemFontOfSize:12];
        label.textAlignment = NSTextAlignmentCenter;
        label.backgroundColor = [UIColor whiteColor];
        label.textColor = [UIColor blackColor];
        
        [_headerView addSubview:label];
    }
    return _headerView;
}

-(MBProgressHUD *)hud{
    if (!_hud) {
        _hud = [[MBProgressHUD alloc]initWithView:self.view];
        _hud.labelText = @"加载中...";
        
        [self.view addSubview:_hud];
    }
    return _hud;
}

-(NSMutableArray *)ads_dataSource{
    if (!_ads_dataSource) {
        _ads_dataSource = [[NSMutableArray alloc]init];
        
    }
    return _ads_dataSource;
}

-(UIView *)MZAcvicityView{
    if (!_MZAcvicityView) {
        _MZAcvicityView = [[UIView alloc]initWithFrame:CGRectMake(0, CURRENT_SIZE(120), SCREEN_WIDTH, CURRENT_SIZE(80))];
        _MZAcvicityView.backgroundColor = [UIColor whiteColor];
        
    }
    return _MZAcvicityView;
}

-(NSArray *)acv_dataSource{
    if (!_acv_dataSource) {
        _acv_dataSource = [[NSArray alloc]init];
    }
    return _acv_dataSource;
}

-(UIView *)seckillingView{
    if (!_seckillingView) {
        _seckillingView = [[UIView alloc]initWithFrame:CGRectMake(0, CURRENT_SIZE(205), SCREEN_WIDTH, CURRENT_SIZE(200))];
        _seckillingView.backgroundColor =[UIColor purpleColor];
        
    }
    return _seckillingView;
}


-(NSArray *)sec_dataSource{
    if (!_sec_dataSource) {
        _sec_dataSource = [[NSArray alloc]init];
        
    }
    return _sec_dataSource;
}

-(UIImageView *)NineNineImageV{
    if (!_NineNineImageV) {
        _NineNineImageV = [[UIImageView alloc]initWithFrame:CGRectMake(0, CURRENT_SIZE(410), SCREEN_WIDTH, CURRENT_SIZE(120))];
        
        
    }
    return _NineNineImageV;;
}


-(NSArray *)nn_dataSource{
    if (!_nn_dataSource) {
        _nn_dataSource = [[NSArray alloc]init];
    }
    return _nn_dataSource;
}

-(NSMutableArray *)nineNew_dataSource{
    if (!_nineNew_dataSource) {
        _nineNew_dataSource = [[NSMutableArray alloc]init];
        
    }
    return _nineNew_dataSource;
}

-(UIButton *)setTop_button{
    if (!_setTop_button) {
        _setTop_button = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-CURRENT_SIZE(65), SCREEN_HEIGHT/2 + CURRENT_SIZE(95), CURRENT_SIZE(60), CURRENT_SIZE(60))];
        [_setTop_button setBackgroundImage:[UIImage imageNamed:@"c2c_ic_dianpu_zhiding"] forState:UIControlStateNormal];
        [_setTop_button addTarget:self action:@selector(setTopAction:) forControlEvents:UIControlEventTouchDown];
         _setTop_button.hidden = YES;
        
    }
    return _setTop_button;
}

-(UIView *)showNumCell{
    if (!_showNumCell) {
        _showNumCell = [[UIView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-CURRENT_SIZE(65), SCREEN_HEIGHT/2 + CURRENT_SIZE(95), CURRENT_SIZE(60), CURRENT_SIZE(60))];
        
        _showNumCell.layer.cornerRadius = CURRENT_SIZE(30);
        _showNumCell.backgroundColor =[UIColor whiteColor];
        
        up_lab =[[UILabel alloc]initWithFrame:CGRectMake(CURRENT_SIZE(10), CURRENT_SIZE(5), CURRENT_SIZE(40), CURRENT_SIZE(30))];
        
        up_lab.font = [UIFont systemFontOfSize:18];
        up_lab.textAlignment = NSTextAlignmentCenter;
        up_lab.textColor = [UIColor blackColor];
        
        [_showNumCell addSubview:up_lab];

        
        UILabel * line_lab = [[UILabel alloc]initWithFrame:CGRectMake(2, CURRENT_SIZE(30), CURRENT_SIZE(56), CURRENT_SIZE(1))];
        line_lab.backgroundColor = [UIColor blackColor];
        
        [_showNumCell addSubview:line_lab];
        
        UILabel * down_lab = [[UILabel alloc]initWithFrame:CGRectMake(CURRENT_SIZE(10), CURRENT_SIZE(30), CURRENT_SIZE(40), CURRENT_SIZE(30))];
        
        down_lab.font = [UIFont systemFontOfSize:15];
        down_lab.textAlignment = NSTextAlignmentCenter;
        down_lab.textColor = [UIColor blackColor];
        down_lab.text = @"380";
        [_showNumCell addSubview:down_lab];
        
        _showNumCell.hidden = YES;
        
        
    }
    return _showNumCell;
}

#pragma mark ------ 点击事件 ------
/** 米折活动的点击事件 */
-(void)MZAcvicityAction:(UITapGestureRecognizer * )tap{
    if ([[self.acv_dataSource[tap.view.tag - 200]objectForKey:@"target"] length] > 20) {
        WXShowHTMLViewController * sh = [[WXShowHTMLViewController alloc]init];
        sh.HTML_PATH = [self.acv_dataSource[tap.view.tag - 200]objectForKey:@"target"];
        sh.custom_title = [self.acv_dataSource[tap.view.tag - 200] objectForKey:@"title"];
        [self.navigationController pushViewController:sh animated:YES];
    }else{
        NSLog(@"推出另一个界面");
    }
    
}

/** 限量秒杀的点击事件 */
-(void)seckingAction:(UITapGestureRecognizer *)tap{
    
    NSLog(@"点击了限量秒杀");
    if ([[self.sec_dataSource[tap.view.tag - 300]objectForKey:@"target"] length] > 20) {
        WXShowHTMLViewController * sh = [[WXShowHTMLViewController alloc]init];
        sh.HTML_PATH = [self.sec_dataSource[tap.view.tag - 300]objectForKey:@"target"];
        sh.custom_title = [self.sec_dataSource[tap.view.tag - 300] objectForKey:@"title"];
        [self.navigationController pushViewController:sh animated:YES];
    }else{
        NSLog(@"推出另一个界面");
    }

}

/** 9.9元抢爆款的点击事件 */
-(void)nineNineAction:(UITapGestureRecognizer *)tap{
    WXShowHTMLViewController * sh = [[WXShowHTMLViewController alloc]init];
    sh.HTML_PATH = [self.nn_dataSource.firstObject objectForKey:@"target"];
    sh.custom_title = [self.nn_dataSource.firstObject objectForKey:@"title"];
    [self.navigationController pushViewController:sh animated:YES];

}

/** 置顶按钮的点击事件 */
-(void)setTopAction:(UIButton *)but{
    self.tableView.contentOffset = CGPointMake(0, 0);
    _setTop_button.hidden = YES;

}

#pragma mark ------ 创建头视图内容的方法 ------
/** 创建轮播图的方法 */
-(void)createAdsPageWithArr:(NSMutableArray *)source{
    
    NSMutableArray * arr = [[NSMutableArray alloc]init];
    for (NSDictionary * dic in source) {
        [arr addObject:[dic objectForKey:@"img"]];
    }
    
    
    AutoCarusel * aut =[[AutoCarusel alloc]init];
    //图
    [aut createCaruseWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, CURRENT_SIZE(120)) WithImageUrlArr:arr WithSuperView:self.headerView WithPlaceholederImage:@"default_loading_640-300" WithInterval:3];
    //点
    [aut createPageControlWithFrame:CGRectMake(CURRENT_SIZE2(100), CURRENT_SIZE(100), SCREEN_WIDTH, 20) WithSuperView:self.headerView WithPageNum:arr.count WithCurrentColor:[UIColor orangeColor] WithTintColor:[UIColor whiteColor]];
    aut.delegate =self;
    
}

-(void)pushNextWith:(NSInteger)tag{
    
    WXShowHTMLViewController * sh = [[WXShowHTMLViewController alloc]init];
    sh.HTML_PATH = [self.ads_dataSource[tag-1] objectForKey:@"target"];
    sh.custom_title = [self.ads_dataSource[tag-1] objectForKey:@"title"];
    [self.navigationController pushViewController:sh animated:YES];
    
}

/** 创建米折活动的方法 */
-(void)createMZActivityWithArr:(NSArray *)source{
    [self.headerView addSubview:self.MZAcvicityView];
    int i = 0;
    for (NSDictionary * dic in source) {
        UIView * vi = [[UIView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH /5 *i , 0, SCREEN_WIDTH / 5, CURRENT_SIZE(80))];
        
        UIImageView * imageV = [[UIImageView alloc]initWithFrame:CGRectMake(CURRENT_SIZE(18), CURRENT_SIZE(10), CURRENT_SIZE(40), CURRENT_SIZE(40))];
       
        [imageV sd_setImageWithURL:[dic objectForKey:@"img"] placeholderImage:[UIImage imageNamed:@"default_avatar_img"]];
        
        imageV.userInteractionEnabled = YES;
        //添加点击事件
        [imageV addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(MZAcvicityAction:)]];
        imageV.tag = 200 + i;
        
        UILabel * label =[[UILabel alloc]initWithFrame:CGRectMake(0, CURRENT_SIZE(55), SCREEN_WIDTH / 5, CURRENT_SIZE(15))];
        label.text = [dic objectForKey:@"desc"];
        label.font = [UIFont systemFontOfSize:10];
        label.textColor = [UIColor blackColor];
        label.textAlignment = NSTextAlignmentCenter;
        [vi addSubview:label];
        [vi addSubview:imageV];
        
        
        [self.MZAcvicityView addSubview:vi];
        i++;
    }
    
}

/** 创建限量秒杀的方法 */
-(void)createSeckillingWithArr:(NSArray *)source{
    
    [self.headerView addSubview:self.seckillingView];
    
    for (int i = 0; i<source.count; i++) {
        UIImageView * imageV = [[UIImageView alloc]init];
        if (i==0) {
            imageV.frame=CGRectMake(0, 0, SCREEN_WIDTH / 2, CURRENT_SIZE(200));
        }else if (i==1){
            imageV.frame =CGRectMake(SCREEN_WIDTH / 2, 0, SCREEN_WIDTH / 2, CURRENT_SIZE(200)/3+10);
        }else{
            imageV.frame = CGRectMake(SCREEN_WIDTH /2 +(SCREEN_WIDTH / 4 * (i-2)), CURRENT_SIZE(200)/3+10, SCREEN_WIDTH /4, CURRENT_SIZE(200)/3 *2-10);
        }
        
        [imageV sd_setImageWithURL:[NSURL URLWithString:[source[i] objectForKey:@"img"]]placeholderImage:[UIImage imageNamed:@"default_loading_320-320"]];
        
        imageV.userInteractionEnabled = YES;
        
        imageV.tag = 300 + i;
        
        [imageV addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(seckingAction:)]];
        
        
        [self.seckillingView addSubview:imageV];
    }
    
}

/** 创建9.9元抢爆款 */
-(void)createNineNineWithArr:(NSArray *)source{
    [self.headerView addSubview:self.NineNineImageV];
    
    [self.NineNineImageV sd_setImageWithURL:[NSURL URLWithString:[source.firstObject objectForKey:@"img"]] placeholderImage:[UIImage imageNamed:@"default_loading_310-120"]];
    self.NineNineImageV.userInteractionEnabled = YES;
    
    [self.NineNineImageV addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(nineNineAction:)]];
    
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
        
        self.ads_dataSource = [down_dic objectForKey:@"ads"];
        self.acv_dataSource = [down_dic objectForKey:@"mizhe_shortcuts"];
        self.sec_dataSource = [down_dic objectForKey:@"promotion_shortcuts"];
        self.nn_dataSource = [down_dic objectForKey:@"home_header_banners"];
        
        
        [self createAdsPageWithArr:self.ads_dataSource];
        [self createMZActivityWithArr:self.acv_dataSource];
        [self createSeckillingWithArr:self.sec_dataSource];
        [self createNineNineWithArr:self.nn_dataSource];
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    

}

-(void)loadNewNineDataWithPath:(NSString *)path{
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFCompoundResponseSerializer serializer];
    
    [manager GET:path parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        
        NSDictionary * down_dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        
        NSArray * new_arr =[[NSArray alloc]init];
        new_arr = [down_dic objectForKey:@"mz_martshows"];
        [self analysisDataWithArr:new_arr];
     
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"请求失败");
        
    }];

}

#pragma mark ------ 解析上新cell数据的方法 ------
-(void)analysisDataWithArr:(NSArray *)arr{
    
    for (NSDictionary * dic in arr) {
        WXNewNineModel * model = [[WXNewNineModel alloc]init];
        model.martshows_id = [dic objectForKey:@"event_id"];
        model.martshows_title = [dic objectForKey:@"title"];
        model.martshows_mjpromotion = [dic objectForKey:@"mj_promotion"];
        model.martshows_end = [dic objectForKey:@"gmt_end"];
                model.martshows_img_tr = [dic objectForKey:@"label_img_tr"];
        model.martshows_promotion =[dic objectForKey:@"promotion"];
        model.martshows_mainImage = [dic objectForKey:@"main_img"];
        
        [self.nineNew_dataSource addObject:model];
    }
    [self.tableView reloadData];
    
}


#pragma mark ------ 上拉加载 下拉刷新 ------
-(void)addRefresh{
    MJRefreshNormalHeader * header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        //在该block代码块中，编写正在刷新的代码
        NSLog(@"资源正在刷新中..");
        //当上拉加载更多时 数据源中存放了好几页数据 而下拉刷新之后 要使得数据源中只有第一页数据
        [self.nineNew_dataSource removeAllObjects];
        //重新把第一页数据加到数据源中
        [self loadNewNineDataWithPath:PATH_NEW_NINE(1)];
        _page = 1;
        
        //一段时间以后 停止刷新
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2*NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.tableView.header endRefreshing];
        });
        
    }];
    //添加下拉刷新
    self.tableView.header = header;
    
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
        
        [self loadNewNineDataWithPath:PATH_NEW_NINE(_page)];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.tableView.footer endRefreshing];
        });
        
        
    }];
    self.tableView.footer =footer;
    
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
