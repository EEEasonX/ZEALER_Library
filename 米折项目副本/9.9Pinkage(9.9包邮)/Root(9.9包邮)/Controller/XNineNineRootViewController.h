//
//  XNineNineRootViewController.h
//  米折项目
//
//  Created by apple on 16/8/1.
//  Copyright © 2016年 王欣. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface XNineNineRootViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong)UITableView * tableView;

@property (nonatomic,copy)NSMutableArray * dataSource;

- (void)loadDataWithPath:(NSString *)str;
-(void)addRefreshWithCategory:(NSString *)str;

@end
