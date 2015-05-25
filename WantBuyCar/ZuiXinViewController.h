//
//  ZuiXinViewController.h
//  要买车
//
//  Created by 王落凡 on 15/4/28.
//  Copyright (c) 2015年 王落凡. All rights reserved.
//

#import "ThirdPartyLogin.h"
#import "BaseViewController.h"
#import <UIKit/UIKit.h>

@interface ZuiXinViewController : BaseViewController

-(void)setLoginInfoWithURL:(NSString*)iconURL userName:(NSString*)userName uSid:(NSString*)uSid;
-(void)login:(Login_Platform)loginPlatform;

@property(nonatomic,assign) Login_Platform loginPlatform;

@end
