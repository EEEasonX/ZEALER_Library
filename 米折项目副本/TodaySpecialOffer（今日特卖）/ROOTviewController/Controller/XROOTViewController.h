//
//  XROOTViewController.h
//  米折项目
//
//  Created by apple on 16/7/26.
//  Copyright © 2016年 王欣. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XROOTViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView * tableView;

@property(nonatomic,copy)NSMutableArray * first_dataSource;

- (void)loadDataWithPath:(NSString *)path;
-(void)addRefreshWithCategory:(NSString *)str;
@end
