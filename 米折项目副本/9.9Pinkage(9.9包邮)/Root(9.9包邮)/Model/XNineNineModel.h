//
//  XNineNineModel.h
//  米折项目
//
//  Created by apple on 16/8/2.
//  Copyright © 2016年 王欣. All rights reserved.
//

#import "JSONModel.h"

@interface XNineNineModel : JSONModel

/**
 *  商品ID
 */
@property(nonatomic,copy)NSString * goods_id;
/**
*  shangp名称
*/
@property(nonatomic,copy)NSString * goods_name;
/**
*  商品限量
*/
@property(nonatomic,copy)NSString * goods_sum_num;
/**
*  商品销量
*/
@property(nonatomic,copy)NSString * goods_sale_num;
/**
*  商品图片
*/
@property(nonatomic,copy)NSString * goods_image;
/**
*  商品价格
*/
@property(nonatomic,copy)NSString * goods_price;
/**
*  商品原价
*/
@property(nonatomic,copy)NSString * goods_price_ori;
@end
