//
//  XDetailViewController.m
//  米折项目
//
//  Created by apple on 16/8/5.
//  Copyright © 2016年 王欣. All rights reserved.
//

#import "XDetailViewController.h"

#import "XDetailModel.h"


@interface XDetailViewController ()<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>
{
    //返回按键
    UIButton * _back;
    //更多按键
    UIButton * _more;
    //倒数计时用的 小时 分钟 秒
    int _hours;
    int _minutes;
    int _seconds;
}
@property(nonatomic,strong)UITableView * tableView;

@property(nonatomic,strong)UIView * headerView;

@property(nonatomic,strong)UIView * Down_headerView;
@property(nonatomic,strong)UIScrollView * headerView_scollView;

@property (weak, nonatomic) IBOutlet UIView *cusNav;

@property (weak, nonatomic) IBOutlet UIView *showTime;

@property (weak, nonatomic) IBOutlet UILabel *hour;

@property (weak, nonatomic) IBOutlet UILabel *minute;

@property (weak, nonatomic) IBOutlet UILabel *second;

@property (nonatomic,strong)XDetailModel * detail_model;

@property (nonatomic,strong)NSTimer * timer;

@end

@implementation XDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    //把视图放在最前面
    [self.view bringSubviewToFront:self.cusNav];
    [self createBackAndMore];
    [self runTime];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    self.navigationController.navigationBar.hidden = YES;
    self.cusNav.hidden = YES;
    
    [self loadDataWithPath:PATH_DETAIL(self.goods_iid)];
    
}
- (IBAction)NavBackAction:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)navMoreAction:(UIButton *)sender {
}

#pragma mark ---------- 添加控件 --------------
- (void)createBackAndMore{
    _back = [[UIButton alloc]initWithFrame:CGRectMake(8, 26, 30, 30)];
    [_back setImage:[UIImage imageNamed:@"ic_default_closed"] forState:UIControlStateNormal];
    [_back addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchDown];
    _back.layer.cornerRadius = 15;
    _back.backgroundColor = [UIColor colorWithRed:0.87 green:0.87 blue:0.87 alpha:1.00];
    [self.view addSubview:_back];
    
    _more = [[UIButton alloc]initWithFrame:CGRectMake(282, 26, 30, 30)];
    [_more setImage:[UIImage imageNamed:@"ic_detail_more"] forState:UIControlStateNormal];
    [_more addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchDown];
    _more.layer.cornerRadius = 15;
    _more.backgroundColor = [UIColor colorWithRed:0.87 green:0.87 blue:0.87 alpha:1.00];
    [self.view addSubview:_more];
    
    
}
//获取时间 时间戳转化为时间
- (void)showTimeTheEnd{
    //时间戳转化为时间的字符串
    NSTimeInterval time = [self.detail_model.detail_gmt_end doubleValue];
    NSDate * detail_date = [NSDate dateWithTimeIntervalSince1970:time];
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    //NSString * currentDateStr = [dateFormatter stringFromDate:detail_date];
    
    //获取当前时间的时间差
    NSTimeInterval time_interval = [detail_date timeIntervalSinceNow];
    
    int sum_hour = time_interval / 3600 ;
    _hours = sum_hour % 24;
    _minutes = (time_interval - sum_hour * 3600)/60;
    _seconds = time_interval - sum_hour *3600 - _minutes * 60;
    
    self.hour.text = [NSString stringWithFormat:@"%02d",_hours];
    self.minute.text = [NSString stringWithFormat:@"%02d",_minutes];
    self.second.text = [NSString stringWithFormat:@"%02d",_seconds];
    
    
}
//时间可变
- (void)runTime{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [self timer];
    });
}
- (void)cerateDetailBut{
    UIButton * bt = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-CURRENT_SIZE2(50), SCREEN_WIDTH-CURRENT_SIZE2(50), CURRENT_SIZE2(30), CURRENT_SIZE2(30))];
    [bt setImage:[UIImage imageNamed:@"cart_dot"] forState:UIControlStateNormal];
    [bt setTitle:@"图文/n详情" forState:UIControlStateNormal];
    bt.titleLabel.font = [UIFont systemFontOfSize:10];
    bt.titleLabel.textAlignment =  NSTextAlignmentCenter;
    bt.layer.cornerRadius = 15;
    [bt addTarget:self action:@selector(show) forControlEvents:UIControlEventTouchDown];
}
#pragma mark -----------bt 点击事件------
- (void)backAction:(UIButton *)bt{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)lostTime{
    
    _seconds--;
    if (_seconds < 0) {
        _seconds = 59;
        _minutes --;
        if (_minutes<0) {
            _minutes =59;
            _hours --;
            if (_hours<0) {
                _hours =23;
            }
        }
    }
    self.hour.text = [NSString stringWithFormat:@"%02d",_hours];
    self.minute.text = [NSString stringWithFormat:@"%02d",_minutes];
    self.second.text = [NSString stringWithFormat:@"%02d",_seconds];
}

- (void)showImageAction{
    NSLog(@"点击了图文详情");
}

#pragma mark ---------- tableView协议方法 ------------

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"reuseId"];
    if (!cell) {
        cell = [[UITableViewCell alloc]init];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat _alpha = (self.tableView.contentOffset.y+24)/(SCREEN_WIDTH-CURRENT_SIZE2(64));
    //NSLog(@"%f------%f*******%f",self.tableView.contentOffset.x,self.tableView.contentOffset.y,_alpha);
    
    if (_alpha<0.072) {
        self.cusNav.hidden = YES;
       
    }else if (_alpha<1){
        self.cusNav.backgroundColor = SELECT_COLOR(255, 255, 255, _alpha);
        _back.alpha = 1-_alpha;
        _more.alpha = 1-_alpha;
        self.cusNav.hidden = YES;
        _more.hidden =NO;
        _back.hidden = NO;
        
    }
    if (_alpha >= 1) {
        self.cusNav.hidden =  NO;
        self.showTime.hidden = NO;
        self.cusNav.backgroundColor = SELECT_COLOR(245, 245, 245, 1);
        _more.hidden =YES;
        _back.hidden = YES;
        
    }
}


#pragma mark ---------- 懒加载 --------------

-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, -24, SCREEN_WIDTH, SCREEN_HEIGHT+24) style:UITableViewStylePlain];
    
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.tag = 200;
        _tableView.tableHeaderView = self.headerView;
    }
    return _tableView;
}

- (UIView *)headerView{
    if (!_headerView) {
        _headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH+45)];
        _headerView.backgroundColor = [UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1.00];
        
    }
    return _headerView;
}

- (UIView *)Down_headerView{
    if (!_Down_headerView) {
        _Down_headerView = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_WIDTH, SCREEN_WIDTH, 45)];
        _Down_headerView.backgroundColor = [UIColor colorWithRed:0.87 green:0.20 blue:0.13 alpha:1.00];
        
        
        
        
        
    }
    return _Down_headerView;
}

- (NSTimer *)timer{
    if (!_timer) {
        _timer = [NSTimer timerWithTimeInterval:1 target:self selector:@selector(lostTime) userInfo:nil repeats:YES];
        [[NSRunLoop mainRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
        [_timer fire];
    }
    return _timer;
}

- (UIScrollView *)headerView_scollView{
    if (!_headerView_scollView) {
        _headerView_scollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH)];
        
        for (int i = 0; i < self.detail_model.detail_scr_image_url_arr.count; i++) {
            UIImageView * imageV = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH * i, 0, SCREEN_WIDTH, SCREEN_WIDTH)];
            [imageV sd_setImageWithURL:[NSURL URLWithString:self.detail_model.detail_scr_image_url_arr[i] ]placeholderImage:[UIImage imageNamed:@""]];
            [_headerView_scollView addSubview:imageV];
        }
        _headerView_scollView.contentSize = CGSizeMake(SCREEN_WIDTH* self.detail_model.detail_scr_image_url_arr.count, SCREEN_WIDTH);
        _headerView_scollView.contentOffset = CGPointMake(0, 0);
        _headerView_scollView.pagingEnabled = YES;
        _headerView_scollView.showsVerticalScrollIndicator = NO;
        
        
    }
    return _headerView_scollView;
}
#pragma amrk ----------- 解析数据 ----------------

- (void)loadDataWithPath:(NSString *)path{
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFCompoundResponseSerializer serializer];
    [manager GET:path parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"请求成功");
        
        NSDictionary * down_dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        [self analizyDataWithDic:down_dic];
        
        [self showTimeTheEnd];
        [self.headerView addSubview:self.headerView_scollView];
        [self.headerView addSubview:self.Down_headerView];
        [self.tableView reloadData];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"请求失败");
    }];
}

- (void)analizyDataWithDic:(NSDictionary * )dic{
    
    
    self.detail_model = [[XDetailModel alloc]init];
    self.detail_model.detail_gmt_end = [NSString stringWithFormat:@"%@",[dic objectForKey:@"gmt_end"]];
    
    
    NSDictionary * image_dic = [dic objectForKey:@"imgs"];
    self.detail_model.detail_scr_image_url_arr = [NSMutableArray array];
    for (NSString * obj in image_dic) {
        [self.detail_model.detail_scr_image_url_arr addObject:[image_dic objectForKey:obj]];
    }
    
    
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
