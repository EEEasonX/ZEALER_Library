//
//  XPTRootViewController.m
//  米折项目
//
//  Created by apple on 16/8/3.
//  Copyright © 2016年 王欣. All rights reserved.
//

#import "XPTRootViewController.h"

#import "XPTModel.h"

#import "XPTTableViewcell.h"

@interface XPTRootViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    int _page;
    //记录cell的个数
    NSInteger _num_cell;
    
}

@property (nonatomic,strong)UITableView * tableView;

@property (nonatomic,copy)NSMutableArray * dataSource;
@end

@implementation XPTRootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor redColor];
    [self.view addSubview:self.tableView];
    [self registerCell];
}
-(void)viewWillDisAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [self.dataSource removeAllObjects];
}
#pragma mark ----------- 使用XIB的Cell 需要注册 ------------

- (void)registerCell{
    UINib * nib = [UINib nibWithNibName:@"XPTTableViewcell" bundle:nil];
    [self.tableView registerNib:nib  forCellReuseIdentifier:@"XPTTableViewcell" ];
}

//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    return self.dataSource.count;
//}
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"kkk"];
//    if (!cell){
//        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"kkk"];
//        cell.backgroundColor =[UIColor colorWithRed:0.98 green:0.94 blue:0.94 alpha:1.00];
//    }
//    return cell;
//}
//
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    return 260;
//}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    XPTTableViewcell * cell = [tableView dequeueReusableCellWithIdentifier:@"XPTTableViewcell"];
    if (!cell) {
        cell = [[XPTTableViewcell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"XPTTableViewcell"];
        
    }
    if (self.dataSource.count>0) {
        XPTModel * model = self.dataSource[indexPath.row];
        [cell addContentForCellWithModel:model];
    }
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 245;
}

#pragma amrk ----------- 懒加载 --------------

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0,  0, SCREEN_WIDTH, SCREEN_HEIGHT-94-49) style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1.00];
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

#pragma amrk ----------- 解析数据 ----------------

- (void)loadDataWithPath:(NSString *)path{
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFCompoundResponseSerializer serializer];
    [manager GET:path parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"请求成功");
        
        NSDictionary * down_dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        [self analizyDataWithArr:[down_dic objectForKey:@"fightgroup_items"]];
        
        [self.tableView reloadData];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"请求失败");
    }];
}

- (void)analizyDataWithArr:(NSArray * )arr{
    for (int i = 0; i < arr.count; i++) {
        XPTModel * model = [[XPTModel alloc]init];
        
        model.pt_id = [NSString stringWithFormat:@"%@",[arr[i] objectForKey:@"iid"]];
        
        model.pt_title = [arr[i] objectForKey:@"title"];
        
        model.pt_image_url =[arr[i] objectForKey:@"rect_img"];
        
        model.pt_buying_info =[arr[i] objectForKey:@"buying_info"];
        
        model.pt_present =[NSString stringWithFormat:@"%@人团",[arr[i] objectForKey:@"group_num"]];
        
        model.pt_now_price =[NSString stringWithFormat:@"%.1f",[[arr[i] objectForKey:@"group_price"] floatValue]/100];
        
        model.pt_old_price = [NSString stringWithFormat:@"%.1f",[[arr[i] objectForKey:@"origin_price"] floatValue]/100];
        
        
        [self.dataSource addObject:model];
    }
    
}
#pragma mark ------ 上拉加载 下拉刷新 ------
-(void)addRefreshWithCategory:(NSString *)str{
    MJRefreshNormalHeader * header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        //在该block代码块中，编写正在刷新的代码
        NSLog(@"资源正在刷新中..");
        //当上拉加载更多时 数据源中存放了好几页数据 而下拉刷新之后 要使得数据源中只有第一页数据
        [self.dataSource removeAllObjects];
        
        //重新把第一页数据加到数据源中
        [self loadDataWithPath:PATH_PINTUAN_CATEGORY(_page,str)];
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
        
        [self loadDataWithPath:PATH_PINTUAN_CATEGORY(_page+1, str)];
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
