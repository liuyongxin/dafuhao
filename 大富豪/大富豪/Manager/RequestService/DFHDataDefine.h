//
//  DFHDataDefine.h
//  大富豪
//
//  Created by Louis on 2016/10/24.
//  Copyright © 2016年 Louis. All rights reserved.
//

#import <Foundation/Foundation.h>

#pragma mark -- 登陆账号信息
@interface DFHAccountInfo : NSObject<NSCoding>

@property(nonatomic,copy)NSString  *userid; //用户名
@property(nonatomic,copy)NSString  *passkey; //用户登录密钥

@end

#pragma mark -- 登陆返回信息
@interface DFHLoginInfo : NSObject<NSCoding>

@property(nonatomic,copy)NSString *cNO;
@property(nonatomic,copy)NSString *cName;
@property(nonatomic,copy)NSString *token;

- (void)analyticalDataWithDictionary:(NSDictionary *)dic;

@end
