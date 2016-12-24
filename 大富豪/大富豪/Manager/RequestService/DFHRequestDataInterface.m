//
//  DFHRequestDataInterface.m
//  大富豪
//
//  Created by Louis on 2016/10/24.
//  Copyright © 2016年 Louis. All rights reserved.
//

#import "DFHRequestDataInterface.h"
#import "NSString+MD5.h"
#import "DFHUtil.h"
#import "AES.h"

@implementation DFHRequestDataInterface

+ (NSDictionary *)makeRequestMemberRegister:(NSString *)telephone password:(NSString *)password code:(NSString *)code nickName:(NSString *)nickName inviteName:(NSString *)inviteName
{//DFH_MemberRegister
    NSDictionary *parametersDic = @{
                          @"telephone"  :  telephone,
                          @"password"   :  password,
                          @"code"       :  code,
                          @"nickname"   :  nickName,
                          @"inviteName" : inviteName
                          };
    return parametersDic;
}

+ (NSString *)makeRequestMemberLogin:(NSString *)telephone password:(NSString *)password
{
    NSString *url = DFH_MemberLogin;
    NSString *urlStr = [NSString stringWithFormat:@"%@?telephone=%@&password=%@",url,telephone,[password md5String]];
    return urlStr;
}

+ (NSString *)makeRequestMemberMachineList:(NSString *)code
{
    NSString *url = DFH_MachineSelectBycode;
    NSString *urlStr = [NSString stringWithFormat:@"%@?code=%@",url,code];
    return urlStr;
}

+ (NSString *)makeRequestMemberChoiceMachine:(NSString *)memberId machineId:(NSString *)machineId
{
    NSString *url = DFH_MemberChoiceMachine;
    NSString *urlStr = [NSString stringWithFormat:@"%@?memberId=%@&machineId=%@",url,memberId,machineId];
    return urlStr;
}

+ (NSString *)makeRequestMachineSeting:(NSString *)machineId
{
    NSString *url = DFH_MachinesetGetById;
    NSString *urlStr = [NSString stringWithFormat:@"%@?machineId=%@",url,machineId];
    return urlStr;
}

+ (NSString *)makeRequestModifyPoints:(NSString *)memberId score:(NSString *)score machineId:(NSString *)machineId rounds:(NSString *)rounds bouts:(NSString *)bounts color:(NSString *)color;
{
    NSString *url = DFH_MachineUpdateStake;
    NSString *urlStr = [NSString stringWithFormat:@"%@?memberId=%@&score=%@&machineId=%@&rounds=%@&bounds=%@&color=%@",url,memberId,score,machineId,rounds,bounts,color];
    return urlStr;
}

+ (NSString *)makeRequestModifyProfit:(NSString *)memberId profit:(NSString *)profit machineId:(NSString *)machineId
{
    NSString *url = DFH_MachineUpdateProfit;
    NSString *urlStr = [NSString stringWithFormat:@"%@?mamberId=%@&profit=%@&machineId=%@",url,memberId,profit,machineId];
    return urlStr;
}

#pragma mark - 获取单个牌路(请求返回为 aes 加密字符串)
//machineId	机台id	必填
//rounds	轮	必填，数字类型
//bouts	局	必填，数字类型
+ (NSString *)makeRequestObtainSingleCard:(NSString *)machineId rounds:(NSString *)rounds bouts:(NSString *)bouts
{
    NSString *url = DFH_PokerGetPoker;
    NSString *urlStr = [NSString stringWithFormat:@"%@?machineId=%@&rounds=%@&bouts=%@",url,machineId,rounds,bouts];
    return urlStr;
}

#pragma mark - 修改某局状态接口(请求返回为 aes 加密字符串)
//machineId	机台id	必填
//rounds	轮	必填，数字类型
//bouts	局	必填，数字类型
//status	当前状态	1初始化，2押分中，3准备中，4已开球
+ (NSString *)makeRequestModifyBureauState:(NSString *)machineId rounds:(NSString *)rounds bouts:(NSString *)bouts status:(NSString *)status
{
    NSString *url = DFH_PokerUpdateStatus;
    NSString *urlStr = [NSString stringWithFormat:@"%@?machineId=%@&rounds=%@&bouts=%@&status=%@",url,machineId,rounds,bouts,status];
    return urlStr;
}

#pragma mark - 获取历史牌路接口(请求返回为 aes 加密字符串)
//machineId	机器id	必填
+ (NSString *)makeRequestHistoryBrandRoad:(NSString *)machineId
{
    NSString *url = DFH_PokerGetHistory;
    NSString *urlStr = [NSString stringWithFormat:@"%@?machineId=%@",url,machineId];
    return urlStr;
}

#pragma mark - 生成牌路接口
//machineId	机器id	必填
+ (NSString *)makeRequestGenerateBrandRoad:(NSString *)machineId
{
    NSString *url = DFH_PokerGenerate;
    NSString *urlStr = [NSString stringWithFormat:@"%@?machineId=%@",url,machineId];
    return urlStr;
}

@end
