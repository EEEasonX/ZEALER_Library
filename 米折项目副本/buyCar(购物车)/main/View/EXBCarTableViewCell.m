//
//  EXBCarTableViewCell.m
//  米折项目
//
//  Created by apple on 16/8/9.
//  Copyright © 2016年 EEEasonX. All rights reserved.
//

#import "EXBCarTableViewCell.h"



@interface EXBCarTableViewCell ()

@property (nonatomic,strong) UILabel * text_lab;
@property (nonatomic,strong) UIImageView * image_view;
@end

@implementation EXBCarTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)addContextToCellWithModel:(XBCarModel *)model{
    [self.iconV createIconWithImageURL:model.icon_url username:model.icon_name publicTime:model.icon_time];
    self.text_lab.frame = CGRectMake(CURRENT_SIZE2(10), CURRENT_SIZE2(45), SCREEN_WIDTH-CURRENT_SIZE2(20), [model.text_hight floatValue]);
    self.text_lab.text = model.text_detail;
    self.text_lab.numberOfLines  = 0;
    
    
    
    if ([model.type isEqualToString:@"video"]== YES) {
        
        [self.contentView addSubview:self.image_view];
        self.image_view.frame = CGRectMake(CURRENT_SIZE2(10), self.text_lab.frame.origin.y+ self.text_lab.frame.size.height+CURRENT_SIZE2(5),SCREEN_WIDTH-20, [model.gif_hight floatValue]);
        [self.image_view sd_setImageWithURL:[NSURL URLWithString:model.video_imagrUrl]];
        [self addWidgetToImagViewWithPlayNum:model.video_numPlay longTime:model.video_time];
    }else if ([model.type isEqualToString:@"image"]== YES||[model.type isEqualToString:@"gif"]== YES){
        
        [self.contentView addSubview:self.image_view];
        self.image_view.frame = CGRectMake(10, self.text_lab.frame.size.height+self.text_lab.frame.origin.y, SCREEN_WIDTH-20, [model.gif_hight floatValue]);
        [self.image_view sd_setImageWithURL:[NSURL URLWithString:model.gif_imageUrl]];
    }
    self.gengralView.frame = CGRectMake(0, [model.text_hight floatValue]+[model.gif_hight floatValue]+self.text_lab.frame.origin.y, SCREEN_WIDTH, CURRENT_SIZE(60));
    [self.gengralView addContentWithGategory:model.tags suppurt:model.num_up down:model.num_down share:model.num_share discuss:model.num_comment];
}

- (void)addWidgetToImagViewWithPlayNum:(NSString * )play_num longTime:(NSString *)time{
    UIImageView * imageV = [[UIImageView alloc]initWithFrame:CGRectMake(self.image_view.frame.size.width /2 -CURRENT_SIZE2(20), self.image_view.frame.size.height/2-CURRENT_SIZE2(20), CURRENT_SIZE2(40), CURRENT_SIZE2(40))];
    imageV.image = [UIImage imageNamed:@"首页-播放"];
    [self.image_view addSubview:imageV];
    
    UILabel * play_num_lab = [[UILabel alloc]initWithFrame:CGRectMake(0, self.image_view.frame.size.height -10, 50, 10)];
    play_num_lab.font = [UIFont systemFontOfSize:9];
    play_num_lab.textColor = [UIColor whiteColor];
    play_num_lab.backgroundColor = [UIColor blackColor];
    play_num_lab.text = play_num;
    [self.image_view addSubview:play_num_lab];
    
    UILabel * time_lab = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-50, self.image_view.frame.size.height-10, 30, 10)];
    time_lab.font = [UIFont systemFontOfSize:9];
    time_lab.textColor = [UIColor whiteColor];
    time_lab.backgroundColor = [UIColor blackColor];
    time_lab.text = time;
    [self.image_view addSubview:time_lab];
}
- (GengralView * )gengralView{
    if (!_gengralView) {
        _gengralView = [[GengralView alloc]init];
        [self.contentView addSubview:_gengralView];
    }
    return _gengralView;
}

- (iconView *)iconV{
    if (!_iconV) {
        _iconV = [[iconView alloc]initWithFrame:CGRectMake(CURRENT_SIZE2(10), CURRENT_SIZE2(10), SCREEN_WIDTH-CURRENT_SIZE2(20), CURRENT_SIZE2(30))];
        [self.contentView addSubview:_iconV];
    }
    return _iconV;
}

- (UILabel *)text_lab{
    if (!_text_lab) {
        _text_lab = [[UILabel alloc]init];
        _text_lab.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:_text_lab];
    }
    return _text_lab;
}

- (UIImageView *)image_view{
    if (!_image_view) {
        _image_view = [[UIImageView alloc]init];
        
        _image_view.backgroundColor = [UIColor lightGrayColor];
    }
    return _image_view;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
