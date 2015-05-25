//
//  EmojiKeyboardView.m
//  要买车
//
//  Created by 王落凡 on 15/5/8.
//  Copyright (c) 2015年 王落凡. All rights reserved.
//

#import "Emoji.h"
#import "ConstantDef.h"
#import "EmojiPageView.h"
#import "EmojiKeyboardView.h"

@interface EmojiKeyboardView ()<UIScrollViewDelegate> {
    UIPageControl* pageControl;
}

@end

@implementation EmojiKeyboardView

-(instancetype)initWithFrame:(CGRect)frame keyBoardView:(id<EmojiPageViewDelegate>)keyBoardView{
    self = [super initWithFrame:frame];
    
    if(self) {
        [self setBackgroundColor:[UIColor colorWithRed:0.902 green:0.906 blue:0.918 alpha:1.0f]];
        NSMutableArray* emojiArray = [NSMutableArray arrayWithArray:[Emoji allEmoji]];
        [emojiArray addObject:@"0"];
        
        UIScrollView* scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, kEmojiKeyboardHeight - kKeyBoardSpacing)];
        int pages = (int)((float)[emojiArray count])/(kEmojiRows*kEmojiCols) + 1;
        
        for(int i =0;i!=pages; ++i) {
            EmojiPageView* pageView = [[EmojiPageView alloc] initWithFrame:CGRectMake(i*scrollView.frame.size.width, 0, scrollView.frame.size.width, scrollView.frame.size.height) EmojiArray:emojiArray CurrentPageIndex:i];
            [pageView setDelegate:keyBoardView];
            [scrollView addSubview:pageView];
            [self addSubview:scrollView];
        }
        [scrollView setPagingEnabled:YES];
        [scrollView setDelegate:self];
        [scrollView setContentSize:CGSizeMake(pages*scrollView.frame.size.width, 0)];
        
        //页面指示
        pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, self.frame.size.height - kKeyBoardSpacing, self.frame.size.width, kKeyBoardSpacing)];
        [pageControl setNumberOfPages:pages];
        [self addSubview:pageControl];
    }
    
    return self;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [pageControl setCurrentPage:(int)((scrollView.contentOffset.x/ scrollView.frame.size.width) + 0.5)];
    return ;
}

@end
