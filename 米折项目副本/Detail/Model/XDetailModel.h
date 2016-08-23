//
//  XDetailModel.h
//  米折项目
//
//  Created by apple on 16/8/5.
//  Copyright © 2016年 王欣. All rights reserved.
//

#import "JSONModel.h"

@interface XDetailModel : JSONModel

/**
 *  商品结束时间
 */

@property (nonatomic,copy)NSString * detail_gmt_end;

/**
 *  存放scrollView的图片的数组
 */
@property (nonatomic,strong)NSMutableArray * detail_scr_image_url_arr;
@end
