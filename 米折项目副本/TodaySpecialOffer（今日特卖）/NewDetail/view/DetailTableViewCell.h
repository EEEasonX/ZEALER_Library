//
//  DetailTableViewCell.h
//  MiZhe
//
//  Created by ading on 16/7/25.
//  Copyright © 2016年 阿鼎. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "DetailModel.h"


typedef void(^ItemBlock)(NSInteger tag);

@interface DetailTableViewCell : UITableViewCell

@property(nonatomic,copy)ItemBlock block;



-(void)addContentWithModel:(DetailModel *)leftmodel RightModel:(DetailModel *)rightmodel Tag:(NSInteger)tag;

@end
