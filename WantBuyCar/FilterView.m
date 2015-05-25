//
//  FilterView.m
//  要买车
//
//  Created by 王落凡 on 15/4/28.
//  Copyright (c) 2015年 王落凡. All rights reserved.
//

#import "FilterView.h"
#import "FilterItem.h"
#import "CommAlgorithm.h"

@implementation FilterView

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if(self) {
        [self addFilterItemTitle:@"品牌" showSeperator:YES];
        [self addFilterItemTitle:@"车型" showSeperator:YES];
        [self addFilterItemTitle:@"配置" showSeperator:YES];
        [self addFilterItemTitle:@"时间" showSeperator:NO];

        UIImageView* seperator=[[UIImageView alloc] initWithImage:[CommAlgorithm createImageWithRed:0.647 Green:0.647 Blue:0.647 Alpha:0.5f]];
        [seperator setFrame:CGRectMake(0, self.frame.size.height-0.5f, self.frame.size.width, 0.5f)];
        [self addSubview:seperator];
    }
    
    return self;
}

-(void)addFilterItemTitle:(NSString *)title showSeperator:(BOOL)showSeperator{
    FilterItem* item=[FilterItem buttonWithType:UIButtonTypeCustom];
    [item setTitle:title forState:UIControlStateNormal];
    [item setWillShowSeperator:showSeperator];
    [self addSubview:item];
    
    float controlWidth=self.bounds.size.width/self.subviews.count;
    for(int i=0;i!=self.subviews.count;++i) {
        FilterItem* filterItem=(FilterItem*)self.subviews[i];
        [filterItem setFrame:CGRectMake(i*controlWidth, 0, controlWidth, self.bounds.size.height)];
    }
    
    return ;
}

@end