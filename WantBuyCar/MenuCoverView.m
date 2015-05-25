//
//  MenuCoverView.m
//  要买车
//
//  Created by 王落凡 on 15/4/28.
//  Copyright (c) 2015年 王落凡. All rights reserved.
//

#import "MenuCoverView.h"
#import "ConstantDef.h"

@interface MenuCoverView () {
    BOOL bFirstSetHidden;
}

@end

@implementation MenuCoverView

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if(self) {
        bFirstSetHidden=YES;
        [self setHidden:YES];
        [self setIsCoverViewShown:NO];
        [self setBackgroundColor:[UIColor blackColor]];
    }
    
    return self;
}

-(void)setHidden:(BOOL)hidden {
    if(bFirstSetHidden) {
        bFirstSetHidden=NO;
        [self setAlpha:0.0f];
        return ;
    }
    [UIView animateWithDuration:kAnimateInterval animations:^{
        if(hidden) {
            [self setAlpha:0.0f];
        }else {
            [self setAlpha:0.4f];
        }
    }];
    return ;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.delegate coverViewTouched];
    return ;
}

@end
