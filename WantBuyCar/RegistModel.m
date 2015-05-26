//
//  RegistModel.m
//  WantBuyCar
//
//  Created by 王落凡 on 15/5/13.
//  Copyright (c) 2015年 王落凡. All rights reserved.
//

#import "RegistModel.h"

@implementation RegistModel

-(RegistErrorType)setUserInfoWithDictionary:(NSDictionary *)userInfo {
    self.headerImage = (UIImage*)userInfo[@"headerImage"];
    self.userName = (NSString*)userInfo[@"userName"];
    self.phoneNumber = (NSString*)userInfo[@"phoneNumber"];
    self.genderInfo = 1;
    
    if([(NSString*)userInfo[@"firstPassword"] isEqualToString:(NSString*)userInfo[@"secondPassword"]])
        self.password = (NSString*)userInfo[@"firstPassword"];
    else
        return ErrorTypePasswordDifferentError;
    
    NSLog(@"%@",self.headerImage);
    if(self.headerImage == nil)
        return ErrorTypeEmptyHeaderImageError;
    
    //空串错误
    if(self.userName.length==0||self.phoneNumber.length==0||self.password.length ==0)
        return ErrorTypeEmptyStringError;
    
    //电话号码格式错误
    NSString* phoneFormat = @"\\d{11}";
    if(![self isTextValidWithRegex:phoneFormat text:self.phoneNumber])
        return ErrorTypePhoneFormatError;
    
    //密码格式错误
    NSString* passwordFormat =@"[0-9_a-zA-Z]{6}";
    if(![self isTextValidWithRegex:passwordFormat text:self.password])
        return ErrorTypePasswordFormatError;
    
    return ErrorTypeNotFound;
}

-(BOOL)isTextValidWithRegex:(NSString*)regex text:(NSString*)text {
    NSPredicate* predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    return [predicate evaluateWithObject:text];
}

@end
