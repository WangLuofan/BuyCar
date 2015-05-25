//
//  QueryTableViewCell.h
//  要买车
//
//  Created by 王落凡 on 15/5/5.
//  Copyright (c) 2015年 王落凡. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol QueryTableViewCellDelegate <NSObject>

@optional
-(void)queryButtonPressed:(UIButton*)sender;

@end

@interface QueryTableViewCell : UITableViewCell

@property(nonatomic,strong) UIButton* queryButton;
@property(nonatomic,strong) UIButton* addButton;
@property(nonatomic,assign) id<QueryTableViewCellDelegate> delegate;

@end
