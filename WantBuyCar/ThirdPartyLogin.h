//
//  ThirdPartyLogin.h
//  WantBuyCar
//
//  Created by 王落凡 on 15/5/12.
//  Copyright (c) 2015年 王落凡. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    LoginPlatform_Sina,LoginPlatform_QQ,LoginPlatform_WX,LoginPlatform_NONE
}Login_Platform;

@class UIViewController;
@interface ThirdPartyLogin : NSObject

+(void)loginWithPlatform:(Login_Platform)loginPlatform WXViewController:(UIViewController*)wxViewController;
+(void)logoutWithPlatform:(Login_Platform)loginPlatform;

@end
