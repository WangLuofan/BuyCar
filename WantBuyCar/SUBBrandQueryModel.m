//
//  SUBBrandQueryModel.m
//  WantBuyCar
//
//  Created by 王落凡 on 15/5/18.
//  Copyright (c) 2015年 王落凡. All rights reserved.
//

#import "SUBBrandQueryModel.h"

@implementation SUBBrandQueryModel

-(instancetype)initWithDictionary:(NSDictionary *)dict {
    self = [super init];
    
    if(self) {
        self._id = (NSString*)[dict[@"ID"] copy];
        self._firstLetter = (NSString*)[dict[@"FIRST_LETTER"] copy];
        self._brand = (NSString*)[dict[@"BRAND"] copy];
        self._subBrand = (NSString*)[dict[@"SUB_BRAND"] copy];
        self._series = (NSString*)[dict[@"SERIES"] copy];
        self._time = (NSString*)[dict[@"TIME"] copy];
        self._modelName = (NSString*)[dict[@"MODEL_NAME"] copy];
        self._country = (NSString*)[dict[@"COUNTRY"] copy];
        self._technology = (NSString*)[dict[@"TECHNOLOGY"] copy];
        self._vehicleClass = (NSString*)[dict[@"VEHICLE_CLASS"] copy];
        self._vehicleType = (NSString*)[dict[@"VEHICLE_TYPE"] copy];
        self._engineCapacity = (NSString*)[dict[@"ENGINE_CAPACITY"] copy];
        self._transmission = (NSString*)[dict[@"TRANSMISSION"] copy];
        self._drive = (NSString*)[dict[@"DRIVE"] copy];
        self._porwer = (NSString*)[dict[@"POWER"] copy];
        self._price = (NSString*)[dict[@"PRICE"] copy];
        self._tag = (NSString*)[dict[@"DELIST"] copy];
        self._image = (NSString*)[dict[@"IMAGE"] copy];
    }
    
    return self;
}

@end
