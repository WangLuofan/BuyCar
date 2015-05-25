//
//  CLAlertView.h
//  要买车
//
//  Created by 王落凡 on 15/5/3.
//  Copyright (c) 2015年 王落凡. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CLAlertView;
@protocol CLAlertViewDelegate <NSObject>

@optional
-(void)alertView:(CLAlertView*)alertView buttonPressedIndex:(NSInteger)buttonPressedIndex;

@end

@interface CLAlertView : UIWindow

@property(nonatomic,strong) UIView* controlView;
@property(nonatomic,strong) UIView* messageView;
@property(nonatomic,assign) id<CLAlertViewDelegate> AlertDelegate;

-(instancetype)initWithTitle:(NSString*)title frame:(CGRect)frame message:(NSString*)message delegate:(id<CLAlertViewDelegate>)delegate cancelButtonTitle:(NSString*)cancelButtonTitle otherButtonTitles:(NSString *)otherButtonTitles, ...NS_REQUIRES_NIL_TERMINATION;

-(void)show;
-(void)dismiss;
-(void)customAlertViewContents;
-(void)customAllAlertViewControlls;
-(void)addAttributedMessage:(NSAttributedString*)attributedString;

@end
