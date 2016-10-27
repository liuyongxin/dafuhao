//
//  DFHLogManagement.h
//  大富豪
//
//  Created by Louis on 2016/10/24.
//  Copyright © 2016年 Louis. All rights reserved.
//

/**
 注:当前只供本地打印,后期可加入日志保存上传功能
 */
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef enum CinLogLevel_
{
    LogLevel_ALL        = 0,        // 打开所有日志记录
    LogLevel_DEBUG      = 1,        // 指出细粒度信息事件对调试应用程序是非常有帮助的
    LogLevel_INFO       = 2,        // 消息在粗粒度级别上突出强调应用程序的运行过程
    LogLevel_WARN       = 3,        // 出现潜在错误的情形
    LogLevel_ERR        = 4,        // 发生错误事件，但仍然不影响系统的继续运行
    LogLevel_FATAL      = 5,        // 严重的错误事件将会导致应用程序的退出
    LogLevel_OFF        = 6,        // 关闭所有日志记录
}CinLogLevel;

#define DFHLogDebug(format, ...)         WriteCinLog(__FILE__, __FUNCTION__, __LINE__, LogLevel_DEBUG, format, ##__VA_ARGS__)
#define DFHLogInfo(format, ...)          WriteCinLog(__FILE__, __FUNCTION__, __LINE__, LogLevel_INFO, format, ##__VA_ARGS__)
#define DFHLogWarn(format, ...)          WriteCinLog(__FILE__, __FUNCTION__, __LINE__, LogLevel_WARN, format, ##__VA_ARGS__)
#define DFHLogError(format, ...)         WriteCinLog(__FILE__, __FUNCTION__, __LINE__, LogLevel_ERR, format, ##__VA_ARGS__)
#define DFHLogFatal(format, ...)         WriteCinLog(__FILE__, __FUNCTION__, __LINE__, LogLevel_FATAL, format, ##__VA_ARGS__)

#define DFHLogToConsole 1

//系统默认日志输出等级
#define DFHDefaultLogLevel LogLevel_INFO

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
void WriteCinLog(const char *file, const char* function, int lineNumber, CinLogLevel level, NSString* format, ...);

@interface DFHLogManagement : NSObject

@property NSInteger logLevel;               // 日志级别 (OFF、FATAL、ERROR、WARN、INFO、DEBUG、ALL)
@property(nonatomic,retain)NSDateFormatter *df;

+ (DFHLogManagement *)sharedDFHLogManagement;
+ (DFHLogManagement *)sharedInstance;
- (NSString *)getCurrentBattery;  //电池状态
- (NSString *)getCurrentCarrier;  //运营商
- (NSString *)getNetWorkStates;   //网络类型

@end
