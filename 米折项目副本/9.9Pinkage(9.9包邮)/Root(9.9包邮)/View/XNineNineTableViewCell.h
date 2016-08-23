//
//  XNineNineTableViewCell.h
//  米折项目
//
//  Created by apple on 16/8/2.
//  Copyright © 2016年 王欣. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XNineNineModel.h"
@interface XNineNineTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *goods_Image;


@property (weak, nonatomic) IBOutlet UILabel *goods_Name;

@property (weak, nonatomic) IBOutlet UILabel *goods_Sum_Num;

@property (weak, nonatomic) IBOutlet UILabel *goods_Num_progremss;

@property (weak, nonatomic) IBOutlet UILabel *goods_Price;

@property (weak, nonatomic) IBOutlet UILabel *goods_Price_ori;
@property (weak, nonatomic) IBOutlet UIButton *goods_bt;

-(void)addContentForCellWithModel:(XNineNineModel *)model;

@end
