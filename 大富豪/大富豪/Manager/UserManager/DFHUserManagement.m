//
//  DFHUserManagement.m
//  大富豪
//
//  Created by Louis_liu on 2016/12/21.
//  Copyright © 2016年 Louis. All rights reserved.
//

#import "DFHUserManagement.h"

@implementation DFHUserManagement

#pragma mark - 获取登录的帐号信息
+ (DFHAccountInfo *)getMobileAccountInfo:(NSString *)companyName
{
    NSString *filePath = [CommonFileFunc getDocumentFilePath:@"DFHAccountInfo.plist"];
    NSMutableDictionary *mobileAccountDict = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
    DFHAccountInfo *accountInfo = nil;
    if ([mobileAccountDict count] > 0 && [mobileAccountDict.allKeys containsObject:companyName])
    {
        accountInfo = [mobileAccountDict objectForKey:companyName];
    }
    return accountInfo;
}

#pragma mark - 保存登录的帐号信息
+ (void)saveMobileAccountInfo:(DFHAccountInfo *)mobileAccountInfo
{
    NSString *filePath = [CommonFileFunc getDocumentFilePath:@"DFHAccountInfo.plist"];
    NSMutableDictionary *mobileAccountDict = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
    if (!mobileAccountDict)
    {
        mobileAccountDict = [NSMutableDictionary dictionary];
    }
    if (![mobileAccountDict.allKeys containsObject:mobileAccountInfo.userName])
    {
        [mobileAccountDict setObject:mobileAccountInfo forKey:mobileAccountInfo.userName];
        [NSKeyedArchiver archiveRootObject:mobileAccountDict toFile:filePath];
    }
}

@end
