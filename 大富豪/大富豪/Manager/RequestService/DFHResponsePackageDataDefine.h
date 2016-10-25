//
//  DFHResponsePackageDataDefine.h
//  大富豪
//
//  Created by Louis on 2016/10/24.
//  Copyright © 2016年 Louis. All rights reserved.
//

#import <Foundation/Foundation.h>

// 数据包应答状态
typedef NS_OPTIONS(NSUInteger, ResponsePackageType) {
    ResponsePackageParserFailed     = 0,        // 数据解析失败
    ResponsePackageSuccess          = 1,        // 成功
    ResponsePackageTimeOut          = 2,        // 请求超时
    ResponsePackageNeworkErr        = 3,        // 网络中断
    ResponsePackageCRCFailed        = 4,        // CRC校验失败
    ResponsePackageClearRequestData = 5,        // 清空请求数据
};

@interface DFHResponsePackageDataBase : NSObject

// 针对有些接口，返回的数据需要和请求参数作比较。
@property (nonatomic, retain) NSDictionary *requestParams;
// 请求类型
@property (nonatomic, assign) int requestType;
// 错误信息
@property (nonatomic, copy) NSString *errorMessage;

// 解析响应数据
- (ResponsePackageType)parseFromData:(NSData *)data;
// 解析出错信息
- (void)parseErrorDictFromData:(NSData *)data;

@end

#pragma mark - 登陆接口 解析类
@interface CosPassportClogin: DFHResponsePackageDataBase

@property (nonatomic, assign) int code;  //返回结果代码，0-成功，其它为失败
@property (nonatomic, copy) NSString *msg;  //返回结果说明信息
@property (nonatomic ,retain) NSDictionary *content; //返回结果说明信息

@end
