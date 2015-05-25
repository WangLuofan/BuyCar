//
//  RegistModel.m
//  WantBuyCar
//
//  Created by 王落凡 on 15/5/13.
//  Copyright (c) 2015年 王落凡. All rights reserved.
//

#import "RegistModel.h"

@implementation RegistModel

- (void)encodeWithCoder:(NSCoder *)coder
{
    [coder encodeObject:self.headerImageURL forKey:@"headerImageURL"];
    [coder encodeObject:self.userName forKey:@"userName"];
    [coder encodeObject:self.phoneNumber forKey:@"phoneNumber"];
    [coder encodeObject:self.password forKey:@"password"];
    
    return ;
}

-(id)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    
    if(self) {
        self.headerImageURL = (NSString*)[aDecoder decodeObjectForKey:@"headerImageURL"];
        self.userName = (NSString*)[aDecoder decodeObjectForKey:@"userName"];
        self.phoneNumber = (NSString*)[aDecoder decodeObjectForKey:@"phoneNumber"];
        self.password = (NSString*)[aDecoder decodeObjectForKey:@"password"];
    }
    
    return self;
}

-(RegistErrorType)setUserInfoWithDictionary:(NSDictionary *)userInfo {
    self.headerImageURL = (NSString*)userInfo[@"headerImageURL"];
    self.userName = (NSString*)userInfo[@"userName"];
    self.phoneNumber = (NSString*)userInfo[@"phoneNumber"];
    
    if([(NSString*)userInfo[@"firstPassword"] isEqualToString:(NSString*)userInfo[@"secondPassword"]])
        self.password = (NSString*)userInfo[@"firstPassword"];
    else
        return ErrorTypePasswordDifferentError;
    
    NSLog(@"%@",self.headerImageURL);
    if(self.headerImageURL.length == 0)
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
