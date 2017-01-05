//
//  DFHRequestBaseInterface.m
//  大富豪
//
//  Created by Louis on 2016/10/24.
//  Copyright © 2016年 Louis. All rights reserved.
//

#import "DFHRequestBaseInterface.h"
#import "JSONFormatFunc.h"
#import "NSString+MD5.h"

@implementation DFHRequestBaseInterface

#pragma mark - 获取通用参数
+ (NSDictionary *)getCommonParamInfo
{
    NSMutableDictionary *headerData = [[NSMutableDictionary alloc] init];
    return headerData;
}

#pragma mark - 获取0协议要发送的数据   //不需要填充 token 的协议请求,如:登陆注册等
+ (NSMutableDictionary *)make0ProtocolSendData:(NSString *)reqName param:(NSMutableDictionary *)param rspClass:(Class)rspClass
{
    return [self makeSendData:0x0 reqType:reqName param:param rspClass:rspClass];
}

#pragma mark - 获取C协议要发送的数据   //需要填充 token 的协议请求
+ (NSMutableDictionary *)makeCProtocolSendData:(NSString *)reqName param:(NSMutableDictionary *)param rspClass:(Class)rspClass
{
    return [self makeSendData:0x0c reqType:reqName param:param rspClass:rspClass];
}

#pragma mark - 组合要发送的数据
+ (NSMutableDictionary *)makeSendData:(int)packageType reqType:(NSString *)reqName param:(NSMutableDictionary *)param rspClass:(Class)rspClass
{
    if (packageType == 0x0c) {
        // 请求参数中的token
    }
    // 公共参数
    NSDictionary *paramInfo = [[self class] getCommonParamInfo];
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]initWithDictionary:paramInfo];
    return dic;
}

@end
