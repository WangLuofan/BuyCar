//
//  SalerRegistViewController.m
//  要买车
//
//  Created by 王落凡 on 15/4/27.
//  Copyright (c) 2015年 王落凡. All rights reserved.
//

#import "SalerRegistViewController.h"
#import "RegistButton.h"
#import "RegistModel.h"
#import "SaleRegistModel.h"
#import "ConstantDef.h"
#import "CommAlgorithm.h"
#import "RegistItemView.h"
#import "CLAlertView.h"

@interface SalerRegistViewController (){
}

@end

@implementation SalerRegistViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setTitle:@"卖家注册"];
    
    //0 字段名
    //1 提示信息
    //2 是否密码信息
    //3 是否为全数字键盘
    //4 键名
    NSArray* contentArray=@[
                            @[@"姓名",@"姓名或者昵称",@"0",@"0",@"name"],
                            @[@"单位",@"登陆用户名",@"0",@"0",@"company"],
                            @[@"联系方式",@"仅对好友公开",@"0",@"1",@"phone"],
                            @[@"经营品牌",@"选择后，则APP推送到最新询价",@"0",@"0",@"brand"],
                            @[@"登陆密码",@"六位数字、字母或者下划线",@"1",@"0",@"password"],
                            @[@"确认密码",@"再次输入登陆密码",@"1",@"0",@"confirmPassword"]
                         ];
    
    [self addControlsWithArray:contentArray];
}

//-(void) addAllControls {
//    RegistButton* headerButton=[[RegistButton alloc] initWithFrame:CGRectMake(0, 0, 100, 80)];
//    [headerButton setCenter:CGPointMake(kScreenWidth/2, 110)];
//    [headerButton setImage:[UIImage imageNamed:@"head"] forState:UIControlStateNormal];
//    [headerButton setRegistButtonType:RegistButtonType_Upload];
//    NSAttributedString* attributedString=[[NSAttributedString alloc] initWithString:@"请上传您的寸照"
//        attributes:@{
//                     NSForegroundColorAttributeName:[UIColor colorWithRed:0.984 green:0.463 blue:0.259 alpha:1.0f],
//                     NSFontAttributeName:[UIFont systemFontOfSize:12.0f],
//                     NSUnderlineStyleAttributeName:[NSNumber numberWithInteger:NSUnderlineStyleSingle],
//                     NSUnderlineColorAttributeName:[UIColor colorWithRed:0.984 green:0.463 blue:0.259 alpha:1.0f]
//                     }];
//    [headerButton setAttributedTitle:attributedString forState:UIControlStateNormal];
//    [registItemArray addObject:headerButton];
//    [self.view addSubview:headerButton];
//    
//    NSArray* contentArray=@[
//                            @[@"姓名",@"姓名或者昵称",@"0",@"0"],
//                            @[@"单位",@"登陆用户名",@"0",@"0"],
//                            @[@"联系方式",@"仅对好友公开",@"0",@"1"],
//                            @[@"经营品牌",@"选择后，则APP推送到最新询价",@"0",@"0"],
//                            @[@"登陆密码",@"六位数字、字母或者下划线",@"1",@"0"],
//                            @[@"确认密码",@"再次输入登陆密码",@"1",@"0"]
//                         ];
//    
//    for(int i=0;i!=contentArray.count;++i) {
//        RegistItemView* item=[[RegistItemView alloc] initWithFrame:CGRectMake(20, headerButton.frame.origin.y+headerButton.bounds.size.height+50*i, self.view.bounds.size.width-40, 50)];
//        [item setLabelText:contentArray[i][0] TextFieldPlaceHolder:contentArray[i][1] isSecurity:[contentArray[i][2] isEqualToString:@"1"] isNumpad:[contentArray[i][3] isEqualToString:@"1"]];
//        [registItemArray addObject:item];
//        [self.view addSubview:item];
//    }
//    
//    //完成注册
//    UIButton* completeRegistBtn=[UIButton buttonWithType:UIButtonTypeCustom];
//    [completeRegistBtn setFrame:CGRectMake(20, kScreenHeight - 60, self.view.bounds.size.width-40, 50)];
//    [completeRegistBtn setTitle:@"完成注册" forState:UIControlStateNormal];
//    [completeRegistBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    [completeRegistBtn setBackgroundImage:[CommAlgorithm createImageWithRed:0.984 Green:0.455 Blue:0.035 Alpha:1.0f] forState:UIControlStateNormal];
//    [completeRegistBtn addTarget:self action:@selector(completeRegistBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:completeRegistBtn];
//    
//    return ;
//}

-(void)completeRegistBtnClicked:(UIButton*)sender {
    NSDictionary* dict = @{@"headerImage":((RegistButton*)self.registItemDict[@"headerButton"]).headerImage,
                           @"userName":[((RegistItemView*)self.registItemDict[@"name"]) contentText],
                           @"companyString":[((RegistItemView*)self.registItemDict[@"company"]) contentText],
                           @"phoneNumber":[((RegistItemView*)self.registItemDict[@"phone"]) contentText],
                           @"brandString:":[((RegistItemView*)self.registItemDict[@"brand"])contentText],
                           @"firstPassword":[((RegistItemView*)self.registItemDict[@"password"]) contentText],
                           @"secondPassword":[((RegistItemView*)self.registItemDict[@"confirmPassword"]) contentText]};
    NSString* message = [self formatErrorInfo:[self registUserWithDictionary:dict userType:RegistType_Saler]];
    
    if(message.length!=0) {
        self.alertView = [[CLAlertView alloc] initWithTitle:@"错误" frame:CGRectMake(0, 0, 250, 200) message:message delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [self.alertView show];
        return ;
    }
    
    return ;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
