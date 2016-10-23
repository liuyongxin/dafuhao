//
//  MNRequestBaseInterface.m
//  大富豪
//
//  Created by Louis on 16/6/20.
//  Copyright © 2016年 大富豪. All rights reserved.
//

#import "MNRequestBaseInterface.h"
#import "JSONFormatFunc.h"
#import "DESEncryption.h"
#import "NSString+MD5.h"
#import "MNDesManager.h"

@implementation MNRequestBaseInterface

#pragma mark - 获取通用参数 
//appkey	String	是	应用唯一标识
//token	String	是	授权加密token串
//method	String	是	API接口名称
//format	String	是	响应格式。默认为xml格式，可选值：xml，json。
//timestamp	String	是	时间戳(yyyy-MM-dd hh:mm:ss)
//content	String	是	请求参数（经DES加密的json），密钥：Yesbs528
//sign	String	是	数据校验码
//appkey:
//Android: A98162AF89004816F5CBC9B0D197240E
//iOS: ACC6FF5829F9990FFD2803C49ACDE753
//token:
//Android: C9E8D9086A13A18FC074F91A61F6F742
//iOS: CD59ED03A65909F5D036C17DA9F5BC8F
//sign: 数据校验码，用于效验数据是否正确完整，该码生成规则：md5(timestamp+content)。
//注意：在生成效验码时，传入的content是经过DES加密后的字符串。

+ (NSDictionary *)getCommonParamInfo
{
    NSMutableDictionary *headerData = [[NSMutableDictionary alloc] init];
    [headerData setObject:@"ACC6FF5829F9990FFD2803C49ACDE753" forKey:@"appkey"];  //应用唯一标识
    [headerData setObject:@"json" forKey:@"format"];                              //响应格式。默认为xml格式，可选值：xml，json。
    [headerData setObject:@"CD59ED03A65909F5D036C17DA9F5BC8F" forKey:@"token"];   //授权加密token串
    
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
    // 设置请求参数中公共参数
    NSMutableDictionary *wholeParam = [NSMutableDictionary dictionaryWithDictionary:param];
    [wholeParam setObject:[MNUtil getUUID] forKey:@"deviceid"];
    [wholeParam setObject:[MNUtil getIPAddress:YES]  forKey:@"ip"];
    if (packageType == 0x0c) {
        // 请求参数中的token
        NSString *token = [MNDataManager sharedInstance].loginInfo.token;
        [wholeParam setValue:token.length > 0 ? token : @"" forKey:@"token"];
    }
    
    // 获取请求参数json串
    NSString *jsonContentStr = [JSONFormatFunc formatJsonStrWithDictionary:wholeParam];
    
    // 公共参数
    NSDictionary *paramInfo = [[self class] getCommonParamInfo];
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]initWithDictionary:paramInfo];
    
    // API接口名称
    [dic setObject:reqName forKey:@"method"];
    
    // 请求时间戳(yyyy-MM-dd hh:mm:ss)
    NSString *timestamp = @"";
    NSDate *currentDate = [NSDate date];
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    format.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    timestamp = [format stringFromDate:currentDate];
    [dic setObject:timestamp forKey:@"timestamp"];
    
    // 加密请求参数（经DES加密的json），密钥：Yesbs528
    NSString *contentStr = @"";
    NSString *signStr = @""; //md5(timestamp+content)
    contentStr = [MNDesManager encryptUseDES:jsonContentStr];
    signStr =  [[NSString stringWithFormat:@"%@%@",timestamp,contentStr] md5Encoding];
    
    // 设置请求参数
    [dic setObject:contentStr forKey:@"content"];
    
    // 设置签名后数据
    [dic setObject:signStr forKey:@"sign"];
    
    // 打印请求参数
    NSLog(@"请求参数体：%@", jsonContentStr);
   
    return dic;
}

@end
