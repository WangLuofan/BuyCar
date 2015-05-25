//
//  BrandQueryModel.h
//  WantBuyCar
//
//  Created by 王落凡 on 15/5/18.
//  Copyright (c) 2015年 王落凡. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BrandQueryModel : NSObject

@property (nonatomic,copy) NSString* _id;
@property (nonatomic,copy) NSString* _firstLetter;
@property (nonatomic,copy) NSString* _pid;
@property (nonatomic,copy) NSString* _name;
@property (nonatomic,copy) NSString* _country;
@property (nonatomic,copy) NSString* _logo;

-(instancetype)initWithDictionary:(NSDictionary*)dict;

@end
