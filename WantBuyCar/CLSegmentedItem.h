//
//  CLSegmentedItem.h
//  要买车
//
//  Created by 王落凡 on 15/5/3.
//  Copyright (c) 2015年 王落凡. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CLSegmentedItem;
@protocol CLSegmentedItemDelegate <NSObject>

@optional
-(void)segmentedItem:(CLSegmentedItem*)segmentedItem;

@end

@interface CLSegmentedItem : UIView

@property(nonatomic,strong) UILabel* titleLabel;
@property(nonatomic,strong) UIImageView* imageView;

@property(nonatomic,assign) id<CLSegmentedItemDelegate> delegate;

-(instancetype)initWithTitle:(NSString*)title Image:(NSString*)image;
-(void)setSelected:(BOOL)selected;

@end
