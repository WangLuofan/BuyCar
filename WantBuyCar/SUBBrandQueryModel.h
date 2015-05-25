//
//  SUBBrandQueryModel.h
//  WantBuyCar
//
//  Created by 王落凡 on 15/5/18.
//  Copyright (c) 2015年 王落凡. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SUBBrandQueryModel : NSObject

@property (nonatomic,copy) NSString* _id;
@property (nonatomic,copy) NSString* _firstLetter;
@property (nonatomic,copy) NSString* _brand;
@property (nonatomic,copy) NSString* _subBrand;
@property (nonatomic,copy) NSString* _series;
@property (nonatomic,copy) NSString* _time;
@property (nonatomic,copy) NSString* _modelName;
@property (nonatomic,copy) NSString* _country;
@property (nonatomic,copy) NSString* _technology;
@property (nonatomic,copy) NSString* _vehicleClass;
@property (nonatomic,copy) NSString* _vehicleType;
@property (nonatomic,copy) NSString* _engineCapacity;
@property (nonatomic,copy) NSString* _transmission;
@property (nonatomic,copy) NSString* _drive;
@property (nonatomic,copy) NSString* _porwer;
@property (nonatomic,copy) NSString* _price;
@property (nonatomic,copy) NSString* _tag;
@property (nonatomic,copy) NSString* _delist;
@property (nonatomic,copy) NSString* _image;

-(instancetype)initWithDictionary:(NSDictionary*)dict;

@end
