//
//  WXNvZhuangViewController.m
//  米折项目
//
//  Created by apple on 16/8/1.
//  Copyright © 2016年 王欣. All rights reserved.
//

#import "WXNvZhuangViewController.h"

@interface WXNvZhuangViewController ()

@end

@implementation WXNvZhuangViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    
    [self loadDataWithPath:PATH_NEW_CATEGORY(1, @"nvzhuang")];
    [self addRefreshWithCategory:@"nvzhuang"];
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
