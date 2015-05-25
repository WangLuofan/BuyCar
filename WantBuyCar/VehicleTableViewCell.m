//
//  VehicleTableViewCell.m
//  要买车
//
//  Created by 王落凡 on 15/5/3.
//  Copyright (c) 2015年 王落凡. All rights reserved.
//

#import "VehicleTableViewCell.h"

@implementation VehicleTableViewCell

-(void)layoutSubviews {
    [super layoutSubviews];
    
    if([[[UIDevice currentDevice] systemVersion] floatValue] > 7.0f) {
        [self.imageView setFrame:CGRectMake(0, self.imageView.frame.origin.y, self.imageView.frame.size.width, self.imageView.frame.size.height)];
    }
    
    return ;
}

@end
