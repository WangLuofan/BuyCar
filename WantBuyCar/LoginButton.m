//
//  LoginButton.m
//  要买车
//
//  Created by 王落凡 on 15/4/27.
//  Copyright (c) 2015年 王落凡. All rights reserved.
//

#import "LoginButton.h"

#define IMAGE_RAITO 0.3

@implementation LoginButton

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if(self) {
        [self.titleLabel setFont:[UIFont systemFontOfSize:11.0f]];
        [self setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
        [self.imageView setContentMode:UIViewContentModeScaleAspectFit];
    }
    
    return self;
}

-(void)setTitle:(NSString *)title Image:(NSString *)image {
    [self setTitle:title forState:UIControlStateNormal];
    [self setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    return ;
}

-(CGRect)titleRectForContentRect:(CGRect)contentRect {
    return CGRectMake(contentRect.origin.x+contentRect.size.width*IMAGE_RAITO + 5, contentRect.origin.y, contentRect.size.width*(1-IMAGE_RAITO), contentRect.size.height);
}

-(CGRect)imageRectForContentRect:(CGRect)contentRect {
    return CGRectMake(contentRect.origin.x, contentRect.origin.y, contentRect.size.width*IMAGE_RAITO, contentRect.size.height);
}

@end
