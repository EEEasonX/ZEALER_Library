//
//  XPTTableViewcell.h
//  米折项目
//
//  Created by apple on 16/8/3.
//  Copyright © 2016年 王欣. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XPTModel.h"
@interface XPTTableViewcell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *pt_image;

@property (weak, nonatomic) IBOutlet UIButton *but_sum;

@property (weak, nonatomic) IBOutlet UILabel *pt_title;
@property (weak, nonatomic) IBOutlet UILabel *pt_now_price;
@property (weak, nonatomic) IBOutlet UILabel *pt_now_2_price;
@property (weak, nonatomic) IBOutlet UILabel *pt_old_price;
@property (weak, nonatomic) IBOutlet UIButton *pt_tuan;

-(void)addContentForCellWithModel:(XPTModel *)model;

@end
