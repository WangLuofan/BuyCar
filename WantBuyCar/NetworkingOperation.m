//
//  NetworkingOperation.m
//  WantBuyCar
//
//  Created by 王落凡 on 15/5/14.
//  Copyright (c) 2015年 王落凡. All rights reserved.
//

#import "AFNetworking.h"
#import "NetworkingOperation.h"

@implementation NetworkingOperation

#pragma mark - 请求JSON数据
+(void)sendJSONRequestWithUrl:(NSString *)urlString notificationName:(NSString *)notificationName{
    NSURL* url = [NSURL URLWithString:[urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    AFHTTPRequestOperation *op = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    op.responseSerializer = [AFJSONResponseSerializer serializer];
    [op setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        [[NSNotificationCenter defaultCenter] postNotificationName:notificationName object:nil userInfo:(NSDictionary*)responseObject];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        @throw [NSString stringWithFormat:@"Error:%@",error];
    }];
    
    [[NSOperationQueue mainQueue] addOperation:op];
    return ;
}

#pragma mark - 发送GET请求
+(void)sendGETRequestWithUrl:(NSString *)urlString params:(NSDictionary *)params notificationName:(NSString *)notificationName{
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:[urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [[NSNotificationCenter defaultCenter] postNotificationName:notificationName object:nil userInfo:(NSDictionary*)responseObject];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        @throw [NSString stringWithFormat:@"Error:%@",error];
    }];
    
    return ;
}

#pragma mark - 发送POST请求
+(void)sendPOSTRequestWithUrl:(NSString *)urlString params:(NSDictionary *)params notificationName:(NSString *)notificationName{
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager POST:[urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [[NSNotificationCenter defaultCenter] postNotificationName:notificationName object:nil userInfo:(NSDictionary*)responseObject];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
    
    return ;
}

@end
