//
//  ChatTabView.m
//  要买车
//
//  Created by 王落凡 on 15/5/5.
//  Copyright (c) 2015年 王落凡. All rights reserved.
//

#import "EmojiPageView.h"
#import "ConstantDef.h"
#import "EmojiKeyboardView.h"
#import "ChatTabView.h"

@interface ChatTabView ()<UITextViewDelegate,EmojiPageViewDelegate> {
    UIButton* addButton;
    UIButton* faceButton;
    UITextView* messageTextView;
    UIImageView* backgroundImageView;
    CGRect chatTabViewRect;
}

@end

@implementation ChatTabView

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if(self) {
        [self setBackgroundColor:[UIColor colorWithRed:0.902 green:0.906 blue:0.918 alpha:1.0f]];
        
        //添加按钮
        addButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [addButton setFrame:CGRectMake(self.bounds.size.width - 30, 0, 20, 20)];
        [addButton setCenter:CGPointMake(addButton.center.x, self.frame.size.height/2)];
        [addButton setImage:[UIImage imageNamed:@"add"] forState:UIControlStateNormal];
        [addButton addTarget:self action:@selector(addButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:addButton];
        
        //表情按钮
        faceButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [faceButton setFrame:CGRectMake(self.bounds.size.width - 60, 0, 20, 20)];
        [faceButton setCenter:CGPointMake(faceButton.center.x, self.frame.size.height/2)];
        [faceButton setImage:[UIImage imageNamed:@"bq"] forState:UIControlStateNormal];
        [faceButton addTarget:self action:@selector(faceButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:faceButton];
        
        //聊天输入框
//        messageTextView = [[UITextView alloc] initWithFrame:CGRectMake(10, 0, self.bounds.size.width - 80, self.bounds.size.height - 10)];
//        [messageTextView.layer setCornerRadius:10.0f];
//        [messageTextView setDelegate:self];
//        [messageTextView setCenter:CGPointMake(messageTextView.center.x, self.frame.size.height/2)];
//        UIImageView* bgImageView=[[UIImageView alloc] initWithFrame:messageTextView.bounds];
//        [bgImageView setImage:[[UIImage imageNamed:@"message"] resizableImageWithCapInsets:UIEdgeInsetsMake(10, 10, 11, 11)]];
//        [messageTextView addSubview:bgImageView];
//        [messageTextView sendSubviewToBack:bgImageView];
//        [self addSubview:messageTextView];
        
        backgroundImageView=[[UIImageView alloc] initWithFrame:CGRectMake(10, 0, self.bounds.size.width - 80, self.bounds.size.height - 10)];
        [backgroundImageView setUserInteractionEnabled:YES];
        [backgroundImageView setCenter:CGPointMake(backgroundImageView.center.x, self.frame.size.height/2)];
        [backgroundImageView setImage:[[UIImage imageNamed:@"message"] resizableImageWithCapInsets:UIEdgeInsetsMake(10, 10, 11, 11)]];
        messageTextView = [[UITextView alloc] initWithFrame:backgroundImageView.bounds];
        [messageTextView.layer setCornerRadius:10.0f];
        [messageTextView.layer setMasksToBounds:YES];
        [messageTextView setDelegate:self];
        [messageTextView setBackgroundColor:[UIColor clearColor]];
        [messageTextView setReturnKeyType:UIReturnKeySend];
        [backgroundImageView addSubview:messageTextView];
        [backgroundImageView bringSubviewToFront:messageTextView];
        [self addSubview:backgroundImageView];
        
        chatTabViewRect = self.frame;
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardShowNotification:) name:UIKeyboardWillShowNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardHideNotification:) name:UIKeyboardWillHideNotification object:nil];
    }
    
    return self;
}

-(BOOL)resignFirstResponder {
    [super resignFirstResponder];
    
    for (UIView* view in backgroundImageView.subviews) {
        [view resignFirstResponder];
    }
    
    return YES;
}

-(void)faceButtonClicked:(UIButton*)sender {
    EmojiKeyboardView* keyboard = [[EmojiKeyboardView alloc] initWithFrame:CGRectMake(0, kScreenHeight - kEmojiKeyboardHeight, kScreenWidth, kEmojiKeyboardHeight) keyBoardView:self];

    UIView* oldInputView = [messageTextView inputView];
    
    [messageTextView resignFirstResponder];
    [messageTextView setInputView:keyboard];
    [messageTextView becomeFirstResponder];
    [messageTextView setInputView:oldInputView];

    return ;
}

-(void)keyboardShowNotification:(NSNotification*)notification {
    CGSize keyBoardSize=[notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
    
    [self setFrame:CGRectMake(self.frame.origin.x, chatTabViewRect.origin.y-keyBoardSize.height, self.frame.size.width, self.frame.size.height)];

    return ;
}

-(void)keyboardHideNotification:(NSNotification*)notification {
    [self setFrame:CGRectMake(self.frame.origin.x, chatTabViewRect.origin.y, self.frame.size.width, self.frame.size.height)];
    return ;
}

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    if([text isEqualToString:@"\n"]) {
        //添加表项
        [self.delegate tabView:self message:textView.text];
        //清除文本
        [textView setText:@""];
        [textView resignFirstResponder];
    }
    
    return YES;
}

-(void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    return ;
}

-(void)addButtonPressed:(UIButton*)sender {
    [self.delegate chooseImageButtonPressed];
    return ;
}

-(void)selectionEmoji:(NSString *)emojiString {
    NSMutableString* text = [NSMutableString stringWithString:messageTextView.text];
    [text appendString:emojiString];
    [messageTextView setText:[text copy]];
    return ;
}

@end
