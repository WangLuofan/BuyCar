//
//  ChatTabView.h
//  要买车
//
//  Created by 王落凡 on 15/5/5.
//  Copyright (c) 2015年 王落凡. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ChatTabView;
@protocol ChatTabViewDelegate <NSObject>

@optional
-(void)tabView:(ChatTabView*)tabView message:(NSString*)message;
-(void)chooseImageButtonPressed;

@end

@interface ChatTabView : UIView

@property (nonatomic,assign) id<ChatTabViewDelegate> delegate;

@end
