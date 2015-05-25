//
//  RegistBaseViewController.m
//  WantBuyCar
//
//  Created by 王落凡 on 15/5/14.
//  Copyright (c) 2015年 王落凡. All rights reserved.
//

#import "ConstantDef.h"
#import "RegistButton.h"
#import "RegistItemView.h"
#import "RegistModel.h"
#import "CommAlgorithm.h"
#import "CLAlertView.h"
#import "BuyerRegistModel.h"
#import "SaleRegistModel.h"
#import "RegistBaseViewController.h"

@class BuyCarViewController;
@class SalerRegistViewController;

@interface RegistBaseViewController () {
    CGPoint viewCenterPoint;
}

@end

@implementation RegistBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    viewCenterPoint=[self.view center];
    self.registItemArray = [[NSMutableArray alloc] init];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(leftBarButtonItemPressed:)];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardShowNotification:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardHideNotification:) name:UIKeyboardWillHideNotification object:nil];
}

-(void)leftBarButtonItemPressed:(UIBarButtonItem*)sender {
    [self dismissViewControllerAnimated:YES completion:^{
    }];
    return ;
}

-(void) addControlsWithArray:(NSArray *)contentArray yOrigin:(CGFloat)yOrigin{
    //上传照片按钮
    RegistButton* headerButton=[[RegistButton alloc] initWithFrame:CGRectMake(0, 0, 100, 80)];
    [headerButton setCenter:CGPointMake(kScreenWidth/2, 110)];
    [headerButton setImage:[UIImage imageNamed:@"head"] forState:UIControlStateNormal];
    [headerButton setRegistButtonType:RegistButtonType_Upload];
    NSAttributedString* attributedString=[[NSAttributedString alloc] initWithString:@"请上传您的寸照"
        attributes:@{
                     NSForegroundColorAttributeName:[UIColor colorWithRed:0.984 green:0.463 blue:0.259 alpha:1.0f],
                     NSFontAttributeName:[UIFont systemFontOfSize:12.0f],
                     NSUnderlineStyleAttributeName:[NSNumber numberWithInteger:NSUnderlineStyleSingle],
                     NSUnderlineColorAttributeName:[UIColor colorWithRed:0.984 green:0.463 blue:0.259 alpha:1.0f]
                     }];
    [headerButton setAttributedTitle:attributedString forState:UIControlStateNormal];
    [self.registItemArray addObject:headerButton];
    
    [self.view addSubview:headerButton];

    
    int yPoint = headerButton.frame.origin.y+headerButton.bounds.size.height;
    yPoint = (yOrigin == 0 ? yPoint : yOrigin);
    for(int i=0;i!=contentArray.count;++i) {
        RegistItemView* item=[[RegistItemView alloc] initWithFrame:CGRectMake(20, yPoint+50*i, self.view.bounds.size.width-40, 50)];
        [item setLabelText:contentArray[i][0] TextFieldPlaceHolder:contentArray[i][1] isSecurity:[contentArray[i][2] isEqualToString:@"1"] isNumpad:[contentArray[i][3] isEqualToString:@"1"]];
        [self.registItemArray addObject:item];
        
        [self.view addSubview:item];
    }
    
    //完成注册
    UIButton* completeRegistBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [completeRegistBtn setFrame:CGRectMake(20, kScreenHeight - 60, self.view.bounds.size.width-40, 50)];
    [completeRegistBtn setTitle:@"完成注册" forState:UIControlStateNormal];
    [completeRegistBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [completeRegistBtn setBackgroundImage:[CommAlgorithm createImageWithRed:0.984 Green:0.455 Blue:0.035 Alpha:1.0f] forState:UIControlStateNormal];
    [completeRegistBtn addTarget:self action:@selector(completeRegistBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:completeRegistBtn];
    
    return ;
}

-(RegistErrorType)registUserWithDictionary:(NSDictionary *)userInfoDict userType:(RegistType)userType{
    RegistModel* registModel = nil;
    if(userType == RegistType_Buyer)
        registModel = [[BuyerRegistModel alloc] init];
    else
        registModel = [[SaleRegistModel alloc] init];
    
    RegistErrorType errorType = [registModel setUserInfoWithDictionary:userInfoDict];
    
    //保存用户信息
    NSString* docDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    if(![NSKeyedArchiver archiveRootObject:registModel toFile:[NSString stringWithFormat:@"%@/userInfo.plist",docDir]])
        return ErrorTypeFileWriteError;
    
    return errorType;
}

-(NSString*)formatErrorInfo:(RegistErrorType)errorType {
    NSString* message = nil;
    switch (errorType) {
        case ErrorTypeEmptyStringError:
            message = @"请将信息填写完整";
            break;
        case ErrorTypePhoneFormatError:
            message = @"电话号码格式错误\n正确的格式为：11位有效电话号码";
            break;
        case ErrorTypeMailFormatError:
            message = @"邮件格式错误\n正确的格式为：[用户名]@[邮件服务商].com";
            break;
        case ErrorTypePasswordFormatError:
            message = @"密码格式错误\n正确的格式为：6位数字，字母或下划线";
            break;
        case ErrorTypePasswordDifferentError:
            message = @"两次输入的密码不一致，请重新输入";
            break;
        case ErrorTypeEmptyHeaderImageError:
            message = @"请设置头像";
            break;
        case ErrorTypeFileWriteError:
            message = @"存储用户信息失败，注册不成功";
        default:
            break;
    }
    
    return message;
}

-(void)completeRegistBtnClicked:(UIButton*)sender {

    return ;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
-(void)keyBoardShowNotification:(NSNotification*)notification {
    CGRect keyboardFrame=[notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGRect firstResponderRect=CGRectZero;
    for (UIView* view in self.view.subviews) {
        BOOL bFindFirstResponder = NO;
        if([view isKindOfClass:[RegistItemView class]]) {
            for (UIView* subView in view.subviews) {
                if([subView isFirstResponder]&&[subView isKindOfClass:[UITextField class]]) {
                    bFindFirstResponder=YES;
                    break;
                }
            }
        }
        if(bFindFirstResponder) {
            firstResponderRect = view.frame;
            break;
        }
    }
    
    if(firstResponderRect.origin.y+firstResponderRect.size.height>keyboardFrame.origin.y) {
        [self.view setCenter:CGPointMake(self.view.center.x, self.view.center.y+keyboardFrame.origin.y-firstResponderRect.origin.y-firstResponderRect.size.height)];
    }
    
    return ;
}

-(void)keyBoardHideNotification:(NSNotification*)notification {
    CGRect keyboardFrame=[notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGRect firstResponderRect=CGRectZero;
    for (UIView* view in self.view.subviews) {
        BOOL bFindFirstResponder = NO;
        if([view isKindOfClass:[RegistItemView class]]) {
            for (UIView* subView in view.subviews) {
                if([subView isFirstResponder]&&[subView isKindOfClass:[UITextField class]]) {
                    bFindFirstResponder=YES;
                    break;
                }
            }
        }
        if(bFindFirstResponder) {
            firstResponderRect = view.frame;
            break;
        }
    }
    
    if(firstResponderRect.origin.y<keyboardFrame.origin.y) {
        [self.view setCenter:viewCenterPoint];
    }
    return ;
}

-(void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    return ;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    for (UIView* view in self.view.subviews) {
        [view resignFirstResponder];
    }
    return ;
}

@end
