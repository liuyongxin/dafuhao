//
//  MD5Encoding.h
//  DZHLotteryTicket
//
//  Created by Howard Dong on 13-12-16.
//  Copyright (c) 2013年 DZH. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MD5Encoding : NSObject

+ (void)md5Encoding:(NSString *)source output:(unsigned char *)output;

+ (NSData *)md5EncodingToData:(NSString *)source;

+ (NSString *)md5EncodingToString:(NSString *)source;

+ (NSData *)md5Encoding:(NSData *)data;

@end
