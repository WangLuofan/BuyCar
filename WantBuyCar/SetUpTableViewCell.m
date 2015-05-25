//
//  SetUpTableViewCell.m
//  要买车
//
//  Created by 王落凡 on 15/4/29.
//  Copyright (c) 2015年 王落凡. All rights reserved.
//

#import "SetUpTableViewCell.h"
#import "CommAlgorithm.h"
#import "ConstantDef.h"

@implementation SetUpTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if(self) {
        UIImageView* seperatorTop=[[UIImageView alloc] initWithImage:[CommAlgorithm createImageWithRed:0.647 Green:0.647 Blue:0.647 Alpha:0.5f]];
        [seperatorTop setFrame:CGRectMake(0, 10.5f, self.frame.size.width, 0.5f)];
        [self addSubview:seperatorTop];
        
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
        [self setFrame:CGRectMake(0, 0, kScreenWidth, 80)];
        
        self.headerImageView=[[UIImageView alloc] initWithFrame:CGRectMake(10, 20, 40, 40)];
        [self addSubview:self.headerImageView];
        
        self.setOptionLabel=[[UILabel alloc] initWithFrame:CGRectMake(60, 0, 150, 20)];
        [self.setOptionLabel setCenter:CGPointMake(self.setOptionLabel.center.x, self.headerImageView.center.y)];
        [self.setOptionLabel setFont:[UIFont systemFontOfSize:12.0f]];
        [self.setOptionLabel setTextColor:[UIColor grayColor]];
        [self addSubview:self.setOptionLabel];
        
        self.changeOptionLabel=[[UILabel alloc] initWithFrame:CGRectMake(self.bounds.size.width-70, 0, 50, 20)];
        [self.changeOptionLabel setCenter:CGPointMake(self.changeOptionLabel.center.x, self.headerImageView.center.y)];
        [self.changeOptionLabel setFont:[UIFont systemFontOfSize:14.0f]];
        [self.changeOptionLabel setTextColor:[UIColor orangeColor]];
        [self addSubview:self.changeOptionLabel];
        
        UIImageView* seperatorBottom=[[UIImageView alloc] initWithImage:[CommAlgorithm createImageWithRed:0.647 Green:0.647 Blue:0.647 Alpha:0.5f]];
        [seperatorBottom setFrame:CGRectMake(0, self.frame.size.height-10.5f, self.frame.size.width, 0.5f)];
        [self addSubview:seperatorBottom];
    }
    
    return self;
}

@end
