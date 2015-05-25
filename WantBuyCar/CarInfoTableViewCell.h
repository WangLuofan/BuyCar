//
//  CarInfoTableViewCell.h
//  要买车
//
//  Created by 王落凡 on 15/4/29.
//  Copyright (c) 2015年 王落凡. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CarInfoTableViewCell : UITableViewCell

@property(strong,nonatomic) UIImageView* carImageView;          //车型图片
@property(strong,nonatomic) UILabel* buyerInfoLabel;            //买者信息
@property(strong,nonatomic) UILabel* carInfoLabel;              //车型
@property(strong,nonatomic) UILabel* priceInfoLabel;            //价格
@property(strong,nonatomic) UILabel* offerInfoLabel;            //报价人数
@property(strong,nonatomic) UILabel* dateTimeLabel;             //时间

-(void)setPriceInfo:(NSString*)priceString OfferInfo:(NSString*)offerString;  //设置价格和报价人数

@end
