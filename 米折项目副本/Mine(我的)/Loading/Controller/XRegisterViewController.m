//
//  XRegisterViewController.m
//  米折项目
//
//  Created by apple on 16/8/4.
//  Copyright © 2016年 王欣. All rights reserved.
//

#import "XRegisterViewController.h"
#import "XLoadingViewController.h"
@interface XRegisterViewController ()
@property (weak, nonatomic) IBOutlet UITextField *phoneNum_tf;
@property (weak, nonatomic) IBOutlet UITextField *CAPTCHA_tf;
@property (weak, nonatomic) IBOutlet UITextField *password_tf;

@end

@implementation XRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
- (IBAction)backAction:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)loginAction:(id)sender {
    XLoadingViewController * denglu = [[XLoadingViewController alloc]init];
    denglu.modalTransitionStyle = 1;
    [self presentViewController:denglu animated:YES completion:nil];
}

- (IBAction)VerificationCodeAction:(UIButton *)sender {
}

- (IBAction)SwitchAction:(UIButton *)sender {
}
- (IBAction)RegisterAction:(UIButton *)sender {
}
- (IBAction)ProtocolAction:(id)sender {
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
