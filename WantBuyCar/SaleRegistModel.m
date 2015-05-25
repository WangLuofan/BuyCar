//
//  SaleRegistModel.m
//  WantBuyCar
//
//  Created by 王落凡 on 15/5/13.
//  Copyright (c) 2015年 王落凡. All rights reserved.
//

#import "SaleRegistModel.h"

@implementation SaleRegistModel

-(id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    
    if(self) {
        self.companyString = (NSString*)[aDecoder decodeObjectForKey:@"companyString"];
        self.brandString = (NSString*)[aDecoder decodeObjectForKey:@"brandString"];
    }
    
    return self;
}

-(void)encodeWithCoder:(NSCoder *)aCoder {
    [super encodeWithCoder:aCoder];
    [aCoder encodeObject:self.companyString forKey:@"companyString"];
    [aCoder encodeObject:self.brandString forKey:@"brandString"];
    return ;
}

-(RegistErrorType)setUserInfoWithDictionary:(NSDictionary *)userInfo {
    RegistErrorType errorType = [super setUserInfoWithDictionary:userInfo];
    
    if(ErrorTypeNotFound == errorType)
        return errorType;
    
    self.companyString = (NSString*)userInfo[@"companyString"];
    self.brandString = (NSString*)userInfo[@"brandString"];
    
    if(self.companyString.length == 0 || self.brandString.length == 0)
        return ErrorTypeEmptyStringError;
    
    return ErrorTypeNotFound;
}

@end
