//
//  XPTModel.h
//  米折项目
//
//  Created by apple on 16/8/3.
//  Copyright © 2016年 王欣. All rights reserved.
//

#import "JSONModel.h"

@interface XPTModel : JSONModel

/**
 *  拼团名称
 */
@property (nonatomic,copy) NSString * pt_title;
/**
*  拼团id
*/
@property (nonatomic,copy) NSString * pt_id;
/**
*  拼团图片
*/
@property (nonatomic,copy) NSString * pt_image_url;
/**
*  拼团人数
*/
@property (nonatomic,copy) NSString * pt_present;
/**
*  拼团现价
*/
@property (nonatomic,copy) NSString * pt_now_price;
/**
*  拼团原价
*/
@property (nonatomic,copy) NSString * pt_old_price;
/**
*  拼团参团人数
*/
@property (nonatomic,copy) NSString * pt_buying_info;
/**
*  拼团名称
*/
@end
