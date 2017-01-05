//
//  DFHUtil.h
//  大富豪
//
//  Created by Louis on 2016/10/24.
//  Copyright © 2016年 Louis. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface DFHUtil : NSObject
+ (NSString *)getUUID;

+ (BOOL)isPureNumandCharacters:(NSString *)string; //字符串是否为正数字

+ (NSString *)getIPAddress:(BOOL)preferIPv4;  //获取

+ (NSString *)getDateSinceToday:(int)intervalDays;

+ (NSString *)decimalTOBinary:(uint16_t)tmpid backLength:(int)length;
+(NSString *)getBinaryByhex:(NSString *)hex;
+ (NSString *)stringFromHexString:(NSString *)hexString;
+ (NSString *)hexStringFromString:(NSString *)string;
//判断手机号码格式是否正确
+ (BOOL)validMobile:(NSString *)mobile;
+ (CGSize)stringBoundingRectWithSize:(CGSize)size withFont:(UIFont *)font withDescription:(NSString *)text;

@end
