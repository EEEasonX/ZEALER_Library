//
//  WXShoebagViewController.m
//  米折项目
//
//  Created by apple on 16/7/26.
//  Copyright © 2016年 王欣. All rights reserved.
//

#import "WXShoebagViewController.h"

@interface WXShoebagViewController ()

@end

@implementation WXShoebagViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    
    [self loadDataWithPath:PATH_NEW_CATEGORY(1, @"xiebao")];
    [self addRefreshWithCategory:@"xiebao"];
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
