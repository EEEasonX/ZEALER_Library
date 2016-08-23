//
//  XROOTViewController.m
//  米折项目
//
//  Created by apple on 16/7/26.
//  Copyright © 2016年 王欣. All rights reserved.
//

#import "XROOTViewController.h"

#import "WXNienNewTableViewCell.h"

#import "DetailTableViewCell.h"

#import "WXNewNineModel.h"

#import "DetailModel.h"


@interface XROOTViewController ()
{
    NSInteger  _num_cell;
    int _page ;
}
@property (nonatomic,copy)NSMutableArray * left_dataSource;
@property (nonatomic,copy)NSMutableArray * right_dataSource;
@property (nonatomic,strong)WXNewNineModel * model;
@property (nonatomic,strong)UIButton * setTop_button;

@end

@implementation XROOTViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    [self.view addSubview:_setTop_button];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    _num_cell = 5;
    _page = 1;
    
}

////减速完成时
//-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
//    self.setTop_button.hidden = NO;
//    
//}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        
        WXNienNewTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"WXNienNewTableViewCell"];
        if (!cell) {
            cell = [[WXNienNewTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"WXNienNewTableViewCell"];
            
        }
        
        if (self.first_dataSource.count > 0) {
            [cell addContentForCellWithModel:self.first_dataSource[indexPath.row]];
        }
        
        return cell;
    }else{
        // 一般，我们将 自定义的cell类的名作为 在复用池的唯一标示
        DetailTableViewCell *cell=[tableView cellForRowAtIndexPath:indexPath];
        //DetailTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"DetailTableViewCell"];
        if (!cell) {
            cell = [[DetailTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"DetailTableViewCell"];
            
        }
        
        if (self.first_dataSource.count > 0) {
            [cell addContentWithModel:self.left_dataSource[indexPath.row] RightModel:self.right_dataSource[indexPath.row] Tag:indexPath.row];
        }
        
        cell.block = ^(NSInteger tag){
            NSLog(@"点击了%ld张图片",(long)tag);
        };
         
        
        return cell;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return _num_cell;
    }else{
        return self.left_dataSource.count;
        
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}


- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if (section == 0) {
        if (_num_cell < self.first_dataSource.count) {
            UIView * vi = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 45)];
            UIButton * button = [[UIButton alloc]initWithFrame:CGRectMake(CURRENT_SIZE(5), 7, SCREEN_WIDTH-CURRENT_SIZE(10), CURRENT_SIZE(30))];
             
            [button setTitle:@"更多品牌" forState:UIControlStateNormal];
            
            [button setBackgroundColor:[UIColor orangeColor]];
            
            [button addTarget:self action:@selector(shoeMoreBrand:) forControlEvents:UIControlEventTouchDown];
            
            [vi addSubview:button];
            return vi;
        }else{
            //当显示完全是，隐藏组为视图
            UIView * vi = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0.00001)];
            return vi;
        }
    }
    return nil;
}
#pragma mark ----------button的点击事件
- (void)shoeMoreBrand:(UIButton *)bt{
    NSLog( @"点击了button");
    if (_num_cell <self.first_dataSource.count) {
        _num_cell += 5;
    }else{
        _num_cell = self.first_dataSource.count;
        
    }
    [self.tableView reloadData];
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 45;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.00001;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return CURRENT_SIZE(210);
    }else{
        return CURRENT_SIZE(245);
    }
}

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT -49 - 64 -CURRENT_SIZE(30)) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

- (NSMutableArray *)first_dataSource{
    if (!_first_dataSource) {
        _first_dataSource = [[NSMutableArray alloc] init];
    }
    return _first_dataSource;
}
- (NSMutableArray *)left_dataSource{
    if (!_left_dataSource) {
        _left_dataSource = [NSMutableArray array];
    }
    return _left_dataSource;
}

- (NSMutableArray *)right_dataSource{
    if (!_right_dataSource) {
        _right_dataSource = [NSMutableArray array];
    }
    return _right_dataSource;
}
-(UIButton *)setTop_button{
    if (!_setTop_button) {
        _setTop_button = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-CURRENT_SIZE(65), SCREEN_HEIGHT/2 + CURRENT_SIZE(95), CURRENT_SIZE(60), CURRENT_SIZE(60))];
        [_setTop_button setBackgroundImage:[UIImage imageNamed:@"c2c_ic_dianpu_zhiding"] forState:UIControlStateNormal];
        [_setTop_button addTarget:self action:@selector(setTopAction:) forControlEvents:UIControlEventTouchDown];
    }
    return _setTop_button;
}
/** 置顶按钮的点击事件 */
-(void)setTopAction:(UIButton *)but{
    self.tableView.contentOffset = CGPointMake(0, 0);
    
}
#pragma mark ---------- 数据解析 --------------
- (void)loadDataWithPath:(NSString *)path{
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFCompoundResponseSerializer serializer];
    [manager GET:path parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"请求成功");
        
        NSDictionary * down_dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        [self analizyDataWithArr:[down_dic objectForKey:@"mz_martshows"]];
        [self analizyDataWithTwoArr:[down_dic objectForKey:@"tuan_items"]];
        [self.tableView reloadData];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"请求失败");
    }];
}

- (void)analizyDataWithArr:(NSArray *)arr{
    for (int i = 0; i < arr.count ; i++) {
        WXNewNineModel * model = [[WXNewNineModel alloc] init];
        model.martshows_id = [NSString stringWithFormat:@"%@",[arr[i] objectForKey:@"event_id"]];
        model.martshows_mainImage = [arr[i] objectForKey:@"main_img"];
        model.martshows_mjpromotion = [arr[i] objectForKey:@"promotion"];
        model.martshows_img_tr = [arr[i] objectForKey:@"label_img_tr"];
        model.martshows_title = [arr[i] objectForKey:@"title"];
        model.martshows_end = [arr[i] objectForKey:@"gmt_end"];
        [self.first_dataSource addObject:model];
    }
}

- (void)analizyDataWithTwoArr:(NSArray *)arr{
    for (int i = 0; i < arr.count; i++) {
        DetailModel * model = [[DetailModel alloc]init];
        model.product_id = [NSString stringWithFormat:@"%@",[arr[i] objectForKey:@"iid"]];
        model.img_name = [arr[i] objectForKey:@"img"];
        model.price=[NSString stringWithFormat:@"%.2f",([[arr[i] objectForKey:@"price"] floatValue])/100];
        model.product_title=[arr[i] objectForKey:@"title"];
        
        model.sale_tip=[NSString stringWithFormat:@"%@人在抢！",[arr[i] objectForKey:@"clicks"]];
        
        if (i % 2==0) {
            [self.left_dataSource addObject:model];
        }else{
            [self.right_dataSource addObject:model];
        }
        
    }
}


#pragma mark ------ 上拉加载 下拉刷新 ------
-(void)addRefreshWithCategory:(NSString *)str{
    MJRefreshNormalHeader * header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        //在该block代码块中，编写正在刷新的代码
        NSLog(@"资源正在刷新中..");
        //当上拉加载更多时 数据源中存放了好几页数据 而下拉刷新之后 要使得数据源中只有第一页数据
        [self.first_dataSource removeAllObjects];
        [self.left_dataSource removeAllObjects];
        [self.right_dataSource removeAllObjects];
        //重新把第一页数据加到数据源中
        [self loadDataWithPath:PATH_NEW_CATEGORY(_page,str)];
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
        
        [self loadDataWithPath:PATH_NEW_CATEGORY(_page+1, str)];
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
