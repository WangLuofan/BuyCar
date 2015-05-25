//
//  NewestHeaderView.h
//  要买车
//
//  Created by 王落凡 on 15/5/5.
//  Copyright (c) 2015年 王落凡. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewestHeaderView : UIView

@property(nonatomic,strong) UITableView* tableView;
@property(nonatomic,strong) UILabel* commentLabel;
@property(nonatomic,strong) UIButton* expandButton;
@property(nonatomic,strong) UIView* seperatorView;

@end