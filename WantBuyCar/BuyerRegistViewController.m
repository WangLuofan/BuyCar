//
//  BuyerRegistViewController.m
//  要买车
//
//  Created by 王落凡 on 15/4/27.
//  Copyright (c) 2015年 王落凡. All rights reserved.
//

#import "BuyerRegistModel.h"
#import "BuyerRegistViewController.h"
#import "RegistButton.h"
#import "RegistItemView.h"
#import "CLSegmentedControl.h"
#import "CommAlgorithm.h"
#import "CLAlertView.h"
#import "ConstantDef.h"

@interface BuyerRegistViewController () {
}

@end

@implementation BuyerRegistViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setTitle:@"买家注册"];
    
    //0 字段名
    //1 提示信息
    //2 是否密码信息
    //3 是否为全数字键盘
    //4 键名
    NSArray* contentArray=@[
                            @[@"姓名",@"姓名或者昵称",@"0",@"0",@"name"],
                            @[@"登陆邮箱",@"登陆用户名",@"0",@"0",@"email"],
                            @[@"联系方式",@"仅对好友公开",@"0",@"1",@"phone"],
                            @[@"登陆密码",@"六位数字、字母或者下划线",@"1",@"0",@"password"],
                            @[@"确认密码",@"再次输入登陆密码",@"1",@"0",@"confirmPassword"]
                            ];
    
    [self addControlsWithArray:contentArray];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)completeRegistBtnClicked:(UIButton *)sender {
    NSDictionary* dict = @{@"headerImage":((RegistButton*)self.registItemDict[@"headerButton"]).headerImage,
                                           @"userName":[((RegistItemView*)self.registItemDict[@"name"]) contentText],
                                           @"mailString":[((RegistItemView*)self.registItemDict[@"email"]) contentText],
                                           @"phoneNumber":[((RegistItemView*)self.registItemDict[@"phone"]) contentText],
                                           @"firstPassword":[((RegistItemView*)self.registItemDict[@"password"]) contentText],
                                           @"secondPassword":[((RegistItemView*)self.registItemDict[@"confirmPassword"]) contentText]};
    
    NSString* message = [self formatErrorInfo:[self registUserWithDictionary:dict userType:RegistType_Buyer]];
    
    if(message.length!=0) {
        self.alertView = [[CLAlertView alloc] initWithTitle:@"错误" frame:CGRectMake(0, 0, 250, 200) message:message delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [self.alertView show];
        return ;
    }

    return ;
}

@end
