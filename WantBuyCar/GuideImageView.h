//
//  GuideImageView.h
//  要买车
//
//  Created by 王落凡 on 15/4/24.
//  Copyright (c) 2015年 王落凡. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol GuideImageViewDelegate <NSObject>

@required
-(void)buttonPressedByIndex:(NSInteger)index;

@end

@interface GuideImageView : UIImageView

@property(nonatomic,assign) id<GuideImageViewDelegate> delegate;

@end
