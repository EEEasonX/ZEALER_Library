//
//  XPTTableViewcell.m
//  米折项目
//
//  Created by apple on 16/8/3.
//  Copyright © 2016年 王欣. All rights reserved.
//

#import "XPTTableViewcell.h"

@implementation XPTTableViewcell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)addContentForCellWithModel:(XPTModel *)model{
    [self.pt_image sd_setImageWithURL:[NSURL URLWithString:model.pt_image_url]placeholderImage:[UIImage imageNamed:@"default_loading_320-130"]];
    [self.but_sum setTitle:model.pt_buying_info forState:UIControlStateNormal] ;
    self.pt_title.text = model.pt_title;
    
    NSArray * now_price_arr = [model.pt_now_price componentsSeparatedByString:@"."];
    
    self.pt_now_price.text = now_price_arr[0];
    if ([now_price_arr[1] isEqualToString:@"0"] == YES) {
        self.pt_now_2_price.text =@"";
    }else{
        self.pt_now_2_price.text =[NSString stringWithFormat:@".%@", now_price_arr[1]];
    }
    
    self.pt_old_price.text = [NSString stringWithFormat:@"￥%@",model.pt_old_price];
    
    [self.pt_tuan setTitle:model.pt_present forState:UIControlStateNormal];
    self.pt_tuan.layer.cornerRadius = 2;
    self.pt_tuan.layer.borderWidth = 1;
    self.pt_tuan.layer.borderColor = SELECT_COLOR(247, 69, 0, 1).CGColor;
    //设置label的中划线
    NSDictionary * attribtDic1 =@{NSStrikethroughStyleAttributeName:[NSNumber numberWithInteger:NSUnderlineStyleSingle]};
    NSMutableAttributedString * string1 = [[NSMutableAttributedString alloc]initWithString:self.pt_old_price.text attributes:attribtDic1];
    NSInteger length = [self.pt_old_price.text length];
    [string1 addAttribute:NSStrikethroughColorAttributeName  value:[UIColor colorWithRed:0.69 green:0.69 blue:0.69 alpha:1.00] range:NSMakeRange(0, length)];
    self.pt_old_price.attributedText = string1;
    
}
- (IBAction)PTbtAction:(UIButton *)sender {
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
