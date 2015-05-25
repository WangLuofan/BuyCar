//
//  EmojiPageView.m
//  要买车
//
//  Created by 王落凡 on 15/5/8.
//  Copyright (c) 2015年 王落凡. All rights reserved.
//

#import "Emoji.h"
#import "CommAlgorithm.h"
#import "ConstantDef.h"
#import "EmojiPageView.h"

@implementation EmojiPageView

-(instancetype)initWithFrame:(CGRect)frame EmojiArray:(NSMutableArray*)emojiArray
            CurrentPageIndex:(NSInteger)currentPageIndex{
    self = [super initWithFrame:frame];
    
    if(self) {
        
        int xSpacing = (self.frame.size.width - kEmojiRows*kEmojiWidth) / kEmojiRows;
        int ySpacing = (kEmojiKeyboardHeight - kKeyBoardSpacing - kEmojiCols*kEmojiHeight) / kEmojiCols;
        for (int col = 0; col != kEmojiCols; ++col) {
            for (int row = 0; row != kEmojiRows; ++row) {
                if([emojiArray[col*kEmojiRows+row + currentPageIndex*kEmojiCols*kEmojiRows] isEqualToString:@"0"])
                    return  self;
                UIButton* emojiButton = [UIButton buttonWithType:UIButtonTypeCustom];
                [emojiButton addTarget:self action:@selector(emojiButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
                [emojiButton setFrame:CGRectMake(row*kEmojiWidth + (row+1)*xSpacing , col*kEmojiHeight + (col+1)*ySpacing / 2, kEmojiWidth, kEmojiHeight)];
                [emojiButton setTitle:emojiArray[col*kEmojiRows+row + currentPageIndex*kEmojiCols*kEmojiRows] forState:UIControlStateNormal];
                [emojiButton setBackgroundImage:[CommAlgorithm createImageWithUIColor:[UIColor grayColor]] forState:UIControlStateHighlighted];
                [self addSubview:emojiButton];
            }
        }
        
    }
    
    return self;
}

-(void)emojiButtonPressed:(UIButton*)sender {
    [self.delegate selectionEmoji:sender.titleLabel.text];
    return ;
}

@end
