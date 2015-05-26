//
//  RegistModel.h
//  WantBuyCar
//
//  Created by 王落凡 on 15/5/13.
//  Copyright (c) 2015年 王落凡. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

typedef enum {
    ErrorTypeNotFound,                              //无错误
    ErrorTypeEmptyHeaderImageError,                 //未设置头像错误
    ErrorTypeEmptyStringError,                      //空字符错误
    ErrorTypeMailFormatError,                       //邮箱格式错误
    ErrorTypePhoneFormatError,                      //电话格式错误
    ErrorTypePasswordFormatError,                   //密码格式错误
    ErrorTypePasswordDifferentError,                //两次输入密码不一致错误
    ErrorTypeFileWriteError                         //文件写入错误
}RegistErrorType;

@interface RegistModel : NSObject

@property(nonatomic,copy) UIImage* headerImage;
@property(nonatomic,copy) NSString* userName;
@property(nonatomic,copy) NSString* phoneNumber;
@property(nonatomic,copy) NSString* password;
@property(nonatomic,assign) NSInteger registType;
@property(nonatomic,assign) NSInteger genderInfo;

-(RegistErrorType)setUserInfoWithDictionary:(NSDictionary*)userInfo;
-(BOOL)isTextValidWithRegex:(NSString*)regex text:(NSString*)text;

@end
