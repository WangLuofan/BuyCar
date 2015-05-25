//
//  EmojiPageView.h
//  要买车
//
//  Created by 王落凡 on 15/5/8.
//  Copyright (c) 2015年 王落凡. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol EmojiPageViewDelegate <NSObject>

@optional
-(void)selectionEmoji:(NSString*)emojiString;

@end

@interface EmojiPageView : UIView

@property (nonatomic,assign) id<EmojiPageViewDelegate> delegate;

-(instancetype)initWithFrame:(CGRect)frame EmojiArray:(NSMutableArray*)emojiArray CurrentPageIndex:(NSInteger)currentPageIndex;

@end
