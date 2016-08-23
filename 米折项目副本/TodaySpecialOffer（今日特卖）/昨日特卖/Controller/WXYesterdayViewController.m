//
//  WXYesterdayViewController.m
//  米折项目
//
//  Created by apple on 16/8/1.
//  Copyright © 2016年 王欣. All rights reserved.
//

#import "WXYesterdayViewController.h"

@interface WXYesterdayViewController (){
    int _page;
}

@end

@implementation WXYesterdayViewController

- (void)viewDidLoad {
    self.view.backgroundColor=[UIColor whiteColor];
    [super viewDidLoad];
    
    [self refreshAndLoadingMoreWithCategory:nil];
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:YES];
    _page = 1;
    [self loadDataWithPath:PATH_LEAT(1)];
}
-(void)refreshAndLoadingMoreWithCategory:(NSString *)cate{
    
    
    MJRefreshNormalHeader *header=[MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [self.first_dataSource removeAllObjects];
        
        [self loadDataWithPath:PATH_LEAT(1)];
        
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2*NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [self.tableView.header endRefreshing];
        });
        
        
    }];
    
    self.tableView.header=header;
    //    隐藏更新日期的那个label
    header.lastUpdatedTimeLabel.hidden=YES;
    
    //    根据下拉程度的不同，改变不同的标题
    header.automaticallyChangeAlpha=YES;
    //    根据不同状态，设置不同的标题
    [header setTitle:@"再加把劲－嘿嘿" forState:MJRefreshStateIdle];
    [header setTitle:@"放开我!" forState:MJRefreshStatePulling];
    [header setTitle:@"正在加载中...哈哈" forState:MJRefreshStateRefreshing];
    
    
    //    上拉加载
    MJRefreshAutoNormalFooter *footer=[MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        
        _page++;
        
        
        [self loadDataWithPath:PATH_LEAT(_page)];
        
        
        
        //        一段时间后停下来
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2*NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [self.tableView.footer endRefreshing];
            
        });
        
        
    }];
    
    self.tableView.footer=footer;
    
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
