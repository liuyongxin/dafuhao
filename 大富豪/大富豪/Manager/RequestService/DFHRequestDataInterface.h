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
//telephone	手机	必填
//password	密码	必填，需要MD5加密
//code	邀请码	必填
//inviteName	邀请人姓名	可以为空
+ (NSString *)makeRequestMemberRegister:(NSString *)telephone password:(NSString *)password code:(NSString *)code inviteName:(NSString *)inviteName;

#pragma mark - 用户登录 member/login
//telephone	手机号	必填
//password	密码	必填，MD5加密
+ (NSString *)makeRequestMemberLogin:(NSString *)telephone password:(NSString *)password;


#pragma mark - 根据邀请码获取机器列表接口
//code	邀请码	必填
+ (NSString *)makeRequestMemberMachineList:(NSString *)code;

#pragma mark - 会员选择机台接口
//memberId	会员id	必填
//machineId	机台id	必填
+ (NSString *)makeRequestMemberChoiceMachine:(NSString *)memberId machineId:(NSString *)machineId;

#pragma mark - 根据机器 id 获取机器设置接口
//machineId	机器id	必填
+ (NSString *)makeRequestMachineSeting:(NSString *)machineId;

#pragma mark - 修改押分接口(手游版)
//memberId	会员id	必填
//score	押分	必填，数值类型
//machineId	机台id	必填
//rounds	第几轮	必填
//bouts	第几局	必填
//color	所押花色	S：黑
//C：梅
//H：红
//D：方
//O：王
+ (NSString *)makeRequestModifyPoints:(NSString *)memberId score:(NSString *)score machineId:(NSString *)machineId rounds:(NSString *)rounds bouts:(NSString *)bounts color:(NSString *)color;

#pragma mark - 修改盈利接口(手游版)<每局结束时调用>
//memberId	会员id	必填
//profit	本局盈利	必填，数值类型，如果押错该值为负
//machineId	机台id	必填
+ (NSString *)makeRequestModifyProfit:(NSString *)memberId profit:(NSString *)profit machineId:(NSString *)machineId;



@end
