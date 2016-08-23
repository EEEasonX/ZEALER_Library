//
//  XNineNineRootViewController.m
//  米折项目
//
//  Created by apple on 16/8/1.
//  Copyright © 2016年 王欣. All rights reserved.
//

#import "XNineNineRootViewController.h"
#import "XNineNineModel.h"

#import "XNineNineTableViewCell.h"

@interface XNineNineRootViewController ()
{
    int _page;
    //记录cell的个数
    NSInteger _num_cell;
    UILabel * up_lab;
}
@property (nonatomic,strong)UIButton * setTop_but;

@end

@implementation XNineNineRootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    [self registerCell];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    
   
}
-(void)viewWillDisAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [self.dataSource removeAllObjects];
}
#pragma mark ---------- tableview 协议方法 -------

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    XNineNineTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"XNineNineTableViewCell"];
    if (!cell) {
        cell = [[XNineNineTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"XNineNineTableViewCell"];
        
        
    
    }
    if (self.dataSource.count>0) {
        XNineNineModel * model = self.dataSource[indexPath.row];
        [cell addContentForCellWithModel:model];
    }
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.dataSource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 140;
}

#pragma  mark ------------tableView 的点击事件 -----------
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    XDetailViewController * detail = [[XDetailViewController alloc]init];
    
    XNineNineModel * model = self.dataSource[indexPath.row];
    detail.goods_iid = model.goods_id;
    
    [self.navigationController pushViewController:detail animated:YES];
}
#pragma amrk ----------- 懒加载 --------------

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0,  CURRENT_SIZE(5), SCREEN_WIDTH, SCREEN_HEIGHT-94-49-CURRENT_SIZE(5)) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

- (NSMutableArray *)dataSource{
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}

#pragma mark ----------- 使用XIB的Cell 需要注册 ------------

- (void)registerCell{
    UINib * nib = [UINib nibWithNibName:@"XNineNineTableViewCell" bundle:nil];
    [self.tableView registerNib:nib  forCellReuseIdentifier:@"XNineNineTableViewCell" ];
}

#pragma amrk ----------- 解析数据 ----------------

- (void)loadDataWithPath:(NSString *)path{
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFCompoundResponseSerializer serializer];
    [manager GET:path parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"请求成功");
        
        NSDictionary * down_dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        [self analizyDataWithArr:[down_dic objectForKey:@"tuan_items"]];

        [self.tableView reloadData];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"请求失败");
    }];
}
- (void)analizyDataWithArr:(NSArray * )arr{
    for (int i = 0; i < arr.count; i++) {
        XNineNineModel * model = [[XNineNineModel alloc]init];
        
        model.goods_id = [NSString stringWithFormat:@"%@",[arr[i] objectForKey:@"iid"]];
        
        model.goods_name = [arr[i] objectForKey:@"title"];
        
        model.goods_image =[arr[i] objectForKey:@"img"];
        
        model.goods_sum_num =[NSString stringWithFormat:@"%@",[arr[i] objectForKey:@"total_stock"]];
        
        model.goods_sale_num =[NSString stringWithFormat:@"%@",[arr[i] objectForKey:@"sale_num"]];
        
        model.goods_price =[NSString stringWithFormat:@"%.1f",[[arr[i] objectForKey:@"price"] floatValue]/100];
        
        model.goods_price_ori = [NSString stringWithFormat:@"%.1f",[[arr[i] objectForKey:@"price_ori"] floatValue]/100];

        
        [self.dataSource addObject:model];
    }
    
}
-(UIButton *)setTop_button{
    if (!_setTop_but) {
        _setTop_but = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-CURRENT_SIZE(65), SCREEN_HEIGHT/2 + CURRENT_SIZE(95), CURRENT_SIZE(60), CURRENT_SIZE(60))];
        [_setTop_but setBackgroundImage:[UIImage imageNamed:@"c2c_ic_dianpu_zhiding"] forState:UIControlStateNormal];
        [_setTop_but addTarget:self action:@selector(setTopAction:) forControlEvents:UIControlEventTouchDown];
    }
    return _setTop_but;
}
/** 置顶按钮的点击事件 */
-(void)setTopAction:(UIButton *)but{
    self.tableView.contentOffset = CGPointMake(0, 0);
    
}
#pragma mark ------ 上拉加载 下拉刷新 ------
-(void)addRefreshWithCategory:(NSString *)str{
    MJRefreshNormalHeader * header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        //在该block代码块中，编写正在刷新的代码
        NSLog(@"资源正在刷新中..");
        //当上拉加载更多时 数据源中存放了好几页数据 而下拉刷新之后 要使得数据源中只有第一页数据
        [self.dataSource removeAllObjects];
        
        //重新把第一页数据加到数据源中
        [self loadDataWithPath:PATH_NINE_CATEGORY(_page,str)];
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
        
        [self loadDataWithPath:PATH_NINE_CATEGORY(_page+1, str)];
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
