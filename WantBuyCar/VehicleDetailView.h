//
//  VehicleDetailView.h
//  要买车
//
//  Created by 王落凡 on 15/4/30.
//  Copyright (c) 2015年 王落凡. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol VehicleDetailViewDelegate <NSObject>

@optional
-(void)swipeDetailHandler;
-(void)tableView:(UITableView*)tableView indexPath:(NSIndexPath*)indexPath;

@end

@interface VehicleDetailView : UIView

@property(nonatomic,strong) UITableView* tableView;
@property(nonatomic,assign) id<VehicleDetailViewDelegate> delegate;

-(void)refreshTableViewDataWithBrandName:(NSString*)brandName;

@end
