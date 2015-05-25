//
//  AppDelegate.m
//  要买车
//
//  Created by 王落凡 on 15/4/24.
//  Copyright (c) 2015年 王落凡. All rights reserved.
//

#import "AppDelegate.h"
#import "WeiboSDK.h"
#import "GuideViewController.h"
#import "MainViewController.h"
#import "ConstantDef.h"
#import "EMSDKFull.h"
#import "WeiboSDK.h"
#import "NetworkingOperation.h"
#import "WXApi.h"
#import "NetworkingOperation.h"

#import <TencentOpenAPI/TencentOAuth.h>

@interface AppDelegate ()<WeiboSDKDelegate,WXApiDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    //环信
    [[EaseMob sharedInstance] registerSDKWithAppKey:kEaseMobAppKey apnsCertName:nil];
    [[EaseMob sharedInstance] application:application didFinishLaunchingWithOptions:launchOptions];
    
    //新浪微博
    [WeiboSDK enableDebugMode:YES];
    [WeiboSDK registerApp:kSinaAppKey];
    
    //微信
    [WXApi registerApp:kWXAppID withDescription:@"WantBuyCar"];
    
    self.window=[[UIWindow alloc] initWithFrame:kScreenBounds];
    [self.window setBackgroundColor:[UIColor whiteColor]];
    
    NSDictionary* infoDict=[[NSBundle mainBundle] infoDictionary];
    NSString* newVersion=infoDict[@"CFBundleVersion"];
    NSString* oldVersion=[[NSUserDefaults standardUserDefaults] valueForKey:@"CurrentBundleVersion"];
    
    if([oldVersion isEqualToString:newVersion]) {
        [self.window setRootViewController:[[MainViewController alloc] init]];
    } else {
        [self.window setRootViewController:[[GuideViewController alloc] init]];
    }
    
    [[NSUserDefaults standardUserDefaults] setValue:newVersion forKey:@"CurrentBundleVersion"];
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    [[EaseMob sharedInstance] applicationWillResignActive:application];
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    [[EaseMob sharedInstance] applicationDidEnterBackground:application];
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    [[EaseMob sharedInstance] applicationWillEnterForeground:application];
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    [[EaseMob sharedInstance] applicationDidBecomeActive:application];
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    [[EaseMob sharedInstance] applicationWillTerminate:application];
}

-(BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
//    return [ShareSDK handleOpenURL:url sourceApplication:sourceApplication annotation:annotation wxDelegate:nil];
    return [WeiboSDK handleOpenURL:url delegate:self] || [TencentOAuth HandleOpenURL:url] || [WXApi handleOpenURL:url delegate:self];
}

-(BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    return [WeiboSDK handleOpenURL:url delegate:self] || [TencentOAuth HandleOpenURL:url] || [WXApi handleOpenURL:url delegate:self];
}

#pragma mark - 新浪微博登陆相关

-(void)didReceiveWeiboRequest:(WBBaseRequest *)request {
    return ;
}

-(void)didReceiveWeiboResponse:(WBBaseResponse *)response {
    if(response.statusCode == WeiboSDKResponseStatusCodeSuccess) {
        if([response isKindOfClass:[WBAuthorizeResponse class]]) {
            [[NSUserDefaults standardUserDefaults] setValue:[((WBAuthorizeResponse*)response) accessToken] forKey:@"access_token"];
            NSDictionary* params = @{@"source":kSinaAppKey,@"uid":[((WBAuthorizeResponse*)response) userID],@"access_token":[((WBAuthorizeResponse*)response) accessToken]};
            [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(requestCompletionRequest:) name:kRequestCompletionNotification object:nil];
            [NetworkingOperation sendGETRequestWithUrl:kSinaUserInfoRequestURI params:params];
        }
    }
    return ;
}

#pragma mark - 登陆完成后获取用户简略信息

-(void)requestCompletionRequest:(NSNotification*)notification {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [[NSNotificationCenter defaultCenter] postNotificationName:kUserInfoRequestCompletionNotification object:nil userInfo:@{
                        @"userName":notification.userInfo[@"name"],
                        @"uSid":notification.userInfo[@"idstr"],
                        @"iconURL":notification.userInfo[@"profile_image_url"]
                  }];
    
    return ;
}

#pragma mark - 微信登陆相关

-(void)WXLoginWithViewController:(UIViewController *)viewController {
    SendAuthReq* req = [[SendAuthReq alloc] init];
    
    req.scope = @"snsapi_base";
    req.state = @"0744";
    
    if(viewController!=nil)
        [WXApi sendAuthReq:req viewController:viewController delegate:self];
    return ;
}

-(void)onResp:(BaseResp *)resps {
    
    if([resps isKindOfClass:[SendAuthResp class]] && resps.errCode == 0)
    {
        SendAuthResp *temp = (SendAuthResp*)resps;
        [self getAccessTokenWithCode:temp.code];
    }
    
    return ;
}

//获取微信accessToken和openID
-(void)getAccessTokenWithCode:(NSString*)code
{
    //https://api.weixin.qq.com/sns/oauth2/access_token?appid=APPID&secret=SECRET&code=CODE&grant_type=authorization_code
    NSString *url =@"https://api.weixin.qq.com/sns/oauth2/access_token";
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(requestCompletionNotification:) name:kRequestCompletionNotification object:nil];
    [NetworkingOperation sendGETRequestWithUrl:url params:@{
                                                           @"appid":kWXAppID,
                                                           @"secret":kWXAppSecret,
                                                           @"code":code,
                                                           @"grant_type":@"authorization_code"
                                                            }];
    return ;
}

//获取微信用户信息
-(void)getUserInfoWithAccessToken:(NSString*)accessToken openID:(NSString*)openID
{
    // https://api.weixin.qq.com/sns/userinfo?access_token=ACCESS_TOKEN&openid=OPENID
    NSString *url =@"https://api.weixin.qq.com/sns/userinfo";
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(queryWXUserInfoCompletionNotification:) name:kRequestCompletionNotification object:nil];
    [NetworkingOperation sendGETRequestWithUrl:url params:@{
                                                            @"access_token":accessToken,
                                                            @"openid":openID
                                                            }];
    return ;
}

-(void)requestCompletionNotification:(NSNotification*)notification {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [self getUserInfoWithAccessToken:notification.userInfo[@"access_token"] openID:notification.userInfo[@"openid"]];
    return ;
}

-(void)queryWXUserInfoCompletionNotification:(NSNotification*)notification {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    NSDictionary* dict = @{
                           @"userName":notification.userInfo[@"nickname"],
                           @"uSid":notification.userInfo[@"openid"],
                           @"iconURL":notification.userInfo[@"headimgurl"]
                           };
    [[NSNotificationCenter defaultCenter] postNotificationName:kUserInfoRequestCompletionNotification object:nil userInfo:dict];
    return ;
}

-(void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    return ;
}

@end