//
//  DFHLogManagement.m
//  大富豪
//
//  Created by Louis on 2016/10/24.
//  Copyright © 2016年 Louis. All rights reserved.
//

#import "DFHLogManagement.h"
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import <CoreTelephony/CTCarrier.h>

/**************************************************************************
 FunctionName:  WriteCinLog
 FunctionDesc:  具有日志级别的日志信息
 Parameters:
 Param1Name:    file:const char *
 Param1Desc:    记录日志所在的文件名称
 Param2Name:    function:const char *
 Param2Desc:    记录日志所在的函数名称
 Param3Name:    lineNumber:int
 Param3Desc:    代码所在行数
 Param4Name:    level:CinLogLevel
 Param4Desc:    日志级别(OFF、FATAL、ERROR、WARN、INFO、DEBUG、ALL)
 Param5Name:    format:NSString
 Param5Desc:    日志内容，格式化字符串
 ReturnVal:     NONE
 **************************************************************************/

void WriteCinLog(const char *file, const char* function, int lineNumber, CinLogLevel level, NSString* format, ...)
{
    DFHLogManagement* manager = [DFHLogManagement sharedDFHLogManagement];
    static NSArray *levels;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        levels = @[@"ALL",@"DEBUG",@"INFO",@"WARN",@"ERROR",@"FATAL",@"OFF"];
    });
    if (!format) return;
    
    if (manager.logLevel <= level || manager.logLevel <= LogLevel_ALL) // 先检查当前程序设置的日志输出级别。如果这条日志不需要输出，就不用做字符串格式化
    {
        if (MNLogToConsole) {
            //log to console
            va_list args;
            va_start(args, format);
            NSString* str = [[NSString alloc] initWithFormat:format arguments:args];
            va_end(args);
            
            NSString *date = [manager.df stringFromDate:[NSDate date]];
            
            fprintf(stderr,"\n[%s]%s%s#Line:%d:\n%s\n",[levels[level] UTF8String],date.UTF8String,function,lineNumber,[str UTF8String]);
        }
    }
}

NSString* getAppInfo()
{
    NSString *appInfo = [NSString stringWithFormat:@"App : %@ %@(%@)\nDevice : %@\nOS Version : %@ %@\n",
                         [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleDisplayName"],
                         [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"],
                         [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleVersion"],
                         [UIDevice currentDevice].model,
                         [UIDevice currentDevice].systemName,
                         [UIDevice currentDevice].systemVersion];
    return appInfo;
}


@interface DFHLogManagement ()

@end

@implementation DFHLogManagement

+ (DFHLogManagement *)sharedDFHLogManagement {
    static DFHLogManagement*sharedDFHLogManagement = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedDFHLogManagement = [[DFHLogManagement alloc] init];
    });
    return sharedDFHLogManagement;
}

+ (DFHLogManagement *)sharedInstance
{
    return [self sharedDFHLogManagement];
}

- (id)init
{
    self = [super init];
    
    if (self)
    {
        //默认日志输出等级
        self.logLevel = MNDefaultLogLevel;
        self.df = [[NSDateFormatter alloc]init];
        [self.df setDateFormat:@"HH:mm:ss"];
    }
    
    return self;
}

- (NSString *)getCurrentBattery
{
    [UIDevice currentDevice].batteryMonitoringEnabled = YES;
    double deviceLevel = [UIDevice currentDevice].batteryLevel;
    return [NSString stringWithFormat:@"%.2f",deviceLevel];
}

- (NSString *)getCurrentCarrier
{
    CTTelephonyNetworkInfo *info = [[CTTelephonyNetworkInfo alloc] init];
    CTCarrier *carrier = [info subscriberCellularProvider];
    if (carrier == nil) {
        return @"-";
    }
    
    NSString *code = [carrier mobileNetworkCode];
    if (code == nil) {
        return @"-";
    }
    
    if ([code isEqualToString:@"00"] || [code isEqualToString:@"02"] || [code isEqualToString:@"07"]) {
        return @"中国移动";
    }
    else if([code isEqualToString:@"01"] || [code isEqualToString:@"06"])
    {
        return @"中国联通";
    }
    else if([code isEqualToString:@"03"] || [code isEqualToString:@"05"])
    {
        return @"中国电信";
    }
    
    return @"-";
}

- (NSString *)getNetWorkStates{
    UIApplication *app = [UIApplication sharedApplication];
    NSArray *children = [[[app valueForKeyPath:@"statusBar"]valueForKeyPath:@"foregroundView"]subviews];
    NSString *state = @"-";
    int netType = 0;
    //获取到网络返回码
    for (id child in children) {
        if ([child isKindOfClass:NSClassFromString(@"UIStatusBarDataNetworkItemView")]) {
            //获取到状态栏
            netType = [[child valueForKeyPath:@"dataNetworkType"]intValue];
            
            switch (netType) {
                    case 0:
                    state = @"nonetwork";
                    //无网模式
                    break;
                    case 1:
                    state = @"2G";
                    break;
                    case 2:
                    state = @"3G";
                    break;
                    case 3:
                    state = @"4G";
                    break;
                    case 5:
                    state = @"WIFI";
                    break;
                default:
                    break;
            }
        }
    }
    //根据状态选择
    return state;
}

@end
