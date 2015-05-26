//
//  SQLOperationManager.m
//  WantBuyCar
//
//  Created by 王落凡 on 15/5/26.
//  Copyright (c) 2015年 王落凡. All rights reserved.
//

#import <sqlite3.h>
#import "ConstantDef.h"
#import "SQLOperationManager.h"

static SQLOperationManager* instance = nil;
@interface SQLOperationManager () {
    sqlite3* dataBase;
}
-(instancetype)init;

@end

@implementation SQLOperationManager

-(instancetype)init {
    self = [super init];
    return self;
}

+(instancetype)sharedInstance {
    @synchronized(self) {
        if(instance==nil) {
            instance = [[SQLOperationManager alloc] init];
        }
    }
    
    return instance;
}

-(id)copy {
    return instance;
}

-(void)openDatabase {
    NSAssert(sqlite3_initialize() == SQLITE_OK, @"初始化数据库失败");
    NSString* dataBasePath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    NSString* dataBaseName = [dataBasePath stringByAppendingPathComponent:kUserDatabaseName];
    NSAssert(sqlite3_open([dataBaseName UTF8String], &dataBase), @"打开数据库失败");
    return ;
}

-(void)dealloc {
    NSAssert(sqlite3_close(dataBase) == SQLITE_OK, @"关闭数据库失败");
    NSAssert(sqlite3_shutdown() == SQLITE_OK, @"销毁数据库失败");
    return ;
}

@end
