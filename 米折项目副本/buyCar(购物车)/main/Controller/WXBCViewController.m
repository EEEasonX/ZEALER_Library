//
//  WXBCViewController.m
//  米折项目
//
//  Created by sh on 16/7/20.
//  Copyright © 2016年 王欣. All rights reserved.
//

#import "WXBCViewController.h"

#import "XBCarModel.h"

#import "EXBCarTableViewCell.h"

@interface WXBCViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)UITableView * tableView;

@property (nonatomic,copy)NSMutableArray * dataSource;

@end

@implementation WXBCViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     self.view.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:self.tableView];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [self loadData];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    EXBCarTableViewCell * cell = [tableView cellForRowAtIndexPath:indexPath];
    if (!cell) {
        cell = [[EXBCarTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"EXBCarTableViewCell"];
    }
    if (self.dataSource.count > 0) {
        XBCarModel * model = self.dataSource[indexPath.row];
        
        [cell addContextToCellWithModel:model];
    }
    
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.dataSource.count >0) {
        XBCarModel * model = self.dataSource[indexPath.row];
        return [model.cell_hight integerValue]+CURRENT_SIZE(120);
    }else{
        return 10;
    }
    
}


- (NSMutableArray *)dataSource{
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-49) style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
    }
    return _tableView;
}

- (void)loadData{
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFCompoundResponseSerializer serializer];
    [manager GET:PATH_BUYCAR parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"请求成功");
        
        NSDictionary * down_dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        [self analizyDataWithArr:[down_dic objectForKey:@"list"]];
       
        [self.tableView reloadData];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"请求失败");
    }];
}

- (void)analizyDataWithArr:(NSArray *)arr{
    for (int i = 0; i < arr.count ; i++) {
        XBCarModel * model = [[XBCarModel alloc]init];
        
        model.icon_url = [[[arr[i] objectForKey:@"u"]objectForKey:@"header"] firstObject];
        
        model.icon_name = [[arr[i] objectForKey:@"u"]objectForKey:@"name"] ;
        
        model.icon_time = [arr[i] objectForKey:@"passtime"];
        
        model.num_up = [arr[i] objectForKey:@"up"];
        
        model.num_down = [NSString stringWithFormat:@"%@",[arr[i] objectForKey:@"down"]];
        
        model.num_share = [NSString stringWithFormat:@"%@",[arr[i] objectForKey:@"forward"]];
        
        model.type = [arr[i] objectForKey:@"type"];
        
        model.num_comment = [arr[i] objectForKey:@"comment"];
        NSMutableArray * cate_arr = [arr[i] objectForKey:@"tags"];
        NSString * cate_str = [[NSString alloc]init];
        for (int i = 0; i < cate_arr.count; i++) {
            cate_str = [NSString stringWithFormat:@"%@   %@",cate_str,[cate_arr[i]objectForKey:@"name" ]];
        }
        model.tags = cate_str;
        
        model.text_detail = [arr[i] objectForKey:@"text"];
        
        CGRect rect_text = [self rectWithText:model.text_detail WithFountSize:15];
        
        model.text_hight = [NSString stringWithFormat:@"%f",rect_text.size.height];
        if ([[arr[i] objectForKey:@"type"]isEqualToString:@"video"]==YES) {
            model.video_mp4Url = [[[arr[i]objectForKey:@"video"]objectForKey:@"video"] firstObject];
            model.video_imagrUrl = [[[arr[i]objectForKey:@"video"]objectForKey:@"thumbnail"] firstObject];
            model.video_numPlay = [NSString stringWithFormat:@"%@",[[arr[i]objectForKey:@"video"]objectForKey:@"playcount"]];
            
            int min = [[[arr[i]objectForKey:@"video"] objectForKey:@"duration"]intValue ]/ 60;
            int sed =[[[arr[i]objectForKey:@"video"] objectForKey:@"duration"]intValue ]% 60;
            
            model.video_time = [NSString stringWithFormat:@"%02d:%d",min,sed];
            
            float height = CURRENT_SIZE2(300) * [[[arr[i]objectForKey:@"video"] objectForKey:@"height"]floatValue] /[[[arr[i]objectForKey:@"video"] objectForKey:@"width"]floatValue];
            model.gif_imageUrl = [[[arr[i] objectForKey:@"video"]objectForKey:@"thumbnail"]firstObject];
            model.gif_hight = [NSString stringWithFormat:@"%f",height];
            model.cell_hight = [NSString stringWithFormat:@"%lf",height+rect_text.size.height];
        }else if ([[arr[i] objectForKey:@"type"]isEqualToString:@"gif"]==YES){
            NSDictionary * dic_gif =[[NSDictionary alloc]init];
            dic_gif = [arr[i] objectForKey:@"gif"];
            model.gif_imageUrl = [[dic_gif objectForKey:@"images"]firstObject];
            
            float height = CURRENT_SIZE2(300) * [[dic_gif objectForKey:@"height"]floatValue] /[[dic_gif  objectForKey:@"width"]floatValue];
            
            model.gif_hight = [NSString stringWithFormat:@"%f",height];
            model.cell_hight = [NSString stringWithFormat:@"%f",height+rect_text.size.height];
        }else if ([[arr[i] objectForKey:@"type"]isEqualToString:@"image"]==YES){
            NSDictionary * dic_gif =[[NSDictionary alloc]init];
            dic_gif = [arr[i] objectForKey:@"image"];
            model.gif_imageUrl = [[dic_gif objectForKey:@"medium"]firstObject];
            
            float height = CURRENT_SIZE2(300) * [[dic_gif objectForKey:@"height"]floatValue] /[[dic_gif  objectForKey:@"width"]floatValue];
            
            model.gif_hight = [NSString stringWithFormat:@"%f",height];
            model.cell_hight = [NSString stringWithFormat:@"%f",height+rect_text.size.height];
        }else if ([[arr[i] objectForKey:@"type"]isEqualToString:@"text"]==YES){
            model.cell_hight = [NSString stringWithFormat:@"%f",rect_text.size.height];
        }
        
        
        [self.dataSource addObject:model];
        
    }
    
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
