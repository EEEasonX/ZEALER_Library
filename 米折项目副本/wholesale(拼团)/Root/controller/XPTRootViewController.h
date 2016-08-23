//
//  XPTRootViewController.h
//  米折项目
//
//  Created by apple on 16/8/3.
//  Copyright © 2016年 王欣. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XPTRootViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>



- (void)loadDataWithPath:(NSString *)str;
-(void)addRefreshWithCategory:(NSString *)str;


@end
