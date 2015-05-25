//
//  OfferTableViewCell.h
//  要买车
//
//  Created by 王落凡 on 15/5/4.
//  Copyright (c) 2015年 王落凡. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol OfferTableViewCellDelegate <NSObject>

@optional
-(void)offerButtonPressed;
-(void)addAttentionButtonPressed;

@end

@interface OfferTableViewCell : UITableViewCell

@property(nonatomic,strong) UIImageView* vehicleImageView;
@property(nonatomic,strong) UIImageView* verificationImageView;
@property(nonatomic,strong) UILabel* userLabel;
@property(nonatomic,strong) UILabel* infoLabel;
@property(nonatomic,strong) UILabel* priceLabel;
@property(nonatomic,strong) UILabel* dateLabel;
@property(nonatomic,strong) UIButton* addAttentionButton;
@property(nonatomic,strong) UIButton* offerButton;

@property(nonatomic,assign) id<OfferTableViewCellDelegate> delegate;

-(void)setPrice:(NSString*)priceString;

@end
