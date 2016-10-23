//
//  MD5Encoding.m
//  DZHLotteryTicket
//
//  Created by Howard Dong on 13-12-16.
//  Copyright (c) 2013年 DZH. All rights reserved.
//

#import "MD5Encoding.h"
#import <CommonCrypto/CommonDigest.h>


@implementation MD5Encoding

+ (void)md5Encoding:(NSString *)source output:(unsigned char *)output
{
    const char *cStr = [source UTF8String];
    CC_MD5(cStr, [source lengthOfBytesUsingEncoding:NSUTF8StringEncoding], output);
    
}

+ (NSData *)md5EncodingToData:(NSString *)source
{
    return [[self class] md5Encoding:[NSData dataWithBytes:[source UTF8String] length:[source lengthOfBytesUsingEncoding:NSUTF8StringEncoding]]];
}

+ (NSString *)md5EncodingToString:(NSString *)source
{
    const char *cStr = [source UTF8String];//转换成utf-8
    unsigned char result[CC_MD5_DIGEST_LENGTH];//开辟一个16字节（128位：md5加密出来就是128位/bit）的空间（一个字节=8字位=8个二进制数）
    
    CC_MD5( cStr, strlen(cStr), result);
    NSMutableString *Mstr = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH];
    
    for (int i=0; i<CC_MD5_DIGEST_LENGTH; i++) {
        [Mstr appendFormat:@"%02x",result[i]];
    }
    
    return Mstr;
}

+ (NSData *)md5Encoding:(NSData *)data
{
    unsigned char *cStr = (unsigned char *)[data bytes];
    unsigned char result[CC_MD5_DIGEST_LENGTH];//开辟一个16字节（128位：md5加密出来就是128位/bit）的空间（一个字节=8字位=8个二进制数）
    
    CC_MD5(cStr, [data length], result);
    return [NSData dataWithBytes:result length:CC_MD5_DIGEST_LENGTH];
}

@end
