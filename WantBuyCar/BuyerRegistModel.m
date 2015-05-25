//
//  BuyerRegistModel.m
//  WantBuyCar
//
//  Created by 王落凡 on 15/5/13.
//  Copyright (c) 2015年 王落凡. All rights reserved.
//

#import "BuyerRegistModel.h"

@implementation BuyerRegistModel

-(id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    
    if(self) {
        self.mailString = (NSString*)[aDecoder decodeObjectForKey:@"mailString"];
        self.sexualString = (NSString*)[aDecoder decodeObjectForKey:@"sexualString"];
    }
    
    return self;
}

-(void)encodeWithCoder:(NSCoder *)aCoder {
    [super encodeWithCoder:aCoder];
    [aCoder encodeObject:self.mailString forKey:@"mailString"];
    [aCoder encodeObject:self.sexualString forKey:@"sexualString"];
    return ;
}

-(RegistErrorType)setUserInfoWithDictionary:(NSDictionary *)userInfo {
    RegistErrorType errorType= [super setUserInfoWithDictionary:userInfo];
    if(errorType!=ErrorTypeNotFound)
        return errorType;
    
    self.mailString = (NSString*)userInfo[@"mailString"];
    self.sexualString = (NSString*)userInfo[@"sexualString"];
    
    if(self.mailString.length==0)
        return ErrorTypeEmptyStringError;
    
    NSString* mailFormat = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    if(![self isTextValidWithRegex:mailFormat text:self.mailString])
        return ErrorTypeMailFormatError;
    
    return ErrorTypeNotFound;
}

@end
