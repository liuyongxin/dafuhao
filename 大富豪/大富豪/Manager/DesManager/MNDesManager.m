//
//  MNDesManager.m
//  大富豪
//
//  Created by Devoson on 16/6/20.
//  Copyright © 2016年 大富豪. All rights reserved.
//

#import "MNDesManager.h"
#import <CommonCrypto/CommonCryptor.h>
#import "GTMBase64.h"
#import "NSString+MNAddition.h"

@implementation MNDesManager

/*字符串加密
 *参数
 *plainText : 加密明文
 *key        : 密钥 64位
 */
+ (NSString *) encryptUseDES:(NSString *)plainText
{
    if (!plainText) {
        return nil;
    }
    
    NSString *key = @"Yesbs528";
    NSString *ciphertext = nil;
    const char *textBytes = [plainText UTF8String];
    NSUInteger dataLength = strlen(textBytes);
    unsigned char buffer[1024];
    memset(buffer, 0, 1024 * sizeof(char));
    // Yesbc528的ascII码
    Byte iv[] = {0x59, 0x65, 0x73, 0x62, 0x73, 0x35, 0x32, 0x38};
    size_t numBytesEncrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt, kCCAlgorithmDES,
                                          kCCOptionPKCS7Padding,
                                          [key UTF8String], kCCKeySizeDES,
                                          iv,
                                          textBytes, dataLength,
                                          buffer, 1024,
                                          &numBytesEncrypted);
    if (cryptStatus == kCCSuccess) {
        NSData *data = [NSData dataWithBytes:buffer length:(NSUInteger)numBytesEncrypted];
        
        ciphertext = [[[[data description] uppercaseString] stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"<>"]] stringByReplacingOccurrencesOfString:@" " withString:@""];
    }
    
    return ciphertext;
}

//解密
+ (NSString *) decryptUseDES:(NSString*)cipherText
{
    if (!cipherText) {
        return nil;
    }
    
    NSString *key = @"Yesbs528";
    NSData *cipherData = [cipherText stringToByte];
    
    unsigned char buffer[1024];
    memset(buffer, 0, 1024 * sizeof(char));
    size_t numBytesDecrypted = 0;
    Byte iv[] = {0x59, 0x65, 0x73, 0x62, 0x73, 0x35, 0x32, 0x38};
    CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt,
                                          kCCAlgorithmDES,
                                          kCCOptionPKCS7Padding,
                                          [key UTF8String],
                                          kCCKeySizeDES,
                                          iv,
                                          [cipherData bytes],
                                          [cipherData length],
                                          buffer,
                                          1024,
                                          &numBytesDecrypted);
    NSString* plainText = nil;
    if (cryptStatus == kCCSuccess) {
        NSData* data = [NSData dataWithBytes:buffer length:(NSUInteger)numBytesDecrypted];
        plainText = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    }
    return plainText;
}

@end
