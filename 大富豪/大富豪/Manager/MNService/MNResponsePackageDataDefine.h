//
//  MNResponsePackageDataDefine.h
//  大富豪
//
//  Created by Louis on 16/6/20.
//  Copyright © 2016年 大富豪. All rights reserved.
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

@interface MNResponsePackageDataBase : NSObject

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
@interface CosPassportClogin: MNResponsePackageDataBase

@property (nonatomic, assign) int code;  //返回结果代码，0-成功，其它为失败

@property (nonatomic, copy) NSString *msg;  //返回结果说明信息

@property (nonatomic ,retain) NSDictionary *content; //返回结果说明信息
//    Cno	String	是	客户编号
//    Cname	String	否	客户姓名
//    CNickName	String	是	客户昵称
//    Csex	String	否	性别
//    CBirthday	String	否	出生日期
//    CMobile	String	是	手机号码
//    CEmail	String	否	邮件地址
//    Education	String	否	教育程度
//    Profession	String	否	职业
//    MonthlyIncome	Number	是	默认为0
//    Married	Int	是	0-未婚，1-已婚，2-保密
//    CGrade	int	是	用户等级，0-初级
//    TotalAmount	Number	是	用户账户余额，0即无
//    TotalPoints	Int	是	用户可用积分点数
//    ThumbnailPic	String	否	用户头像缩略图URL
//    NormalPic	String	否	用户头像正常图URL
//    token	String	是	登录成功返回身份认证token
@end
