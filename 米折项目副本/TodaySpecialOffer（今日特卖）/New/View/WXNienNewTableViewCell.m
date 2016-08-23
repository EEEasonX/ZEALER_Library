//
//  WXNienNewTableViewCell.m
//  米折项目
//
//  Created by sh on 16/7/22.
//  Copyright © 2016年 王欣. All rights reserved.
//

#import "WXNienNewTableViewCell.h"

@interface WXNienNewTableViewCell ()
{
    NSInteger _day;
  
}

/** 专场标题 */
@property(nonatomic,strong)UILabel * martshows_title;

/** 专场大图 */
@property(nonatomic,strong)UIImageView * martshows_mainImage;

/** 专场剩余时间 */
@property(nonatomic,strong)UILabel * martshows_lost;

/** 专场折扣 */
@property(nonatomic,strong)UILabel * martshows_promotion;

/** 专场满减 */
@property(nonatomic,strong)UILabel * martshows_mjpromotion;

/** 专场优惠底图 */
@property(nonatomic,strong)UILabel * martshows_mj_down;

/** 专场优惠减字图 */
@property(nonatomic,strong)UIImageView * martshows_mj_jian;

/** 专场上新 */
@property(nonatomic,strong)UIImageView * martshows_img_tr;



@end


@implementation WXNienNewTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

#pragma marl ------ 添加 -------
-(void)addContentForCellWithModel:(WXNewNineModel *)model{
    self.contentView.backgroundColor = SELECT_COLOR(220, 220, 220, 1);
    
    [self.martshows_mainImage sd_setImageWithURL:[NSURL URLWithString:model.martshows_mainImage] placeholderImage:[UIImage imageNamed:@"default_loading_320-130"]];
    self.martshows_promotion.text= model.martshows_promotion;
    [self.martshows_img_tr sd_setImageWithURL:[NSURL URLWithString:model.martshows_img_tr] placeholderImage:[UIImage imageNamed:@""]];
    self.martshows_title.text = model.martshows_title;
    [self martshows_mj_down];
    [self martshows_mj_jian];
    self.martshows_mjpromotion.text = model.martshows_mjpromotion;
    
    [self setLostTimer:model.martshows_end];
}

#pragma mark ------ 懒加载 ------
-(UIImageView *)martshows_mainImage{
    if (!_martshows_mainImage) {
        _martshows_mainImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, CURRENT_SIZE(180))];
        
        [self.contentView addSubview:_martshows_mainImage];
    }
    return _martshows_mainImage;
}

-(UIImageView *)martshows_img_tr{
    if (!_martshows_img_tr) {
        _martshows_img_tr = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-CURRENT_SIZE(60), 0, CURRENT_SIZE(60), CURRENT_SIZE(60))];
        
        [self.contentView addSubview:_martshows_img_tr];
    }
    return _martshows_img_tr;
    
}

-(UILabel *)martshows_mj_down{
    if (!_martshows_mj_down) {
        _martshows_mj_down = [[UILabel alloc]initWithFrame:CGRectMake(0, CURRENT_SIZE(150), SCREEN_WIDTH/4, CURRENT_SIZE(20))];
        _martshows_mj_down.backgroundColor = SELECT_COLOR(255, 255, 255, 0.5);
        
        [self.contentView addSubview:_martshows_mj_down];
        
    }
    return _martshows_mj_down;
}

-(UIImageView *)martshows_mj_jian{
    if (!_martshows_mj_jian) {
        _martshows_mj_jian = [[UIImageView alloc]initWithFrame:CGRectMake(CURRENT_SIZE(3), CURRENT_SIZE(4), CURRENT_SIZE(15), CURRENT_SIZE(15))];
        _martshows_mj_jian.image = [UIImage imageNamed:@"img_detail_jian"];
        [self.martshows_mj_down addSubview:_martshows_mj_jian];
        
    }
    return _martshows_mj_jian;
}

-(UILabel *)martshows_mjpromotion{
    if (!_martshows_mjpromotion) {
        _martshows_mjpromotion = [[UILabel alloc]initWithFrame:CGRectMake(CURRENT_SIZE(20), CURRENT_SIZE(2), SCREEN_WIDTH / 4 -CURRENT_SIZE(20), CURRENT_SIZE(16))];

        _martshows_mjpromotion.font=[UIFont systemFontOfSize:10];
        _martshows_mjpromotion.textColor = [UIColor blackColor];
        [self.martshows_mj_down addSubview:_martshows_mjpromotion];
    }
    return _martshows_mjpromotion;
}

-(UILabel *)martshows_promotion{
    if (!_martshows_promotion) {
        _martshows_promotion = [[UILabel alloc]initWithFrame:CGRectMake(CURRENT_SIZE(0), CURRENT_SIZE(180), CURRENT_SIZE(80), CURRENT_SIZE(25))];
        _martshows_promotion.textColor = SELECT_COLOR(248, 130, 21, 1);
        _martshows_promotion.font = [UIFont systemFontOfSize:14];
        _martshows_promotion.backgroundColor = [UIColor whiteColor];
        _martshows_promotion.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_martshows_promotion];
    }
    return _martshows_promotion;
}

-(UILabel *)martshows_title{
    if (!_martshows_title) {
        _martshows_title = [[UILabel alloc]initWithFrame:CGRectMake(CURRENT_SIZE(70), CURRENT_SIZE(180), SCREEN_WIDTH /3 *2, CURRENT_SIZE(25))];
        _martshows_title.font=[UIFont systemFontOfSize:14];
        _martshows_title.textColor= [UIColor blackColor];
        _martshows_title.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:_martshows_title];
        
    }
    return _martshows_title;
}

-(UILabel *)martshows_lost{
    if (!_martshows_lost) {
        _martshows_lost = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - CURRENT_SIZE(60), CURRENT_SIZE(180), CURRENT_SIZE(60), CURRENT_SIZE(25))];
        _martshows_lost.textColor =SELECT_COLOR(167, 165, 168, 1);
        _martshows_lost.font=[UIFont systemFontOfSize:13];
        _martshows_lost.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:_martshows_lost];
    }
    return _martshows_lost;
}


#pragma mark ------ 时间 ------
-(void)setLostTimer:(NSNumber *)endTime{
    //时间戳转化为字符串
    NSString * end_time = [NSString stringWithFormat:@"%@",endTime];
    //将时间戳转化为时间
    NSTimeInterval timer =[end_time doubleValue];
    //这里的转化时间不是当前时区的时间
    NSDate * end_date = [NSDate dateWithTimeIntervalSince1970:timer];
    //计算当前时间与结束时间的时间差 这里的当前时间也不是当前时区的时间
    NSTimeInterval time_interval = [end_date timeIntervalSinceNow];
    
    _day = time_interval /3600/24;
    self.martshows_lost.text =[NSString stringWithFormat:@"剩%ld天",_day];
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
