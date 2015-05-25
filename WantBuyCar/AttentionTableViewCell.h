//
//  AttentionTableViewCell.h
//  要买车
//
//  Created by 王落凡 on 15/4/30.
//  Copyright (c) 2015年 王落凡. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AttentionTableViewCell : UITableViewCell

@property(nonatomic,strong) UIImageView* headerImageView;
@property(nonatomic,strong) UILabel* nameInfoLabel;
@property(nonatomic,strong) UILabel* carInfoLabel;
@property(nonatomic,strong) UIButton* offerInfoButton;
@property(nonatomic,strong) UILabel* priceInfoLabel;

@end
