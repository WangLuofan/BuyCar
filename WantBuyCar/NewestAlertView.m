//
//  NewestAlertView.m
//  要买车
//
//  Created by 王落凡 on 15/5/5.
//  Copyright (c) 2015年 王落凡. All rights reserved.
//

#import "NewestAlertView.h"

@interface NewestAlertView ()<UITextViewDelegate> {
    UILabel* placeHolerLabel;
}

@end

@implementation NewestAlertView

-(instancetype)initWithTitle:(NSString *)title frame:(CGRect)frame message:(NSString *)message delegate:(id<CLAlertViewDelegate>)delegate cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSString *)otherButtonTitles, ... {
    self = [super initWithTitle:title frame:frame message:message delegate:delegate cancelButtonTitle:cancelButtonTitle otherButtonTitles:otherButtonTitles, nil];
    
    if(self) {
        [self customAlertViewContents];
    }
    
    return self;
}

-(void)customAlertViewContents {
    [super customAlertViewContents];
    
    self.textView = [[UITextView alloc] initWithFrame:self.messageView.bounds];
    [self.textView setDelegate:self];
    [self.textView setFont:[UIFont systemFontOfSize:14.0f]];
    
    placeHolerLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 10, 0, 0)];
    [placeHolerLabel setNumberOfLines:0];
    [placeHolerLabel setFont:[UIFont systemFontOfSize:10.0f]];
    [placeHolerLabel setTextColor:[UIColor lightGrayColor]];
    [placeHolerLabel setText:@"输入您的购车需求，价格区间，用途，喜好......"];
    [placeHolerLabel sizeToFit];
    [self.textView addSubview:placeHolerLabel];
    
    [self.messageView addSubview:self.textView];
    
    return ;
}

-(void)textViewDidChange:(UITextView *)textView {
    if(textView.text.length==0)
       [placeHolerLabel setHidden:NO];
    else
        [placeHolerLabel setHidden:YES];
    
    return ;
}

@end
