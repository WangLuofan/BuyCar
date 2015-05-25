//
//  RegistItemView.m
//  要买车
//
//  Created by 王落凡 on 15/4/27.
//  Copyright (c) 2015年 王落凡. All rights reserved.
//

#import "RegistItemView.h"
#import "CommAlgorithm.h"

#define TEXT_RATIO 0.3

@interface RegistItemView ()<UITextFieldDelegate> {
    UILabel* textLabel;
    UITextField* contentTextField;
}

@end

@implementation RegistItemView

-(void)setLabelText:(NSString *)text TextFieldPlaceHolder:(NSString *)placeHolder isSecurity:(BOOL)isSecurity isNumpad:(BOOL)isNumpad{
    //标签
    if(textLabel==nil)
        textLabel=[[UILabel alloc] initWithFrame:CGRectMake(5, 0, self.bounds.size.width*TEXT_RATIO, self.bounds.size.height)];
    [textLabel setFont:[UIFont systemFontOfSize:14.0f]];
    [textLabel setText:text];
    [textLabel setTextColor:[UIColor grayColor]];
    
    //输入框
    if(contentTextField==nil)
        contentTextField=[[UITextField alloc] initWithFrame:CGRectMake(100, 0, self.bounds.size.width-100, self.bounds.size.height)];
    [contentTextField setFont:[UIFont systemFontOfSize:12.0f]];
    [contentTextField setDelegate:self];
    [contentTextField setPlaceholder:placeHolder];
    [contentTextField setSecureTextEntry:isSecurity];
    if(isSecurity)
       [contentTextField setKeyboardType:UIKeyboardTypeAlphabet];
    if(isNumpad)
        [contentTextField setKeyboardType:UIKeyboardTypeNumberPad];
    
    UIImageView* seperator=[[UIImageView alloc] initWithImage:[CommAlgorithm createImageWithRed:0.675 Green:0.678 Blue:0.682 Alpha:1.0]];
    [seperator setFrame:CGRectMake(0, self.bounds.size.height, self.bounds.size.width, 0.5f)];
    
    
    [self addSubview:textLabel];
    [self addSubview:contentTextField];
    [self addSubview:seperator];
    
    return ;
}

-(NSString *)contentText {
    return contentTextField.text;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

-(BOOL)resignFirstResponder {
    [super resignFirstResponder];
    [contentTextField resignFirstResponder];
    return YES;
}

@end
