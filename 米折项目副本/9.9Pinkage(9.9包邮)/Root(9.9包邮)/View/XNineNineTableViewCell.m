//
//  XNineNineTableViewCell.m
//  米折项目
//
//  Created by apple on 16/8/2.
//  Copyright © 2016年 王欣. All rights reserved.
//

#import "XNineNineTableViewCell.h"

@interface XNineNineTableViewCell ()

@property (nonatomic,strong)UILabel * lab;
@property (nonatomic,strong)UILabel * label;

@end

@implementation XNineNineTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (IBAction)btAction:(UIButton *)sender {
}

-(void)addContentForCellWithModel:(XNineNineModel *)model{
    float num = [model.goods_sale_num floatValue]/[model.goods_sum_num floatValue]*100;
    [self.goods_Image sd_setImageWithURL:[NSURL URLWithString:model.goods_image] placeholderImage:[UIImage imageNamed:@"default_loading_100x100"]];
    self.goods_Name.text = model.goods_name;
    self.goods_Price.text = model.goods_price;
    self.goods_Price_ori.text = [NSString stringWithFormat:@"￥%@",model.goods_price_ori];
    self.goods_Sum_Num.text =[NSString stringWithFormat:@"限量%@件",model.goods_sum_num];
    self.goods_bt.layer.cornerRadius =CURRENT_SIZE(7);
    
    float width =self.goods_Num_progremss.frame.size.width /100 * num ;
    self.lab.frame = CGRectMake(self.goods_Num_progremss.frame.origin.x, self.goods_Num_progremss.frame.origin.y, width, self.goods_Num_progremss.frame.size.height);
    [self.contentView addSubview:self.lab];
    self.lab.backgroundColor = [UIColor orangeColor];
    
    self.label.frame = CGRectMake(self.goods_Num_progremss.frame.origin.x, self.goods_Num_progremss.frame.origin.y, self.goods_Num_progremss.frame.size.width, self.goods_Num_progremss.frame.size.height);
    self.label.backgroundColor = [UIColor clearColor];
    self.label.text = [NSString stringWithFormat:@"%.0f%%",num];
    self.label.textColor = [UIColor whiteColor];
    self.label.textAlignment = NSTextAlignmentCenter;
    self.label.font = [UIFont systemFontOfSize:10];
    self.lab.clipsToBounds = YES;
    self.lab.layer.cornerRadius = 5;
    self.goods_Num_progremss.layer.masksToBounds = YES;
    self.goods_Num_progremss.layer.cornerRadius = 5;
    [self.contentView addSubview:self.goods_Num_progremss];
    [self.contentView addSubview:self.label];
    //设置label的中划线
    NSDictionary * attribtDic1 =@{NSStrikethroughStyleAttributeName:[NSNumber numberWithInteger:NSUnderlineStyleSingle]};
    NSMutableAttributedString * string1 = [[NSMutableAttributedString alloc]initWithString:self.goods_Price_ori.text attributes:attribtDic1];
    NSInteger length = [self.goods_Price_ori.text length];
    [string1 addAttribute:NSStrikethroughColorAttributeName  value:[UIColor colorWithRed:0.69 green:0.69 blue:0.69 alpha:1.00] range:NSMakeRange(0, length)];
    self.goods_Price_ori.attributedText = string1;
    
    
}
-(UILabel *)label{
    if (!_label) {
        _label = [[UILabel alloc]init];
    }
    return _label;
}

-(UILabel *)lab{
    if (!_lab) {
        _lab = [[UILabel alloc]init];
    }
    return _lab;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
