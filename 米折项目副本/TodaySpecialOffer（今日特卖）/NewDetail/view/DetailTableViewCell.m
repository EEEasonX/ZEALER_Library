//
//  DetailTableViewCell.m
//  MiZhe
//
//  Created by ading on 16/7/25.
//  Copyright © 2016年 阿鼎. All rights reserved.
//

#import "DetailTableViewCell.h"


@interface DetailTableViewCell ()

@end


@implementation DetailTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
}






-(void)addContentWithModel:(DetailModel *)leftmodel RightModel:(DetailModel *)rightmodel Tag:(NSInteger)tag{
    
    self.contentView.backgroundColor=[UIColor colorWithRed:0.97 green:0.97 blue:0.97 alpha:1.00];
    
    for (int i=0; i<2; i++) {
        UIView *vi=[[UIView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2.0*i, 0, (SCREEN_WIDTH-10)/2.0, CURRENT_SIZE(200))];
        
        UIImageView *main_imageview=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, CURRENT_SIZE(187), CURRENT_SIZE(180))];
        
        
        UILabel *name_label=[[UILabel alloc]initWithFrame:CGRectMake(CURRENT_SIZE(5), main_imageview.frame.origin.y+main_imageview.frame.size.height,SCREEN_WIDTH/2-10, CURRENT_SIZE(40))];
        
        name_label.font=[UIFont systemFontOfSize:12];
        
        name_label.numberOfLines=0;
        
        UILabel *price_label=[[UILabel alloc]initWithFrame:CGRectMake(5, name_label.frame.origin.y+name_label.frame.size.height, CURRENT_SIZE(80), CURRENT_SIZE(20))];
        
        price_label.textColor=[UIColor redColor];
        
        price_label.textAlignment=NSTextAlignmentCenter;
        
        price_label.font=[UIFont systemFontOfSize:12];
        
        
        UILabel *discount_label=[[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2-CURRENT_SIZE(80), price_label.frame.origin.y, 80, 20)];
        
        discount_label.textColor=[UIColor colorWithRed:0.77 green:0.77 blue:0.77 alpha:1.00];
        
        discount_label.font=[UIFont systemFontOfSize:11];
        
        discount_label.textAlignment=NSTextAlignmentLeft;
        
        
        if (i==0) {
            vi.tag=tag+100;
            
            
            [main_imageview sd_setImageWithURL:[NSURL URLWithString:leftmodel.img_name] placeholderImage:[UIImage imageNamed:@"default_loading_320-320"]];
            
            name_label.text=leftmodel.product_title;
            
            price_label.text=[NSString stringWithFormat:@"¥%@",leftmodel.price];
            
            discount_label.text=leftmodel.sale_tip;
            
            
        }else{
            vi.tag=tag+500;
            
            [main_imageview sd_setImageWithURL:[NSURL URLWithString:rightmodel.img_name] placeholderImage:[UIImage imageNamed:@"default_loading_320-320"]];
            
            name_label.text=rightmodel.product_title;
            
            price_label.text=[NSString stringWithFormat:@"¥%@",rightmodel.price];
            
            discount_label.text=rightmodel.sale_tip;
            
        }
        
        [vi addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewAction:)]];
        
        [self.contentView addSubview:vi];
        
        [vi addSubview:main_imageview];
        
        [vi addSubview:name_label];
        
        [vi addSubview:price_label];
        
        [vi addSubview:discount_label];
        
    }
}


-(void)viewAction:(UITapGestureRecognizer *)tap{
    
    if (tap.view.tag>500) {
        NSLog(@"点击了右边");
        self.block(tap.view.tag-500);
    }else{
        
        NSLog(@"点击了左边");
        self.block(tap.view.tag-100);
    }
    
}






- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
