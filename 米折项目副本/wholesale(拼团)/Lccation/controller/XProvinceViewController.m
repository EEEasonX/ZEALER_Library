//
//  XProvinceViewController.m
//  米折项目
//
//  Created by apple on 16/8/3.
//  Copyright © 2016年 王欣. All rights reserved.
//

#import "XProvinceViewController.h"
#import <CoreLocation/CoreLocation.h>


@interface XProvinceViewController ()<UITableViewDataSource,UITableViewDelegate,CLLocationManagerDelegate>
{
    CLLocationManager * _locationManager;
}

@property (nonatomic,copy)NSMutableArray * dataSoure_pro;

@property (nonatomic,strong)UITableView * tableView;

@property (nonatomic,copy)NSArray * alphat_arr;
@property (nonatomic,copy)NSString * pro_str;
@end

@implementation XProvinceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor orangeColor];
    // Do any additional setup after loading the view.
    [self dataSoure_pro];
    [self.view addSubview:self.tableView];
    
    self.alphat_arr = @[@"定位位置",@"当前位置",@"A",@"B",@"C",@"F",@"G",@"H",@"J",@"L",@"N",@"Q",@"S",@"T",@"X",@"Y",@"Z"];
    [self lacationAction];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    self.navigationController.navigationBar.hidden= NO;
    self.tabBarController.tabBar.hidden = YES;
    self.pro_str = [[NSUserDefaults standardUserDefaults]objectForKey:@"X_Province_User"];
}


/** 实现定位 */
- (void)lacationAction{
    //如果定位服务可以使用
    if ([CLLocationManager locationServicesEnabled]) {
        _locationManager = [[CLLocationManager alloc]init];
        //设定定位精度
        [_locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
        //表示定位的精度 10米
        _locationManager.distanceFilter = 10.0f;
        _locationManager.delegate = self;
        
        if (iOS8_OR_LATER) {
            [_locationManager requestAlwaysAuthorization];
            [_locationManager requestWhenInUseAuthorization];
            
        }
        //开始实时定位
        [_locationManager startUpdatingHeading];
    }
}

#pragma mark ------------ location的协议方法 -------------

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status{
    NSLog(@"longitude = %f",manager.location.coordinate.longitude);
    NSLog(@"latitude = %f",manager.location.coordinate.latitude);
    [_locationManager stopUpdatingHeading];
    
    /** 反地理编码 */
    CLGeocoder * geocoder = [[CLGeocoder alloc]init];
    [geocoder reverseGeocodeLocation:manager.location               completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        for (CLPlacemark * placeMark in placemarks) {
            NSDictionary * dic_address = [placeMark addressDictionary];
            //
            
            NSArray * arr_01 = [[NSArray alloc]initWithObjects:[dic_address objectForKey:@"State"], nil];
            [self.dataSoure_pro insertObject:arr_01 atIndex:0];
            NSArray * arr_02 = [[NSArray alloc]initWithObjects:self.pro_str, nil];
            [self.dataSoure_pro insertObject:arr_02 atIndex:1];
            
            [[NSUserDefaults standardUserDefaults] setObject:self.pro_str forKey:@"X_Province_User"];
        }
        [self.tableView reloadData];
    }];
    
}

#pragma mark ------------
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell=[tableView cellForRowAtIndexPath:indexPath];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"reuseID"];
        
    }
    if (indexPath.section == 0 || indexPath.section == 1) {
        
        UILabel * lab = [[UILabel alloc]initWithFrame:CGRectMake(10, 7, 100, 30)];
        lab.layer.borderWidth = 1;
        lab.textAlignment = NSTextAlignmentCenter;
        lab.text = self.dataSoure_pro[0][0];
        lab.backgroundColor = [UIColor whiteColor];
        if (indexPath.section == 1) {
            UIImageView * imageV = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"img_tuan_gou"]];
            imageV.frame = CGRectMake(285, 10, 24, 24);
            lab.text = self.pro_str;
            [cell addSubview:imageV];
            
        }
        cell.textLabel.hidden = YES;
        [cell addSubview:lab];
    }
//    if (indexPath.section == 1) {
//        UIImageView * imageV = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"img_tuan_gou"]];
//                   imageV.frame = CGRectMake(285, 10, 20, 20);
//                  [cell addSubview:imageV];
//    }
    
    cell.textLabel.text = self.dataSoure_pro[indexPath.section][indexPath.row];
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView * vi = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 30)];
    vi.backgroundColor = [UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1.00];
    
    UILabel * lab = [[UILabel alloc]initWithFrame:CGRectMake(10, 5, 80, 20)];
    
    lab.textAlignment = NSTextAlignmentLeft;
    lab.text =self.alphat_arr[section ];
    [vi addSubview:lab];
    return vi;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataSoure_pro.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.dataSoure_pro[section]count];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section != 1) {
        self.pro_str = self.dataSoure_pro[indexPath.section ][indexPath.row];
        [[NSUserDefaults standardUserDefaults] setObject:self.pro_str forKey:@"X_Province_User"];
        [self.tableView reloadData];
    }
    [self.navigationController popViewControllerAnimated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30;
}

- (NSMutableArray *)dataSoure_pro{
    if (!_dataSoure_pro) {
        NSString * path = [[NSBundle mainBundle]pathForResource:@"province" ofType:@"plist"];
        
        _dataSoure_pro = [[NSMutableArray alloc]initWithContentsOfFile:path];;
    }
    return _dataSoure_pro;
}

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT+49) style:UITableViewStylePlain];
        
        _tableView.dataSource = self;
        _tableView.delegate = self;
    }
    return _tableView;
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
