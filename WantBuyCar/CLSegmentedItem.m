//
//  CLSegmentedItem.m
//  要买车
//
//  Created by 王落凡 on 15/5/3.
//  Copyright (c) 2015年 王落凡. All rights reserved.
//

#import "CLSegmentedItem.h"
#define IMAGE_RATIO 0.3

@implementation CLSegmentedItem

-(instancetype)initWithTitle:(NSString *)title Image:(NSString *)image {
    self = [super init];
    
    if(self) {
        if(title==nil&&image==nil)
            @throw @"Title and Image are all nil";
        
        if(title) {
            self.titleLabel = [[UILabel alloc] init];
            [self.titleLabel setText:title];
            [self.titleLabel setTextColor:[UIColor grayColor]];
            [self.titleLabel setTextAlignment:NSTextAlignmentCenter];
            [self addSubview:self.titleLabel];
        }
        if(image) {
            self.imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:image]];
            [self.imageView setContentMode:UIViewContentModeRight];
            [self addSubview:self.imageView];
        }
    }
    
    return self;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.delegate segmentedItem:self];
    return ;
}

-(void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    
    if(self.titleLabel==nil)
       [self.imageView setFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
    else if(self.imageView==nil)
        [self.titleLabel setFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
    else
    {
        [self.imageView setFrame:CGRectMake(0, 0, self.frame.size.width*IMAGE_RATIO,self.frame.size.height)];
        [self.titleLabel setFrame:CGRectMake(self.frame.size.width*IMAGE_RATIO, 0, self.frame.size.width*(1-IMAGE_RATIO), frame.size.height)];
    }
    
    return ;
}

-(void)setSelected:(BOOL)selected {
    //选择状态
    if(selected) {
        [self.titleLabel setTextColor:[UIColor whiteColor]];
        [self setBackgroundColor:[UIColor orangeColor]];
    }else {
        [self.titleLabel setTextColor:[UIColor grayColor]];
        [self setBackgroundColor:[UIColor whiteColor]];
    }
    
    return ;
}

@end
