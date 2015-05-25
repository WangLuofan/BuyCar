//
//  ThirdPartyLogin.m
//  WantBuyCar
//
//  Created by 王落凡 on 15/5/12.
//  Copyright (c) 2015年 王落凡. All rights reserved.
//
#import "ThirdPartyLogin.h"
#import "ConstantDef.h"
#import "sdkCall.h"
#import "WeiboSDK.h"
#import "AppDelegate.h"

@interface ThirdPartyLogin ()

@end

@implementation ThirdPartyLogin

+(void)loginWithPlatform:(Login_Platform)loginPlatform WXViewController:(UIViewController *)wxViewController{
    switch (loginPlatform) {
            //新浪微博登陆
        case LoginPlatform_Sina:
        {
            WBAuthorizeRequest *request = [WBAuthorizeRequest request];
            request.redirectURI = kSinaRedirectURI;
            request.scope = @"all";
            [WeiboSDK sendRequest:request];
        }
            break;
            
            //QQ登陆
        case LoginPlatform_QQ: {
            
            NSArray* permissions = [NSArray arrayWithObjects:
                                    kOPEN_PERMISSION_GET_USER_INFO,
                                    kOPEN_PERMISSION_GET_SIMPLE_USER_INFO,
                                    kOPEN_PERMISSION_GET_INFO,
                                    kOPEN_PERMISSION_GET_OTHER_INFO,
                                    nil];
            
            [[[sdkCall getinstance] oauth] authorize:permissions inSafari:NO];
        }
            break;
            
            //微信登陆
        case LoginPlatform_WX: {
            AppDelegate* appDelegate = [[UIApplication sharedApplication] delegate];
            [appDelegate WXLoginWithViewController:wxViewController];
        }
            
        default:
            break;
    }
    return ;
}

+(void)logoutWithPlatform:(Login_Platform)loginPlatform {
    switch (loginPlatform) {
        case LoginPlatform_Sina:
        {
            NSString* accessToken = [[NSUserDefaults standardUserDefaults] stringForKey:@"accessToken"];
            [WeiboSDK logOutWithToken:accessToken delegate:nil withTag:@""];
        }
            break;
            
        case LoginPlatform_QQ:
        {
            [[[sdkCall getinstance] oauth] logout:nil];
        }
            break;
            
        case LoginPlatform_WX:
            break;
            
        default:
            break;
    }
}

@end
