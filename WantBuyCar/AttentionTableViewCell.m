//
//  AttentionTableViewCell.m
//  要买车
//
//  Created by 王落凡 on 15/4/30.
//  Copyright (c) 2015年 王落凡. All rights reserved.
//

#import "AttentionTableViewCell.h"
#import "ConstantDef.h"

@implementation AttentionTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if(self) {
        [self setFrame:CGRectMake(0, 0, kScreenWidth, 60)];
        
        //头像
        self.headerImageView=[[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 40, 40)];
        [self.headerImageView.layer setCornerRadius:20.0f];
        [self addSubview:self.headerImageView];
        
        //名字
        self.nameInfoLabel=[[UILabel alloc] initWithFrame:CGRectMake(60, 10, 100, 20)];
        [self.nameInfoLabel setFont:[UIFont systemFontOfSize:10.0f]];
        [self.nameInfoLabel setTextColor:[UIColor grayColor]];
        [self addSubview:self.nameInfoLabel];
        
        //车型
        self.carInfoLabel=[[UILabel alloc]initWithFrame:CGRectMake(60, 30, 150, 20)];
        [self.carInfoLabel setFont:[UIFont systemFontOfSize:12.0f]];
        [self addSubview:self.carInfoLabel];
        
        //报价
        self.offerInfoButton=[UIButton buttonWithType:UIButtonTypeCustom];
        [self.offerInfoButton setFrame:CGRectMake(kScreenWidth-100, 10, 80, 20)];
        [self.offerInfoButton setImage:[UIImage imageNamed:@"offer"] forState:UIControlStateNormal];
        [self.offerInfoButton.imageView setContentMode:UIViewContentModeScaleAspectFit];
        [self.offerInfoButton setTitle:@"已报价" forState:UIControlStateNormal];
        [self.offerInfoButton.titleLabel setFont:[UIFont systemFontOfSize:10.0f]];
        [self.offerInfoButton setTitleEdgeInsets:UIEdgeInsetsMake(0, -15, 0, 0)];
        [self.offerInfoButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [self addSubview:self.offerInfoButton];
        
        //价格信息
        self.priceInfoLabel=[[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth-100, 30, 80, 20)];
        [self.priceInfoLabel setTextColor:[UIColor redColor]];
        [self.priceInfoLabel setTextAlignment:NSTextAlignmentCenter];
        [self.priceInfoLabel setFont:[UIFont systemFontOfSize:12.0f]];
        [self addSubview:self.priceInfoLabel];
    }
    
    return self;
}

@end
