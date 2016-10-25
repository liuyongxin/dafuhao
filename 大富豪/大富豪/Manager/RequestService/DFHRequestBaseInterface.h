//
//  DFHRequestBaseInterface.h
//  大富豪
//
//  Created by Louis on 2016/10/24.
//  Copyright © 2016年 Louis. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DFHRequestBaseInterface : NSObject
#pragma mark - 获取0协议要发送的数据   //不需要填充 token 的协议请求,如:登陆注册等
+ (NSMutableDictionary *)make0ProtocolSendData:(NSString *)reqName param:(NSMutableDictionary *)param rspClass:(Class)rspClass;

/**
 *  获取公用的参数数据，需在子类实现
 *
 *  @return 公用参数字符串
 */
+ (NSDictionary *)getCommonParamInfo;

#pragma mark - 获取C协议要发送的数据   //需要填充 token 的协议请求,如:商品查询等
+ (NSMutableDictionary *)makeCProtocolSendData:(NSString *)reqName param:(NSMutableDictionary *)param rspClass:(Class)rspClass;
@end
