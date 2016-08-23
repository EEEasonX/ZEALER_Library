//
//  DetailModel.h
//  MiZhe
//
//  Created by ading on 16/7/25.
//  Copyright © 2016年 阿鼎. All rights reserved.
//

#import "JSONModel.h"

@interface DetailModel : JSONModel

@property(nonatomic,copy)NSString *product_id;

@property(nonatomic,copy)NSString *img_name;

@property(nonatomic,copy)NSString *price;

@property(nonatomic,copy)NSString *sale_tip;

@property(nonatomic,copy)NSString *product_title;







@end
