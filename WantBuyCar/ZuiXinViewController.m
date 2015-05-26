//
//  ZuiXinViewController.m
//  要买车
//
//  Created by 王落凡 on 15/4/28.
//  Copyright (c) 2015年 王落凡. All rights reserved.
//

#import "RegistViewController.h"
#import "CLNavigationViewController.h"
#import "NewestViewController.h"
#import "NetworkingOperation.h"
#import "ZuiXinViewController.h"
#import "MenuCoverView.h"
#import "MenuItemView.h"
#import "FilterView.h"
#import "CommAlgorithm.h"
#import "LoginAlertView.h"
#import "ImageTableViewCell.h"
#import "CarInfoTableViewCell.h"
#import "SetUpTableViewController.h"
#import "ConstantDef.h"
#import "BuyerRegistModel.h"
#import "EMSDKFull.h"
#import "CLNewAlertView.h"

@interface ZuiXinViewController ()<MenuCoverViewDelegate,MenuItemViewDelegate,CLAlertViewDelegate> {
    MenuCoverView* menuCoverView;
    MenuItemView* menuItemView;
    CLAlertView* loginResultAlertView;
    LoginAlertView* loginAlertView;
    NSArray* imageSourceArray;
}

@end

@implementation ZuiXinViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setTitle:@"最新询价"];

    imageSourceArray=@[@"image1",@"image1",@"image2"];
    
    //遮罩
    menuCoverView=[[MenuCoverView alloc] initWithFrame:self.view.bounds];
    [menuCoverView setDelegate:self];
    [self.view addSubview:menuCoverView];
    
    //菜单项
    menuItemView=[[MenuItemView alloc] initWithFrame:CGRectMake(0-kMenuItemWidth, 0, kMenuItemWidth, self.view.bounds.size.height)];
    [menuItemView setDelegate:self];
    [self.view addSubview:menuItemView];
    
    UIButton* menuButton=[UIButton buttonWithType:UIButtonTypeCustom];
    [menuButton setImage:[UIImage imageNamed:@"menu"] forState:UIControlStateNormal];
    [menuButton setFrame:CGRectMake(0, 0, 25, 20)];
    [menuButton addTarget:self action:@selector(menuButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    UIView* menuView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 25, 20)];
    [menuView setBackgroundColor:[UIColor clearColor]];
    [menuView addSubview:menuButton];
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc] initWithCustomView:menuView];
    
    return ;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)menuButtonPressed {
    if([menuCoverView isCoverViewShown]) {
        [menuItemView hideMenuItem];
        [menuCoverView setHidden:YES];
        [menuCoverView setIsCoverViewShown:NO];
    }
    else {
        [menuItemView showMenuItem];
        [menuCoverView setHidden:NO];
        [menuCoverView setIsCoverViewShown:YES];
    }
    return ;
}

-(void)menuItemClicked:(NSInteger)menuIndex {
    switch (menuIndex) {
        case 0:
        {
            loginAlertView = [[LoginAlertView alloc] initWithFrame:CGRectZero];
            [loginAlertView setAlertDelegate:self];
            [loginAlertView show];
        }
            break;
        case 1:
        {
            CLNavigationViewController* registViewController = [[CLNavigationViewController alloc] initWithRootViewController:[[RegistViewController alloc] init]];
            [self presentViewController:registViewController animated:YES completion:^{
            }];
        }
            break;
        case 2:
        {
            CLNavigationViewController* setupNavigation=[[CLNavigationViewController alloc] initWithRootViewController:[[SetUpTableViewController alloc] initWithStyle:UITableViewStylePlain]];
            if([menuItemView isLoginSuccessful])
                [self presentViewController:setupNavigation animated:YES completion:^{
                }];
            else {
                loginResultAlertView = [[CLAlertView alloc] initWithTitle:@"错误" frame:CGRectZero message:@"请您先登陆" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
                [loginResultAlertView show];
            }
        }
            break;
            
        case 3:
        {
            if([menuItemView isLoginSuccessful]) {
                loginResultAlertView = [[CLAlertView alloc] initWithTitle:@"错误" frame:CGRectZero message:@"您已经登陆，请勿重复登陆" delegate:nil cancelButtonTitle:@"好的" otherButtonTitles: nil];
                [loginResultAlertView show];
            }
            else
                [self login:LoginPlatform_Sina];
        }

            break;
            
        case 4:
        {
            if([menuItemView isLoginSuccessful]) {
                loginResultAlertView = [[CLAlertView alloc] initWithTitle:@"错误" frame:CGRectZero message:@"您已经登陆，请勿重复登陆" delegate:nil cancelButtonTitle:@"好的" otherButtonTitles: nil];
                [loginResultAlertView show];
            }
            else
                [self login:LoginPlatform_QQ];
        }

            break;
            
        case 5:
        {
            if([menuItemView isLoginSuccessful]) {
                loginResultAlertView = [[CLAlertView alloc] initWithTitle:@"错误" frame:CGRectZero message:@"您已经登陆，请勿重复登陆" delegate:nil cancelButtonTitle:@"好的" otherButtonTitles: nil];
                [loginResultAlertView show];
            }
            else
                [self login:LoginPlatform_WX];
        }
            break;
            
        default:
            break;
    }
}

-(void)coverViewTouched {
    [menuItemView hideMenuItem];
    [menuCoverView setHidden:YES];
    [menuCoverView setIsCoverViewShown:NO];
    return ;
}

-(void)login:(Login_Platform)loginPlatform {
    [ThirdPartyLogin loginWithPlatform:loginPlatform WXViewController:self];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(userInfoRequestCompletionNotification:) name:kUserInfoRequestCompletionNotification object:nil];
    [self setLoginPlatform:loginPlatform];
    
    return ;
}

-(void)logout {
    
    [ThirdPartyLogin logoutWithPlatform:self.loginPlatform];
    [menuItemView clearUserInfo];
    [menuItemView setLoginSuccessful:NO];
    [self setLoginPlatform:LoginPlatform_NONE];
    
    loginResultAlertView = [[CLAlertView alloc] initWithTitle:@"注销" frame:CGRectZero message:@"注销用户操作成功" delegate:nil cancelButtonTitle:@"好的" otherButtonTitles: nil];
    [loginResultAlertView show];
    
    return ;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.row==0) {
        ImageTableViewCell* cell=[tableView dequeueReusableCellWithIdentifier:@"ImageCellIdentifier"];
        if(cell==nil) {
            cell=[[ImageTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ImageCellIdentifier"];
        }
        [cell setImageSource:imageSourceArray];
        return cell;
    }
    
    CarInfoTableViewCell* cell=[tableView dequeueReusableCellWithIdentifier:@"CarCellIdentifier"];
    if(cell==nil) {
        cell=[[CarInfoTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CellIdentifier"];
    }
    [cell.carImageView setImage:[UIImage imageNamed:@"image1"]];
    [cell.buyerInfoLabel setText:@"刘先生想买"];
    [cell.carInfoLabel setText:@"昂科雷（进口）09款 旗舰版"];
    [cell.dateTimeLabel setText:@"09:44"];
    [cell setPriceInfo:@"28.8万" OfferInfo:@"0"];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.row==0)
        return 180;
    return 80;
}

-(void)setLoginInfoWithURL:(NSString *)iconURL userName:(NSString *)userName uSid:(NSString *)uSid{
    [menuItemView setUserInfoWithHeaderURLString:iconURL UserName:userName];
    if(loginResultAlertView==nil)
    {
        NSMutableAttributedString* attributedString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"恭喜%@，登陆成功",userName]];
        [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(2, userName.length)];
        if(uSid==nil)
            [[NSUserDefaults standardUserDefaults] setObject:userName forKey:@"userName"];
        else
             [[NSUserDefaults standardUserDefaults] setObject:uSid forKey:@"userName"];
        [[NSUserDefaults standardUserDefaults] setObject:@"123456" forKey:@"password"];
        loginResultAlertView = [[CLAlertView alloc] initWithTitle:@"结果" frame:CGRectMake(0, 0, 250, 200) message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [loginResultAlertView addAttributedMessage:[attributedString copy]];
    }
    [loginResultAlertView show];
    return ;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NewestViewController* newestController=[[NewestViewController alloc] init];
    [self presentViewController:[[CLNavigationViewController alloc] initWithRootViewController:newestController] animated:YES completion:^{
    }];
    return ;
}

-(void)alertView:(CLAlertView *)alertView buttonPressedIndex:(NSInteger)buttonPressedIndex {
    
    if([alertView isKindOfClass:[LoginAlertView class]]) {
        if(buttonPressedIndex == 1) {
            NSDictionary* userInfo = [((LoginAlertView*)alertView) getUserInfoDict];
            [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(userLoginRequestCompletionNotification:) name:kUserLoginRequestCompletionNotification object:nil];
            [NetworkingOperation sendPOSTRequestWithUrl:[NSString stringWithFormat:@"%@/login",kUserApiUrl] params:userInfo notificationName:kUserLoginRequestCompletionNotification];
        }
    }
    
    return ;
}

-(void)userLoginRequestCompletionNotification:(NSNotification*)notification {
    NSString* message = [notification.userInfo[@"message"] stringValue];
    if([message isEqualToString:@"ok"]) {
        NSString* usertoken = [notification.userInfo[@"result"][@"usertoken"] stringValue];
        [[NSUserDefaults standardUserDefaults] setValue:usertoken forKey:@"usertoken"];
        [menuItemView setIsLoginSuccessful:YES];
    }else{
        loginResultAlertView = [[CLAlertView alloc] initWithTitle:@"登陆失败" frame:CGRectZero message:message delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [loginResultAlertView show];
    }
    return ;
}

-(void)userInfoRequestCompletionNotification:(NSNotification*)notification {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [self setLoginInfoWithURL:notification.userInfo[@"iconURL"] userName:notification.userInfo[@"userName"] uSid:notification.userInfo[@"uSid"]];
    [menuItemView setLoginSuccessful:YES];
    return ;
}

@end
