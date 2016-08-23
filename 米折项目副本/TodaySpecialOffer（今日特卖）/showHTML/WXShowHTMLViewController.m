//
//  WXShowHTMLViewController.m
//  米折项目
//
//  Created by sh on 16/7/21.
//  Copyright © 2016年 王欣. All rights reserved.
//

#import "WXShowHTMLViewController.h"

@interface WXShowHTMLViewController ()

@property(nonatomic,strong)UIWebView * web;



@end

@implementation WXShowHTMLViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.custom_title;
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.web];
    
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    self.tabBarController.tabBar.hidden = YES;
    
    self.navigationController.navigationBarHidden = NO;

}

-(UIWebView *)web{
    if (!_web) {
        _web = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT+50)];
        NSURLRequest * request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.HTML_PATH]];
        [_web loadRequest:request];
    
    }
    return _web;
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
