//
//  ChatRecordTableViewCell.m
//  要买车
//
//  Created by 王落凡 on 15/5/7.
//  Copyright (c) 2015年 王落凡. All rights reserved.
//

#import "ChatRecordTableViewCell.h"

@implementation ChatRecordTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if(self) {
        
        //头像
        self.headerImage = [[UIImageView alloc] initWithFrame:CGRectMake(10, 0, 30, 30)];
        [self.headerImage setCenter:CGPointMake(self.headerImage.center.x, 40)];
        [self addSubview:self.headerImage];
        
        //用户名
        self.userInfoLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 10, self.frame.size.width - 50, 20)];
        [self.userInfoLabel setFont:[UIFont systemFontOfSize:12.0f]];
        [self addSubview:self.userInfoLabel];
        
        //经营品牌
        self.vehicleInfoLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 30, self.frame.size.width - 50, 20)];
        [self.vehicleInfoLabel setFont:[UIFont systemFontOfSize:12.0f]];
        [self.vehicleInfoLabel setTextColor:[UIColor lightGrayColor]];
        [self addSubview:self.vehicleInfoLabel];
        
        //电话号码
        self.phoneNumberInfoLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 50, self.frame.size.width - 100, 20)];
        [self.phoneNumberInfoLabel setFont:[UIFont systemFontOfSize:10.0]];
        [self.phoneNumberInfoLabel setTextColor:[UIColor lightGrayColor]];
        [self addSubview:self.phoneNumberInfoLabel];
        
        //时间
        self.dateInfoLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width-100, 50, 100, 20)];
        [self.dateInfoLabel setFont:[UIFont systemFontOfSize:10.0f]];
        [self.dateInfoLabel setTextColor:[UIColor lightGrayColor]];
        [self addSubview:self.dateInfoLabel];
    }
    
    return self;
}

@end
