//
//  XLoadingViewController.m
//  米折项目
//
//  Created by apple on 16/8/4.
//  Copyright © 2016年 王欣. All rights reserved.
//

#import "XLoadingViewController.h"
#import "XRegisterViewController.h"
@interface XLoadingViewController ()

@property (weak, nonatomic) IBOutlet UITextField *mm_lab;

@property (weak, nonatomic) IBOutlet UITextField *zh_lab;



@end

@implementation XLoadingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (IBAction)backAction:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.zh_lab resignFirstResponder];
    [self.mm_lab resignFirstResponder];
}

- (IBAction)zhuceAction:(UIButton *)sender {
    XRegisterViewController * denglu = [[XRegisterViewController alloc]init];
    denglu.modalTransitionStyle = 1;
    [self presentViewController:denglu animated:YES completion:nil];
}

- (IBAction)zhanhuanAction:(UIButton *)sender {
}
- (IBAction)DengLuAction:(UIButton *)sender {
}

- (IBAction)fastDLAction:(UIButton *)sender {
}

- (IBAction)wwmmAction:(UIButton *)sender {
}

- (IBAction)weixinAction:(UIButton *)sender {
}


- (IBAction)taobaoAction:(UIButton *)sender {
}

- (IBAction)QQAction:(UIButton *)sender {
}

- (IBAction)weiboAction:(UIButton *)sender {
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
