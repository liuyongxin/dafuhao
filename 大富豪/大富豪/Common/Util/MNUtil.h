//
//  MNUtil.h
//  大富豪
//
//  Created by Louis on 16/6/22.
//  Copyright © 2016年 大富豪. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MNUtil : NSObject

+ (NSString *)getUUID;

+ (BOOL)isPureNumandCharacters:(NSString *)string; //字符串是否为正数字

+ (NSString *)getIPAddress:(BOOL)preferIPv4;  //获取

+ (NSString *)getDateSinceToday:(int)intervalDays;

@end
