//
//  NetworkingOperation.h
//  WantBuyCar
//
//  Created by 王落凡 on 15/5/14.
//  Copyright (c) 2015年 王落凡. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NetworkingOperation : NSObject

+(void)sendJSONRequestWithUrl:(NSString*)urlString notificationName:(NSString*)notificationName;
+(void)sendGETRequestWithUrl:(NSString*)urlString params:(NSDictionary*)params notificationName:(NSString*)notificationName;
+(void)sendPOSTRequestWithUrl:(NSString*)urlString params:(NSDictionary*)params notificationName:(NSString*)notificationName;

@end
