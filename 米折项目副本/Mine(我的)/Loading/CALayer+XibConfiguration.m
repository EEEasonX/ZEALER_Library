//
//  CALayer+XibConfiguration.m
//  米折项目
//
//  Created by apple on 16/8/5.
//  Copyright © 2016年 王欣. All rights reserved.
//

#import "CALayer+XibConfiguration.h"

@implementation CALayer (XibConfiguration)

-(void)setBorderUIColor:(UIColor*)color

{
    
    self.borderColor = color.CGColor;
    
}

-(UIColor*)borderUIColor

{
    
    return [UIColor colorWithCGColor:self.borderColor];
    
}



@end
