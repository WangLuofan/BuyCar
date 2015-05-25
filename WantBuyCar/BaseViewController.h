//
//  BaseViewController.h
//  要买车
//
//  Created by 王落凡 on 15/5/4.
//  Copyright (c) 2015年 王落凡. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController <UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong) UITableView* tableView;

@end
