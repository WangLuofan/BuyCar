//
//  BrandQueryModel.m
//  WantBuyCar
//
//  Created by 王落凡 on 15/5/18.
//  Copyright (c) 2015年 王落凡. All rights reserved.
//

#import "BrandQueryModel.h"

@implementation BrandQueryModel

-(instancetype)initWithDictionary:(NSDictionary *)dict {
    self = [super init];
    
    if(self) {
        self._id = (NSString*)[dict[@"ID"]  copy];
        self._firstLetter = (NSString*)[dict[@"FIRST_LETTER"] copy];
        self._pid = (NSString*)[dict[@"PID"] copy];
        self._name = (NSString*)[dict[@"NAME"] copy];
        self._country = (NSString*)[dict[@"COUNTRY"] copy];
        self._logo = (NSString*)[dict[@"LOGO"] copy];
    }
    
    return self;
}

@end
