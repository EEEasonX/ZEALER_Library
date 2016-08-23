//
//  XTNineViewController.m
//  米折项目
//
//  Created by apple on 16/8/1.
//  Copyright © 2016年 王欣. All rights reserved.
//

#import "XTNineViewController.h"

@interface XTNineViewController ()

@end

@implementation XTNineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self loadDataWithPath:PATH_NINE_CATEGORY(1, @"-10-1000_2999")];
    [self addRefreshWithCategory:@"-10-1000_2999"];
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
