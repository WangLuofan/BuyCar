//
//  SetUpTableViewCell.h
//  要买车
//
//  Created by 王落凡 on 15/4/29.
//  Copyright (c) 2015年 王落凡. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SetUpTableViewCell : UITableViewCell

@property(nonatomic,strong) UIImageView* headerImageView;                   //头部图片
@property(nonatomic,strong) UILabel* setOptionLabel;                        //选项名称按钮
@property(nonatomic,strong) UILabel* changeOptionLabel;                     //状态更改按钮

@end
