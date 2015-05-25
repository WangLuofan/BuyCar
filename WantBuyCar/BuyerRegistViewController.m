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

@interface BuyerRegistViewController ()<CLSegmentedControlDelegate> {
    NSString* sexualString;
}

@end

@implementation BuyerRegistViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setTitle:@"买家注册"];
    
    NSArray* contentArray=@[
                            @[@"姓名",@"姓名或者昵称",@"0",@"0"],
                            @[@"登陆邮箱",@"登陆用户名",@"0",@"0"],
                            @[@"联系方式",@"仅对好友公开",@"0",@"1"],
                            @[@"登陆密码",@"六位数字、字母或者下划线",@"1",@"0"],
                            @[@"确认密码",@"再次输入登陆密码",@"1",@"0"]
                            ];
    
    sexualString = @"男";
    
    CLSegmentedControl* segmentCtrl=[[CLSegmentedControl alloc] initWithFrame:CGRectMake(10, 180, self.view.frame.size.width-20 ,50) style:CLSegmentedControlStyleRect];
    [segmentCtrl addItemByTitle:@"男" Image:@"male"];
    [segmentCtrl addItemByTitle:@"女" Image:@"female"];
    [segmentCtrl setDelegate:self];
    [self.view addSubview:segmentCtrl];
    
    [self addControlsWithArray:contentArray yOrigin:segmentCtrl.frame.origin.y+segmentCtrl.bounds.size.height];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)completeRegistBtnClicked:(UIButton *)sender {
    NSDictionary* dict = @{@"headerImageURL":((RegistButton*)self.registItemArray[0]).imageReferenceURL,
                                           @"userName":[((RegistItemView*)self.registItemArray[1]) contentText],
                                           @"sexualString":sexualString,
                                           @"mailString":[((RegistItemView*)self.registItemArray[2]) contentText],
                                           @"phoneNumber":[((RegistItemView*)self.registItemArray[3]) contentText],
                                           @"firstPassword":[((RegistItemView*)self.registItemArray[4]) contentText],
                           @"secondPassword":[((RegistItemView*)self.registItemArray[5]) contentText]};
    NSString* message = [self formatErrorInfo:[self registUserWithDictionary:dict userType:RegistType_Buyer]];
    
    if(message.length!=0) {
        self.alertView = [[CLAlertView alloc] initWithTitle:@"错误" frame:CGRectMake(0, 0, 250, 200) message:message delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [self.alertView show];
        return ;
    }else {
        self.alertView = [[CLAlertView alloc] initWithTitle:@"成功" frame:CGRectMake(0, 0, 250, 200) message:@"恭喜你，注册成功" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [self.alertView show];
    }

    return ;
}

-(void)segmentedControl:(CLSegmentedControl *)segmentedControl selectedItemIndex:(NSInteger)selectedItemIndex {
    sexualString = (selectedItemIndex==0?@"男":@"女");
    return ;
}

@end
