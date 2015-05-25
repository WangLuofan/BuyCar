//
//  LoginAlertView.m
//  要买车
//
//  Created by 王落凡 on 15/4/27.
//  Copyright (c) 2015年 王落凡. All rights reserved.
//

#import "LoginAlertView.h"
#import "LoginButton.h"
#import "ConstantDef.h"
#import "CommAlgorithm.h"

@interface LoginAlertView () <UITextFieldDelegate> {
    UITextField* passwordText;
    UITextField* userNameText;
}

@end

@implementation LoginAlertView

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if(self) {
        [self.controlView setFrame:CGRectMake(0, 0, 277, 272)];
        [self.controlView setCenter:CGPointMake(kScreenWidth/2, kScreenHeight/2)];
        [self customAllAlertViewControlls];
    }
    
    return self;
}

-(void)customAllAlertViewControlls{
    [super customAllAlertViewControlls];
    //标题
    UILabel* titleLabel=[[UILabel alloc] initWithFrame:CGRectMake(10, 10, 100, 20)];
    [titleLabel setText:@"登陆"];
    [titleLabel setTextColor:[UIColor colorWithRed:0.976 green:0.459 blue:0.035 alpha:1.0]];
    [self.controlView addSubview:titleLabel];
    
    //第一条分隔线
    UIImageView* seperatorLogin=[[UIImageView alloc] initWithFrame:CGRectMake(0, 40, self.controlView.bounds.size.width, 0.5f)];
    [seperatorLogin setBackgroundColor:[UIColor orangeColor]];
    [self.controlView addSubview:seperatorLogin];
    
    //用户名
    UILabel* userNameLabel=[[UILabel alloc] initWithFrame:CGRectMake(15, 55, 100, 20)];
    [userNameLabel setText:@"用户名"];
    [userNameLabel setTextColor:[UIColor colorWithRed:0.494 green:0.502 blue:0.506 alpha:1.0]];
    [self.controlView addSubview:userNameLabel];
    
    //用户名输入框
    userNameText=[[UITextField alloc] initWithFrame:CGRectMake(120, 55, 100, 20)];
    [userNameText setPlaceholder:@"登陆用户名"];
    [userNameText setDelegate:self];
    [userNameText setAdjustsFontSizeToFitWidth:YES];
    [self.controlView addSubview:userNameText];
    
    //第二条分隔线
    UIImageView* seperatorUserName=[[UIImageView alloc] initWithFrame:CGRectMake(10, 90, self.controlView.bounds.size.width-20, 0.5f)];
    [seperatorUserName setImage:[CommAlgorithm createImageWithRed:0.494 Green:0.502 Blue:0.506 Alpha:1.0]];
    [self.controlView addSubview:seperatorUserName];
    
    //密码
    UILabel* passwordLabel=[[UILabel alloc] initWithFrame:CGRectMake(15, 105, 100, 20)];
    [passwordLabel setText:@"密码"];
    [passwordLabel setTextColor:[UIColor colorWithRed:0.494 green:0.502 blue:0.506 alpha:1.0]];
    [self.controlView addSubview:passwordLabel];
    
    //密码输入框
    passwordText=[[UITextField alloc] initWithFrame:CGRectMake(120, 105, 100, 20)];
    [passwordText setPlaceholder:@"登陆密码"];
    [passwordText setSecureTextEntry:YES];
    [passwordText setDelegate:self];
    [passwordText setAdjustsFontSizeToFitWidth:YES];
    [self.controlView addSubview:passwordText];
    
    //问号按钮
    UIButton* helpButton=[[UIButton alloc] initWithFrame:CGRectMake(240, 105, 19, 19)];
    [helpButton setImage:[UIImage imageNamed:@"question"] forState:UIControlStateNormal];
    [self.controlView addSubview:helpButton];
    
    //第三条分隔线
    UIImageView* seperatorPassword=[[UIImageView alloc] initWithFrame:CGRectMake(10, 141, self.controlView.bounds.size.width-20, 0.5f)];
    [seperatorPassword setImage:[CommAlgorithm createImageWithRed:0.494 Green:0.502 Blue:0.506 Alpha:1.0]];
    [self.controlView addSubview:seperatorPassword];
    
    //取消按钮
    UIButton* cancelButton=[[UIButton alloc]initWithFrame:CGRectMake(0, 160, self.controlView.bounds.size.width/2, 50)];
    [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
    [cancelButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [cancelButton setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
    [cancelButton.layer setBorderColor:[[UIColor colorWithRed:0.851 green:0.855 blue:0.859 alpha:1.9] CGColor]];
    [cancelButton.layer setBorderWidth:0.5f];
    [cancelButton addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [cancelButton setTag:0];
    [self.controlView addSubview:cancelButton];
    
    //确认按钮
    UIButton* okButton=[[UIButton alloc]initWithFrame:CGRectMake(self.controlView.bounds.size.width/2, 160, self.controlView.bounds.size.width/2, 50)];
    [okButton setTitle:@"确定" forState:UIControlStateNormal];
    [okButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [okButton setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
    [okButton.layer setBorderColor:[[UIColor colorWithRed:0.851 green:0.855 blue:0.859 alpha:1.9] CGColor]];
    [okButton setTag:1];
    [okButton addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [okButton.layer setBorderWidth:0.5f];
    [self.controlView addSubview:okButton];
    
    //第四条分隔线
    UIImageView* seperatorText1=[[UIImageView alloc] initWithFrame:CGRectMake(30, self.controlView.bounds.size.height-40, 50, 0.5f)];
    [seperatorText1 setImage:[CommAlgorithm createImageWithRed:0.827 Green:0.831 Blue:0.835 Alpha:1.0]];
    [self.controlView addSubview:seperatorText1];
    
    //第三方合作帐号
    UILabel* thirdAccountLabel=[[UILabel alloc] initWithFrame:CGRectMake(95, self.controlView.bounds.size.height-60, 100, 40)];
    [thirdAccountLabel setFont:[UIFont systemFontOfSize:12.0f]];
    [thirdAccountLabel setText:@"第三方合作帐号"];
    [thirdAccountLabel setTextColor:[UIColor grayColor]];
    [self.controlView addSubview:thirdAccountLabel];
    
    //第五条分隔线
    UIImageView* seperatorText2=[[UIImageView alloc] initWithFrame:CGRectMake(self.controlView.bounds.size.width-80, self.controlView.bounds.size.height-40, 50, 0.5f)];
    [seperatorText2 setImage:[CommAlgorithm createImageWithRed:0.827 Green:0.831 Blue:0.835 Alpha:1.0]];
    [self.controlView addSubview:seperatorText2];
    
    
    //QQ登陆按钮
    LoginButton* qqLoginButton=[[LoginButton alloc] initWithFrame:CGRectMake(15, self.controlView.bounds.size.height-30, 70, 30)];
    [qqLoginButton setTitle:@"QQ登陆" Image:@"qq"];
    [qqLoginButton setTag:2];
    [qqLoginButton addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.controlView addSubview:qqLoginButton];
    
    //微信登陆按钮
    LoginButton* wxLoginButton=[[LoginButton alloc] initWithFrame:CGRectMake(100, self.controlView.bounds.size.height-30, 70, 30)];
    [wxLoginButton setTitle:@"微信登陆" Image:@"wx"];
    [wxLoginButton setTag:3];
    [wxLoginButton addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.controlView addSubview:wxLoginButton];
    
    //微博登陆按钮
    LoginButton* wbLoginButton=[[LoginButton alloc] initWithFrame:CGRectMake(185, self.controlView.bounds.size.height-30, 70, 30)];
    [wbLoginButton setTitle:@"微博登陆" Image:@"wb"];
    [wbLoginButton setTag:4];
    [wbLoginButton addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.controlView addSubview:wbLoginButton];
    
    return ;
}

-(NSDictionary *)getUserInfoDict {
   return @{@"userName":userNameText.text,@"password":passwordText.text};
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

-(void)buttonPressed:(UIButton*)sender {
    [self dismiss];
    [self.AlertDelegate alertView:self buttonPressedIndex:sender.tag];
    return ;
}

@end
