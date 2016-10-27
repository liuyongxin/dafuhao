//
//  AES.h
//  大富豪
//
//  Created by Louis on 2016/10/27.
//  Copyright © 2016年 Louis. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonCryptor.h>

@interface AES : NSObject
+(NSData *)DataAES128Encrypt:(NSString *)plainText key:(NSString *)key;
+(NSString *)AES128Encrypt:(NSString *)plainText key:(NSString *)key;
+(NSData *)DataAES128Decrypt:(NSString *)encryptText key:(NSString *)key;
+(NSString *)AES128Decrypt:(NSString *)encryptText key:(NSString *)key;

@end
