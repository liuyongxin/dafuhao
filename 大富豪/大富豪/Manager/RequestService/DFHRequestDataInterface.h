//
//  DFHRequestDataInterface.h
//  大富豪
//
//  Created by Louis on 2016/10/24.
//  Copyright © 2016年 Louis. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DFHRequestBaseInterface.h"

@interface DFHRequestDataInterface : DFHRequestBaseInterface

#pragma mark - 用户注册 member/register

+ (NSMutableDictionary *)makeRequestMemberRegister:(NSString *)telephone password:(NSString *)password code:(NSString *)code inviteName:(NSString *)inviteName;

#pragma mark - 用户登录 cos_passport_clogin
/**
 *  用户登录
 *  @param userid  用户名
 *  @param passkey 用户登录密钥（md5加密）
 *  @return 拼接完成字典
 */
+ (NSMutableDictionary *)makeRequestCosPassportClogin:(NSString *)userid passkey:(NSString *)passkey;

@end
