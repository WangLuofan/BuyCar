//
//  CommentTableViewCell.h
//  要买车
//
//  Created by 王落凡 on 15/5/5.
//  Copyright (c) 2015年 王落凡. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CommentTableViewCell : UITableViewCell

@property(nonatomic,strong) UIImageView* headerImage;
@property(nonatomic,strong) UILabel* usernameLabel;
@property(nonatomic,strong) UILabel* commentLabel;
@property(nonatomic,strong) UILabel* attendLabel;

-(CGFloat)cellHeight;

@end
