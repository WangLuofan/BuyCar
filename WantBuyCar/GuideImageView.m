//
//  GuideImageView.m
//  要买车
//
//  Created by 王落凡 on 15/4/24.
//  Copyright (c) 2015年 王落凡. All rights reserved.
//

#import "GuideImageView.h"
#import "ConstantDef.h"

@interface GuideImageView () {
}

@end

@implementation GuideImageView

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if(self) {
        [self setUserInteractionEnabled:YES];
        
        UIButton* loginButton=[UIButton buttonWithType:UIButtonTypeCustom];
        [loginButton setImage:[UIImage imageNamed:@"login"] forState:UIControlStateNormal];
        [loginButton setImage:[UIImage imageNamed:@"login_b"] forState:UIControlStateHighlighted];
        [loginButton setFrame:CGRectMake(kLeftMargin, kScreenHeight-kBottomMargin, kButtonWidth, kButtonHeight)];
        [loginButton addTarget:self action:@selector(loginButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        
        UIButton* registerButton=[UIButton buttonWithType:UIButtonTypeCustom];
        [registerButton setImage:[UIImage imageNamed:@"register"] forState:UIControlStateNormal];
        [registerButton setImage:[UIImage imageNamed:@"register_b"] forState:UIControlStateHighlighted];
        [registerButton setFrame:CGRectMake(kScreenWidth-kLeftMargin-kButtonWidth, kScreenHeight-kBottomMargin, kButtonWidth, kButtonHeight)];
        [registerButton addTarget:self action:@selector(registerButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:loginButton];
        [self addSubview:registerButton];
        
    }
    
    return self;
}

-(void)loginButtonPressed:(UIButton*)sender {
    [self.delegate buttonPressedByIndex:0];
    return ;
}

-(void)registerButtonPressed:(UIButton*)sender {
    [self.delegate buttonPressedByIndex:1];
    return ;
}

@end
