//
//  CLAlertView.m
//  要买车
//
//  Created by 王落凡 on 15/5/3.
//  Copyright (c) 2015年 王落凡. All rights reserved.
//

#import "CLAlertView.h"
#import "CommAlgorithm.h"
#import "ConstantDef.h"

@interface CLAlertView ()<UITextFieldDelegate> {
    CGPoint controlViewCenter;
}

@end

@implementation CLAlertView

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:kScreenBounds];

    if(self) {
        [self setWindowLevel:UIWindowLevelAlert];
        [self setBackgroundColor:[UIColor colorWithWhite:0 alpha:0.5f]];
        if(self.controlView==nil) {
            self.controlView = [[UIView alloc] initWithFrame:frame];
            [self setWindowLevel:UIWindowLevelAlert];
            [self.controlView.layer setCornerRadius:5.0f];
            [self.controlView.layer masksToBounds];
            [self.controlView setBackgroundColor:[UIColor colorWithRed:0.945 green:0.949 blue:0.957 alpha:1.0]];
            [self.controlView setCenter:CGPointMake(kScreenWidth/2, kScreenHeight/2)];
            controlViewCenter = [self.controlView center];
    }
    [self addSubview:self.controlView];
    //键盘通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardShowNotification:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardHideNotification:) name:UIKeyboardWillHideNotification object:nil];
    }
    return self;
}

-(instancetype)initWithTitle:(NSString *)title frame:(CGRect)frame message:(NSString *)message delegate:(id<CLAlertViewDelegate>)delegate cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSString *)otherButtonTitles, ...NS_REQUIRES_NIL_TERMINATION {

    [self setWindowLevel:UIWindowLevelAlert];
    self = [super initWithFrame:kScreenBounds];

    if(self) {
        [self setBackgroundColor:[UIColor colorWithWhite:0 alpha:0.5f]];

        if(self.controlView==nil){
            if(CGRectEqualToRect(frame, CGRectZero))
                self.controlView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 275, 250)];
            else
                self.controlView=[[UIView alloc] initWithFrame:frame];
        }
        [self setWindowLevel:UIWindowLevelAlert];
        [self.controlView.layer setCornerRadius:5.0f];
        [self.controlView.layer masksToBounds];
        [self.controlView setBackgroundColor:[UIColor colorWithRed:0.945 green:0.949 blue:0.957 alpha:1.0]];
        [self.controlView setCenter:CGPointMake(kScreenWidth/2, kScreenHeight/2)];
        controlViewCenter = [self.controlView center];

        //标题
        UILabel* titleLabel=[[UILabel alloc] initWithFrame:CGRectMake(10, 10, 100, 20)];
        [titleLabel setText:title];
        [titleLabel setTextColor:[UIColor colorWithRed:0.976 green:0.459 blue:0.035 alpha:1.0]];
        [self.controlView addSubview:titleLabel];

        //第一条分隔线
        UIImageView* seperatorLogin=[[UIImageView alloc] initWithFrame:CGRectMake(0, 40, self.controlView.bounds.size.width, 0.5f)];
        [seperatorLogin setBackgroundColor:[UIColor orangeColor]];
        //        [seperatorLogin setImage:[CommAlgorithm createImageWithRed:0.984 Green:0.455 Blue:0.035f Alpha:1.0f]];
        [self.controlView addSubview:seperatorLogin];

        //消息部分内容视图
    self.messageView = [[UIView alloc] initWithFrame:CGRectMake(0, 50, self.controlView.bounds.size.width, self.controlView.bounds.size.height-110.0f)];
        [self.controlView addSubview:self.messageView];
            //消息
        if(message)
        {
            UILabel* messageLabel=[[UILabel alloc] initWithFrame:self.messageView.bounds];
            [messageLabel setTextAlignment:NSTextAlignmentCenter];
            [messageLabel setText:message];
            [messageLabel setNumberOfLines:0];
            [messageLabel setTextColor:[UIColor blackColor]];
            [messageLabel setFont:[UIFont systemFontOfSize:14.0f]];
            [self.messageView addSubview:messageLabel];
        }

        //按钮
        va_list varList;
        NSString* arg;

        NSMutableArray* argsArray=[[NSMutableArray alloc] init];
        [argsArray addObject:cancelButtonTitle];
        if(otherButtonTitles) {
            [argsArray addObject:otherButtonTitles];
            va_start(varList, otherButtonTitles);
    while((arg       = va_arg(varList, NSString*))) {
                [argsArray addObject:arg];
            }
            va_end(varList);
        }

    for (int i       = 0;i!=argsArray.count;++i) {
            UIButton* button=[UIButton buttonWithType:UIButtonTypeCustom];
            [button setFrame:CGRectMake(i*self.controlView.bounds.size.width/argsArray.count, self.controlView.bounds.size.height-49.5f, self.controlView.bounds.size.width/argsArray.count-0.5f, 49.5f)];
            [button setTitle:argsArray[i] forState:UIControlStateNormal];
            [button setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
            [button setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
            [button setTag:i];
            [button addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
            [self.controlView addSubview:button];
        }

        //添加分隔线
        UIView* seperator=[[UIView alloc] initWithFrame:CGRectMake(0, self.controlView.bounds.size.height-50.0f, self.controlView.bounds.size.width, 0.5f)];
        [seperator setBackgroundColor:[UIColor orangeColor]];
        [self.controlView addSubview:seperator];
    for(int i        = 1;i!=argsArray.count;++i) {
            UIView* view=[[UIView alloc] initWithFrame:CGRectMake(i*self.controlView.bounds.size.width/argsArray.count-0.5f, self.controlView.bounds.size.height-49.5f, 0.5f, 49.5f)];
        [view setBackgroundColor:[UIColor orangeColor]];
        [self.controlView addSubview:view];
    }

    [self addSubview:self.controlView];
    [self setAlertDelegate:delegate];

    //键盘通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardShowNotification:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardHideNotification:)name:UIKeyboardWillHideNotification object:nil];
    }

    return self;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self alertResignFirstResponder];
    return ;
}

-(void)buttonPressed:(UIButton*)sender {
    if(sender.tag==0)
    {
        [self dismiss];
        return ;
    }

    [self.AlertDelegate alertView:self buttonPressedIndex:sender.tag];
    return ;
}

//自定义AlertView的全部内容
-(void)customAllAlertViewControlls {
    for(UIView* subview in self.controlView.subviews)
        [subview removeFromSuperview];
    return ;
}

//自定义AlertView的消息部分内容
-(void)customAlertViewContents {
    for (UIView* subView in self.messageView.subviews) {
        [subView removeFromSuperview];
    }
    return ;
}

-(void)keyboardShowNotification:(NSNotification*)notification {
    CGSize keyboardSize = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
    [self.controlView setCenter:CGPointMake(controlViewCenter.x, controlViewCenter.y - keyboardSize.height / 2)];
    return ;
}

-(void)keyboardHideNotification:(NSNotification*)notification {
    [self.controlView setCenter:CGPointMake(kScreenWidth/2, kScreenHeight/2)];
    return ;
}

-(void)dealloc {
    [[NSNotificationCenter defaultCenter]removeObserver:self];
    return ;
}

-(void)show {
    [self makeKeyAndVisible];
    [self.controlView setFrame:CGRectMake(self.controlView.frame.origin.x, -self.controlView.frame.size.height, self.controlView.frame.size.width, self.controlView.frame.size.height)];
    [UIView animateWithDuration:kAnimateInterval animations:^{
        [self.controlView setCenter:CGPointMake(kScreenWidth/2, kScreenHeight/2)];
    }];
    return ;
}

-(void)dismiss {
    [self alertResignFirstResponder];
    [UIView animateWithDuration:kAnimateInterval animations:^{
        [self.controlView setFrame:CGRectMake(self.controlView.frame.origin.x, kScreenHeight, self.controlView.frame.size.width, self.controlView.frame.size.height)];
    } completion:^(BOOL finished) {
        [self dismissWindow];
    }];
    return ;
}

-(void)alertResignFirstResponder {
    for(UIView* view in self.messageView.subviews)
        [view resignFirstResponder];

    for (UIView* view in self.controlView.subviews)
         [view resignFirstResponder];
    return ;
}

-(void)addAttributedMessage:(NSAttributedString *)attributedString {
    for(UIView* subview in self.messageView.subviews)
        [subview removeFromSuperview];
    UILabel* messageLabel=[[UILabel alloc] initWithFrame:self.messageView.bounds];
    [messageLabel setAttributedText:attributedString];
    [messageLabel setTextAlignment:NSTextAlignmentCenter];
    [self.messageView addSubview:messageLabel];
    return ;
}

-(void)dismissWindow{
    [self resignKeyWindow];
    [self setHidden:YES];
    return ;
}

#pragma mark - 输入框回车
-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

@end
