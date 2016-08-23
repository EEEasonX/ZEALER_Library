//
//  XBCarModel.h
//  米折项目
//
//  Created by apple on 16/8/9.
//  Copyright © 2016年 王欣. All rights reserved.
//

#import "JSONModel.h"

@interface XBCarModel : JSONModel
/**
 *  用户头像的地址
 */
@property (nonatomic,copy) NSString * icon_url;

/**
 *  用户名
 */
@property (nonatomic,copy) NSString * icon_name;
/**
 *  用户段子发布时间
 */
@property (nonatomic,copy) NSString * icon_time;

/**
 *  段子标签
 */
@property (nonatomic,copy) NSString * tags;

/**
 *  赞 个数
 */
@property (nonatomic,copy) NSString * num_up;

/**
 *  不赞 个数
 */
@property (nonatomic,copy) NSString * num_down;

/**
 *  分享 个数
 */
@property (nonatomic,copy) NSString * num_share;

/**
 *  评论个数
 */
@property (nonatomic,copy) NSString *num_comment;

/**
 *  段子的类型
 */
@property (nonatomic,copy) NSString *type;

/**
 *  video 图片
 */
@property (nonatomic,copy) NSString *video_imagrUrl;
/**
 *  video mp4
 */
@property (nonatomic,copy) NSString *video_mp4Url;
/**
 *  video 次数
 */
@property (nonatomic,copy) NSString *video_numPlay;
/**
 *  video 时长
 */
@property (nonatomic,copy) NSString *video_time;

/**
 *  GIF 图片
 */
@property (nonatomic,copy) NSString * gif_imageUrl;

/**
 *  text_detail 内容
 */
@property (nonatomic,copy) NSString *text_detail;

/**
 *  Text的 hight
 */
@property (nonatomic,copy) NSString *text_hight;

/**
 *  gif_hight
 */
@property (nonatomic,copy) NSString *gif_hight;

/**
 *  cell的hight
 */
@property (nonatomic,copy) NSString *cell_hight;

/**
 *  cell的width
 */
@property (nonatomic,copy) NSString *width;

@end
