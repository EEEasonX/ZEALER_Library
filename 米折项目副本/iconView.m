//
//  iconView.m
//  Text
//
//  Created by 王磊怀 on 16/7/27.
//  Copyright © 2016年 王磊怀. All rights reserved.
//

#import "iconView.h"
#import "UIImageView+WebCache.h"

@implementation iconView

- (void)createIconWithImageURL:(NSString *)imageURL
                      username:(NSString *)username
                    publicTime:(NSString *)time{
    UIImageView * icon = [[UIImageView alloc] initWithFrame:CGRectMake(CURRENT_SIZE2(10), CURRENT_SIZE2(5)  , CURRENT_SIZE2(20), CURRENT_SIZE2(20))];
    [icon sd_setImageWithURL:[NSURL URLWithString:imageURL]];
    icon.layer.cornerRadius = 10;
    [self addSubview:icon];
    
    UILabel * lab = [[UILabel alloc] initWithFrame:CGRectMake(CURRENT_SIZE2(35), CURRENT_SIZE2(5), CURRENT_SIZE2(100), CURRENT_SIZE2(12))];
    lab.text = username;
    lab.font = [UIFont systemFontOfSize:10];
    lab.textColor = [UIColor grayColor];
    [self addSubview:lab];
    
    UILabel * time_lab = [[UILabel alloc] initWithFrame:CGRectMake(CURRENT_SIZE2(35), CURRENT_SIZE2(17), CURRENT_SIZE2(100), CURRENT_SIZE2(8))];
    time_lab.textColor = [UIColor lightGrayColor];
    time_lab.text = time;
    time_lab.font = [UIFont systemFontOfSize:8];
    [self addSubview:time_lab];
}

@end
