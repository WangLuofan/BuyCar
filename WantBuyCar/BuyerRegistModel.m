//
//  BuyerRegistModel.m
//  WantBuyCar
//
//  Created by 王落凡 on 15/5/13.
//  Copyright (c) 2015年 王落凡. All rights reserved.
//

#import "BuyerRegistModel.h"

@implementation BuyerRegistModel

-(RegistErrorType)setUserInfoWithDictionary:(NSDictionary *)userInfo {
    RegistErrorType errorType= [super setUserInfoWithDictionary:userInfo];
    if(errorType!=ErrorTypeNotFound)
        return errorType;
    
    self.mailString = (NSString*)userInfo[@"mailString"];
    
    if(self.mailString.length==0)
        return ErrorTypeEmptyStringError;
    
    NSString* mailFormat = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    if(![self isTextValidWithRegex:mailFormat text:self.mailString])
        return ErrorTypeMailFormatError;
    
    return ErrorTypeNotFound;
}

@end
