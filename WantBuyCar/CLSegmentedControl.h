//
//  CLSegmentedControl.h
//  要买车
//
//  Created by 王落凡 on 15/4/28.
//  Copyright (c) 2015年 王落凡. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    CLSegmentedControlStyleRound,CLSegmentedControlStyleRect
}CLSegmentedControlStyle;

@class CLSegmentedControl;
@protocol CLSegmentedControlDelegate <NSObject>

@optional
-(void)segmentedControl:(CLSegmentedControl*)segmentedControl selectedItemIndex:(NSInteger)selectedItemIndex;

@end

@interface CLSegmentedControl : UIView

@property(nonatomic,assign) id<CLSegmentedControlDelegate> delegate;

-(instancetype)initWithFrame:(CGRect)frame style:(CLSegmentedControlStyle)style;
-(void)addItemByTitle:(NSString*)title Image:(NSString*)image;

@end
