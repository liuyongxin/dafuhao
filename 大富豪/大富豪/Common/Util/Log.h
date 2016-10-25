//
//  Log.h
//  DzhIPhone
//
//  Created by Howard on 11-7-1.
//  Copyright 2011 __DZH__. All rights reserved.
//

#ifdef DEBUG

#define NSLog(format, ...) CMLogDebug(format,## __VA_ARGS__)
#define CDebugLog(format, ...) CMLogDebug(format, ## __VA_ARGS__)

#define printLog_IF(fmt, a...) do{fprintf(stderr, "%s,%s(),%d:" fmt "\n", __FILE__,__FUNCTION__,__LINE__, ##a);fflush(stderr);} while(0)
//#define printLog_IF(templt, ...) do{fprintf(stderr,templt, ##__VAR_ARGS__); putchar('\n'); fflush(stderr);} while(0)
#else
//#define CDebugLog(...)
#define printLog_IF(...)

#define NSLog(format, ...)
#define CDebugLog(format, ...)

#endif

