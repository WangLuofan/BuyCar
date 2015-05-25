//
//  HeaderSimpleTableViewCell.h
//  要买车
//
//  Created by 王落凡 on 15/5/7.
//  Copyright (c) 2015年 王落凡. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HeaderSimpleTableViewCell : UITableViewCell

@property(strong,nonatomic) UIImageView* headerImageView;
@property(nonatomic,strong) UILabel* vehicleInfoLabel;
@property(nonatomic,strong) UILabel* dateLabel;
@property(nonatomic,strong) NSMutableArray* descInfoLabelArray;

-(void)addDescribeInfo:(NSString*)desc;
-(void)addOfferInfoWithCount:(NSInteger)count price:(CGFloat)price;

@end