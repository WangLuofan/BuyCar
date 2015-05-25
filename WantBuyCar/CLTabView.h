//
//  CLTabView.h
//  要买车
//
//  Created by 王落凡 on 15/4/28.
//  Copyright (c) 2015年 王落凡. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CLTabViewDelegate <NSObject>

@optional
-(void)ChangeTabTagFrom:(NSInteger)tagFrom TagTo:(NSInteger)tagTo;

@end

@interface CLTabView : UIView

@property(nonatomic,assign) id<CLTabViewDelegate> delegate;
-(void)addTabItemByTitle:(NSString*)title Image:(NSString*)image SelectedImage:(NSString*)selectedImage;

@end
