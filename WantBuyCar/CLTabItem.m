//
//  CLTabItem.m
//  要买车
//
//  Created by 王落凡 on 15/4/28.
//  Copyright (c) 2015年 王落凡. All rights reserved.
//

#import "CLTabItem.h"

@interface CLTabItem () {
    UIView* badgeView;
    UILabel* badgeNumberLabel;
    NSInteger badgeValue;
}

@end

@implementation CLTabItem

-(void)setBadgeValue:(NSInteger)value {
    
    if(badgeView == nil) {
        badgeView = [[UIView alloc] initWithFrame:CGRectMake(0, self.frame.size.width - 20, 20, 20)];
        [badgeView.layer setCornerRadius:10.0f];
        [badgeView.layer setMasksToBounds:YES];
        [badgeView setBackgroundColor:[UIColor redColor]];
        
        badgeNumberLabel = [[UILabel alloc] initWithFrame:[badgeView frame]];
        [badgeNumberLabel setFont:[UIFont systemFontOfSize:10.0f]];
        [badgeNumberLabel setTextColor:[UIColor whiteColor]];
        [badgeNumberLabel setTextAlignment:NSTextAlignmentCenter];
        [badgeView addSubview:badgeNumberLabel];
        
        [self addSubview:badgeView];
    }

    badgeValue = value;
    [badgeNumberLabel setText:[NSString stringWithFormat:@"%ld",(long)badgeValue]];
    [badgeView setHidden:(badgeValue == 0)];
    
    return ;
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if([keyPath isEqualToString:@"badgeValue"]) {
        NSLog(@"%@",change);
    }
    return ;
}

@end
