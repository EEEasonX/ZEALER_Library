//
//  GengralView.m
//  Text
//
//  Created by 王磊怀 on 16/7/27.
//  Copyright © 2016年 王磊怀. All rights reserved.
//

#import "GengralView.h"

@implementation GengralView

- (void)addContentWithGategory:(NSString * )category
                       suppurt:(NSString *)num_up
                          down:(NSString *)num_down
                         share:(NSString *)num_share
                       discuss:(NSString *)num_discuss{
    float width_bt = [UIScreen mainScreen].bounds.size.width / 4.0;
    
    UIImageView * imageV = [[UIImageView alloc] initWithFrame:CGRectMake(CURRENT_SIZE2(10), CURRENT_SIZE2(7), CURRENT_SIZE2(15), CURRENT_SIZE2(15))];
    imageV.image = [UIImage imageNamed:@"ic_p_qianbao_ticket"];
    [self addSubview:imageV];
    
    UILabel * lab = [[UILabel alloc] initWithFrame:CGRectMake(imageV.frame.size.width + imageV.frame.origin.x, CURRENT_SIZE2(7), CURRENT_SIZE2(300), CURRENT_SIZE2(15))];
    lab.textColor = [UIColor grayColor];
    lab.font = [UIFont systemFontOfSize:10];
    lab.text = category;
    [self addSubview:lab];
    
    NSArray * image_arr = @[@"ic_baoliao_zan_large",@"ic_detail_arrow_down",@"ic_baoliao_share",@"ic_message"];
    NSArray * text_arr = @[num_up,num_down,num_share,num_discuss];
    
    for (int i = 0 ; i < 4; i++) {
        UIButton * bt = [[UIButton alloc] initWithFrame:CGRectMake(width_bt * i, CURRENT_SIZE2(31), width_bt, CURRENT_SIZE2(30))];
        [bt setImage:[UIImage imageNamed:image_arr[i]] forState:UIControlStateNormal];
        [bt setTitle:text_arr[i] forState:UIControlStateNormal];
        bt.titleLabel.font = [UIFont systemFontOfSize:10];
        [bt setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [bt addTarget:self action:@selector(addButtonAction:) forControlEvents:UIControlEventTouchDown];
        bt.tag = 100 + i;
        [self addSubview:bt];
    }
}

- (void)addButtonAction:(UIButton *)bt{
    NSLog(@"点击了第%ld个button",bt.tag);
}

@end
