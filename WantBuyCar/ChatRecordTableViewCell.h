//
//  ChatRecordTableViewCell.h
//  要买车
//
//  Created by 王落凡 on 15/5/7.
//  Copyright (c) 2015年 王落凡. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChatRecordTableViewCell : UITableViewCell

@property(nonatomic,strong) UIImageView* headerImage;
@property(nonatomic,strong) UILabel* userInfoLabel;
@property(nonatomic,strong) UILabel* vehicleInfoLabel;
@property(nonatomic,strong) UILabel* phoneNumberInfoLabel;
@property(nonatomic,strong) UILabel* dateInfoLabel;

@end
