//
//  sdkCall.m
//  sdkDemo
//
//  Created by xiaolongzhang on 13-3-29.
//  Copyright (c) 2013年 xiaolongzhang. All rights reserved.
//

#import "sdkCall.h"
#import "ConstantDef.h"
#import <TencentOpenAPI/TencentMessageObject.h>

static sdkCall *g_instance = nil;

@interface sdkCall()

@end

@implementation sdkCall

+ (sdkCall *)getinstance
{
    @synchronized(self)
    {
        if (nil == g_instance)
        {
            //g_instance = [[sdkCall alloc] init];
            g_instance = [[super allocWithZone:nil] init];
        }
    }

    return g_instance;
}

+ (id)allocWithZone:(NSZone *)zone
{
    return [self getinstance];
}

+ (void)showInvalidTokenOrOpenIDMessage
{
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"api调用失败" message:@"可能授权已过期，请重新获取" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alert show];
}

- (id)copyWithZone:(NSZone *)zone
{
    return self;
}

+ (void)resetSDK
{
    g_instance = nil;
}

- (id)init
{
//    if (self = [super init])
//    {
    NSString *appid = kTecentAppID;
        _oauth = [[TencentOAuth alloc] initWithAppId:appid
                                                andDelegate:self];
    //}
    return self;
}

- (void)tencentDidLogin
{
    if (NO == [[[sdkCall getinstance] oauth] getUserInfo])
    {
        [sdkCall showInvalidTokenOrOpenIDMessage];
    };
    return ;
}

-(void)getUserInfoResponse:(APIResponse *)response {
    [[NSNotificationCenter defaultCenter] postNotificationName:kUserInfoRequestCompletionNotification object:nil userInfo:@{
                    @"userName":response.jsonResponse[@"nickname"],
                    @"uSid":[_oauth openId],
                    @"iconURL":response.jsonResponse[@"figureurl_qq_2"]
                }];
    return ;
}

- (void)tencentDidNotLogin:(BOOL)cancelled
{
    return ;
}

- (void)tencentDidNotNetWork
{
    return ;
}

- (NSArray *)getAuthorizedPermissions:(NSArray *)permissions withExtraParams:(NSDictionary *)extraParams
{
    return nil;
}

- (void)tencentDidLogout
{

}

- (BOOL)tencentNeedPerformIncrAuth:(TencentOAuth *)tencentOAuth withPermissions:(NSArray *)permissions
{
    return YES;
}


- (BOOL)tencentNeedPerformReAuth:(TencentOAuth *)tencentOAuth
{
    return YES;
}

- (void)tencentDidUpdate:(TencentOAuth *)tencentOAuth
{
}


- (void)tencentFailedUpdate:(UpdateFailType)reason
{
}

@end
