//
//  MenuItemView.h
//  要买车
//
//  Created by 王落凡 on 15/4/28.
//  Copyright (c) 2015年 王落凡. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MenuItemViewDelegate <NSObject>

@optional
-(void)menuItemClicked:(NSInteger)menuIndex;
-(void)logout;

@end

@interface MenuItemView : UIView

-(void)showMenuItem;
-(void)hideMenuItem;
-(void)setUserInfoWithHeaderURLString:(NSString*)headerURL UserName:(NSString*)userName;
-(void)clearUserInfo;

@property(nonatomic,assign) BOOL isLoginSuccessful;
@property(nonatomic,assign) id<MenuItemViewDelegate> delegate;

@property(nonatomic,strong) UIButton* logoutButton;
@property(nonatomic,strong) UIImageView* headerImageView;
@property(nonatomic,strong) UILabel* userNameLabel;
@property(nonatomic,strong) UILabel* loginDateLabel;

-(void)setLoginSuccessful:(BOOL)isLoginSuccessful;

@end
