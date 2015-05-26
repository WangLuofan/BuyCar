//
//  SQLOperationManager.h
//  WantBuyCar
//
//  Created by 王落凡 on 15/5/26.
//  Copyright (c) 2015年 王落凡. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SQLOperationManager : NSObject

+(instancetype)sharedInstance;
-(void)openDatabase;

@end
