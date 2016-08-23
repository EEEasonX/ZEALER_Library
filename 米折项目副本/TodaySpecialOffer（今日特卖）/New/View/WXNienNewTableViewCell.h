//
//  WXNienNewTableViewCell.h
//  米折项目
//
//  Created by sh on 16/7/22.
//  Copyright © 2016年 王欣. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WXNewNineModel.h"

@interface WXNienNewTableViewCell : UITableViewCell

/** 给cell添加内容 */
-(void)addContentForCellWithModel:(WXNewNineModel *)model;

@end
