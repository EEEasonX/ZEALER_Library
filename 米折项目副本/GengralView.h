//
//  GengralView.h
//  Text
//
//  Created by 王磊怀 on 16/7/27.
//  Copyright © 2016年 王磊怀. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GengralView : UIView

- (void)addContentWithGategory:(NSString * )category
                       suppurt:(NSString *)num_up
                          down:(NSString *)num_down
                         share:(NSString *)num_share
                       discuss:(NSString *)num_discuss;

@end
