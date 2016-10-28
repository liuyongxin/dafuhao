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

+ (NSString *)makeRequestMemberRegister:(NSString *)telephone password:(NSString *)password code:(NSString *)code inviteName:(NSString *)inviteName
{
    NSString *url = DFH_MemberRegister;
    NSString *urlStr = [NSString stringWithFormat:@"%@?telephone=%@&password=%@&code=%@&inviteName%@",url,telephone,[password md5String],code,inviteName];
    return urlStr;
}

+ (NSString *)makeRequestMemberLogin:(NSString *)telephone password:(NSString *)password
{
    NSString *url = DFH_MemberLogin;
    NSString *urlStr = [NSString stringWithFormat:@"%@?telephone=%@&password=%@",url,telephone,[password md5String]];
    return urlStr;
}

+ (NSString *)makeRequestMembersMachineList:(NSString *)code
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

@end
