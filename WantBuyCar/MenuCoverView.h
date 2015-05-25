//
//  MenuCoverView.h
//  要买车
//
//  Created by 王落凡 on 15/4/28.
//  Copyright (c) 2015年 王落凡. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MenuCoverViewDelegate <NSObject>

@optional
-(void)coverViewTouched;

@end

@interface MenuCoverView : UIView

@property(nonatomic,assign) BOOL isCoverViewShown;
@property(nonatomic,assign) id<MenuCoverViewDelegate> delegate;

@end
