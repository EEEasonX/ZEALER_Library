//
//  WXNewNineModel.h
//  米折项目
//
//  Created by sh on 16/7/22.
//  Copyright © 2016年 王欣. All rights reserved.
//

#import "JSONModel.h"

@interface WXNewNineModel : JSONModel
/** 专场ID */
@property(nonatomic,copy)NSString * martshows_id;

/** 专场标题 */
@property(nonatomic,copy)NSString * martshows_title;

/** 专场大图 */
@property(nonatomic,copy)NSString * martshows_mainImage;



/** 专场结束时间 */
@property(nonatomic,strong)NSNumber * martshows_end;

/** 专场折扣 */
@property(nonatomic,copy)NSString * martshows_promotion;

/** 专场满减 */
@property(nonatomic,copy)NSString * martshows_mjpromotion;

/** 专场上新 */
@property(nonatomic,copy)NSString * martshows_img_tr;



@end
