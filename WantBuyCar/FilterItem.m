//
//  FilterItem.m
//  要买车
//
//  Created by 王落凡 on 15/4/29.
//  Copyright (c) 2015年 王落凡. All rights reserved.
//

#import "FilterItem.h"
#import "CommAlgorithm.h"

#define IMAGE_RATIO 0.2

@interface FilterItem () {
    UIImageView* filterSeperator;
}

@end

@implementation FilterItem

-(void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    
    [self setContentMode:UIViewContentModeCenter];
    [self setBackgroundImage:[UIImage imageNamed:@"click_bg"] forState:UIControlStateNormal];
    [self.titleLabel setFont:[UIFont systemFontOfSize:14.0f]];
    [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    if(filterSeperator!=nil) {
        [filterSeperator setFrame:CGRectMake(self.bounds.size.width-0.5f, 0, 0.5f, self.bounds.size.height)];
    }
    
    return ;
}

-(void)setWillShowSeperator:(BOOL)willShowSeperator {
    if(willShowSeperator) {
        filterSeperator =[[UIImageView alloc] initWithImage:[CommAlgorithm createImageWithRed:0.647 Green:0.647 Blue:0.647 Alpha:0.5f]];
        [filterSeperator setFrame:CGRectMake(self.bounds.size.width-0.5f, 0, 0.5f, self.bounds.size.height)];
        [self addSubview:filterSeperator];
    }else {
        [filterSeperator removeFromSuperview];
    }
    return ;
}

//-(CGRect)titleRectForContentRect:(CGRect)contentRect {
//    return CGRectMake(0, 0, contentRect.size.width*(1-IMAGE_RATIO), contentRect.size.height);
//}
//
//-(CGRect)imageRectForContentRect:(CGRect)contentRect {
//    return CGRectMake(contentRect.size.width*(1-IMAGE_RATIO), 0, contentRect.size.width*IMAGE_RATIO, contentRect.size.height);
//}


@end
