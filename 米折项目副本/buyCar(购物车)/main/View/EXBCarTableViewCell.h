//
//  EXBCarTableViewCell.h
//  米折项目
//
//  Created by apple on 16/8/9.
//  Copyright © 2016年 EEEasonX. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "GengralView.h"

#import "iconView.h"

#import "XBCarModel.h"
@interface EXBCarTableViewCell : UITableViewCell

@property (nonatomic,strong)GengralView * gengralView;

@property (nonatomic,strong)iconView * iconV;

- (void)addContextToCellWithModel:(XBCarModel *)model;

@end
