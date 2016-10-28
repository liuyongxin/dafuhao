//
//  DFHDataDefine.h
//  大富豪
//
//  Created by Louis on 2016/10/24.
//  Copyright © 2016年 Louis. All rights reserved.
//

#import <Foundation/Foundation.h>
#pragma mark -- 登陆账号信息
@interface DFHBaseInfo : NSObject


@end

#pragma mark -- 登陆账号信息
@interface DFHAccountInfo : DFHBaseInfo

@property(nonatomic,copy)NSString  *userid; //用户名
@property(nonatomic,copy)NSString  *passkey; //用户登录密钥

@end

#pragma mark -- 登陆返回信息
@interface DFHLoginInfo : DFHBaseInfo

@property(nonatomic,copy)NSString *codeId;
@property(nonatomic,copy)NSString *lastLoginTime;
@property(nonatomic,copy)NSString *password;
@property(nonatomic,copy)NSString *id;
@property(nonatomic,copy)NSString *loginStatus;
@property(nonatomic,copy)NSString *lastLoginIp;
@property(nonatomic,copy)NSString *telephone;
@property(nonatomic,copy)NSString *createTime;  //注册时间
@property(nonatomic,copy)NSString *code;  //邀请码

+ (DFHLoginInfo *)analyticalDataWithDictionary:(NSDictionary *)dic;

@end
