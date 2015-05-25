//
//  ConstantDef.h
//  要买车
//
//  Created by 王落凡 on 15/4/30.
//  Copyright (c) 2015年 王落凡. All rights reserved.
//

#ifndef __Constant__Def_h
#define __Constant__Def_h

#define kStatusBarHeight 20
#define kChatDateLabelHeight 35
#define kChatTabHeight 40
#define kTabViewHeight 44
#define kMenuItemHeight 50
#define kMenuItemWidth 200
#define kFilterHeight 40
#define kButtonWidth 94
#define kButtonHeight 36
#define kLeftMargin 40
#define kBottomMargin 70

//聊天
#define kChatLeftMargin 20
#define kChatRightMargin 10
#define kChatTopMargin 10

//动画持续时间
#define kAnimateInterval 0.5f
#define kMovingInterval 0.2f

//键盘高度
#define kEmojiKeyboardHeight 150 
#define kKeyBoardSpacing 10

//Emoji
#define kEmojiWidth 24
#define kEmojiHeight 24

//Emoji Rows & Cols
#define kEmojiRows 10
#define kEmojiCols 5

#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
#define kScreenBounds [UIScreen mainScreen].bounds

#define bSystemVersionBigThanIOS6 ([[[UIDevice currentDevice].systemVersion substringToIndex:1] intValue] > 6)
#define kBaseHeight (bSystemVersionBigThanIOS6?64:0)

//友盟
#define kuMengAppKey @"55515b9c67e58eec52003022"

//环信
#define kEaseMobAppKey @"wangluofan#wantbuycar"

//新浪微博
#define kSinaAppKey @"2511898838"
#define kSinaAppSecret @"e7a8341709d2a2945a8d749f4d5d7d56"
#define kSinaRedirectURI @"https://api.weibo.com/oauth2/default.html"
#define kSinaUserInfoRequestURI @"https://api.weibo.com/2/users/show.json"

//QQ
#define kTecentAppID @"1104653842"
#define kTecentAppKey @"ocwsGlZeWkPwXYZm"

//微信
#define kWXAppID @"wx988a5dc0d17e85a7"
#define kWXAppSecret @"512e0d81f45b1e8aa69401e06a3471c1"

//接口地址
#define kApiUrl @"http://120.25.123.209:9090/api/vehicle"
#define kImageUrl(FILENAME,W,H) [NSString stringWithFormat:@"%@/getimage?file=%@&w=%d&h=%d",(kApiUrl),(FILENAME),(W),(H)]

//自定义通知
#define kRequestCompletionNotification @"RequestCompletionNotification"
#define kUserInfoRequestCompletionNotification @"UserInfoRequestCompletionNotification"

#endif
