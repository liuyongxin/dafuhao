//
//  AESCrypt.m
//  Gurpartap Singh
//
//  Created by Gurpartap Singh on 06/05/12.
//  Copyright (c) 2012 Gurpartap Singh
// 
// 	MIT License
// 
// 	Permission is hereby granted, free of charge, to any person obtaining
// 	a copy of this software and associated documentation files (the
// 	"Software"), to deal in the Software without restriction, including
// 	without limitation the rights to use, copy, modify, merge, publish,
// 	distribute, sublicense, and/or sell copies of the Software, and to
// 	permit persons to whom the Software is furnished to do so, subject to
// 	the following conditions:
// 
// 	The above copyright notice and this permission notice shall be
// 	included in all copies or substantial portions of the Software.
// 
// 	THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
// 	EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
// 	MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
// 	NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
// 	LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
// 	OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
// 	WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
//

#import "AESCrypt.h"
#import "NSData+Base64.h"
#import "NSString+Base64.h"
#import <CommonCrypto/CommonCryptor.h>
#import "NSData+CommonCrypto.h"

@implementation AESCrypt

+ (NSString *)generate32ByteAESKey
{
    NSString *randVal = @"";
    // 生成32位加密密钥
    NSArray *generateNumberList = [NSArray arrayWithObjects:@"0", @"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"a", @"b", @"c", @"d", @"e", @"f", @"g", @"h", @"i", @"j", @"k", @"l", @"m", @"n", @"o", @"p", @"q", @"r", @"s", @"t", @"u", @"v", @"w", @"x", @"y", @"z", @"A", @"B", @"C", @"D", @"E", @"F", @"G", @"H", @"I", @"J", @"K", @"L", @"M", @"N", @"O", @"P", @"Q", @"R", @"S", @"T", @"U", @"V", @"W", @"X", @"Y", @"Z", nil];
    
    for (int i = 0; i < 32; i++)
    {
        int idx = arc4random() % [generateNumberList count];
        randVal = [randVal stringByAppendingString:[generateNumberList objectAtIndex:idx]];
    }
    
    NSString *retVal = [randVal length] > 0 ? randVal : nil;
    return retVal;
}

+ (NSData *)encryptData:(NSString *)message password:(NSString *)password
{
    NSData *encryptedData = [[self class] encryptDataWithByteKey:message password:[password UTF8String]];
//    NSData *encryptedData = [[message dataUsingEncoding:NSUTF8StringEncoding] AES256EncryptedDataUsingKey:[[password dataUsingEncoding:NSUTF8StringEncoding] SHA256Hash] error:nil];
    
    return encryptedData;
}

+ (NSData *)encryptByteData:(NSData *)data password:(NSString *)password
{
    return [[self class] encryptByteDataWithByteKey:data password:[password UTF8String]];
}

+ (NSData *)encryptByteDataWithByteKey:(NSData *)data password:(const void *)password
{
    return [[self class] encryptByteDataWithByteKey:data password:password paddingMode:kCCOptionPKCS7Padding/*这里就是刚才说到的PKCS7Padding填充了*/ | kCCOptionECBMode];
}

+ (NSData *)encryptByteDataWithByteKey:(NSData *)data password:(const void *)password paddingMode:(NSInteger)paddingMode
{
    return [[self class] encryptByteDataWithByteKey:data password:password paddingMode:paddingMode keyBitType:kCCKeySizeAES128];
}

+ (NSData *)encryptDataWithByteKey:(NSString *)message password:(const void *)password
{
    return [[self class] encryptByteDataWithByteKey:[message dataUsingEncoding:NSUTF8StringEncoding] password:password];
}

+ (NSString *)encrypt:(NSString *)message password:(NSString *)password
{
  NSData *encryptedData = [[self class] encryptData:message password:password];
  NSString *base64EncodedString = [NSString base64StringFromData:encryptedData length:[encryptedData length]];
  return base64EncodedString;
}

+ (NSString *)encryptWithByteData:(NSData *)data password:(NSString *)password
{
    NSData *encryptedData = [[self class] encryptByteData:data password:password];
    NSString *base64EncodedString = [NSString base64StringFromData:encryptedData length:[encryptedData length]];
    return base64EncodedString;
}

+ (NSString *)encryptWithByteKey:(NSString *)message password:(const void *)password
{
    NSData *encryptedData = [[self class] encryptDataWithByteKey:message password:password];
    NSString *base64EncodedString = [NSString base64StringFromData:encryptedData length:[encryptedData length]];
    return base64EncodedString;
}

+ (NSString *)decrypt:(NSString *)base64EncodedString password:(NSString *)password
{
  NSData *encryptedData = [NSData dataFromBase64String:base64EncodedString];
  NSData *decryptedData = [[self class] decryptData:encryptedData password:password];
  return [[NSString alloc] initWithData:decryptedData encoding:NSUTF8StringEncoding];
}

+ (NSString *)decryptWithByteKey:(NSString *)base64EncodedString password:(const void *)password
{
    NSData *encryptedData = [NSData dataFromBase64String:base64EncodedString];
    NSData *decryptedData = [[self class] decryptDataWithByteKey:encryptedData password:password];
    return [[NSString alloc] initWithData:decryptedData encoding:NSUTF8StringEncoding];
}

+ (NSData *)decryptData:(NSData *)data password:(NSString *)password
{
    NSData *decryptData = [[self class] decryptDataWithByteKey:data password:[password UTF8String]];
    return decryptData;
}

+ (NSData *)decryptDataWithByteKey:(NSData *)data password:(const void *)password
{
    return [[self class] decryptDataWithByteKey:data password:password paddingMode:kCCOptionPKCS7Padding/*这里就是刚才说到的PKCS7Padding填充了*/ | kCCOptionECBMode];
}

+ (NSData *)decryptDataWithByteKey:(NSData *)data password:(const void *)password paddingMode:(NSInteger)paddingMode
{
    return [[self class] decryptDataWithByteKey:data password:password paddingMode:paddingMode keyBitType:kCCKeySizeAES128];
}

+ (NSData *)encryptByteDataWithByteKey:(NSData *)data password:(const void *)password paddingMode:(NSInteger)paddingMode keyBitType:(NSInteger)keyBitType
{
    NSData *encryptedData = nil;
    //对于块加密算法，输出大小总是等于或小于输入大小加上一个块的大小
    //所以在下边需要再加上一个块的大小
    NSData *noEncryptedData = data;
    NSUInteger dataLength = [noEncryptedData length];
    size_t bufferSize = dataLength + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    size_t numBytesEncrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt, kCCAlgorithmAES,
                                          paddingMode,
                                          password, keyBitType,
                                          NULL,/* 初始化向量(可选) */
                                          [noEncryptedData bytes], dataLength,/*输入*/
                                          buffer, bufferSize,/* 输出 */
                                          &numBytesEncrypted);
    if (cryptStatus == kCCSuccess)
    {
        encryptedData = [NSData dataWithBytes:buffer length:numBytesEncrypted];
    }
    free(buffer);//释放buffer
    return encryptedData;
}

+ (NSData *)decryptDataWithByteKey:(NSData *)data password:(const void *)password paddingMode:(NSInteger)paddingMode keyBitType:(NSInteger)keyBitType
{
    NSData *decryptData = nil;
    //同理，解密中，密钥和加密密钥相同位数
    //对于块加密算法，输出大小总是等于或小于输入大小加上一个块的大小
    //所以在下边需要再加上一个块的大小
    if (password)
    {
        NSUInteger dataLength = [data length];
        size_t bufferSize = dataLength + kCCBlockSizeAES128;
        void *buffer = malloc(bufferSize);
        
        size_t numBytesDecrypted = 0;
        CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt, kCCAlgorithmAES,
                                              paddingMode,
                                              password, keyBitType,
                                              NULL,/* 初始化向量(可选) */
                                              [data bytes], dataLength,/* 输入 */
                                              buffer, bufferSize,/* 输出 */
                                              &numBytesDecrypted);
        if (cryptStatus == kCCSuccess) {
            decryptData = [NSData dataWithBytes:buffer length:numBytesDecrypted];
        }
        free(buffer);
    }
    return decryptData;
}

#pragma AES 128 cbc no padding

+(BOOL)validKey:(NSString*)key
{
    if( key==nil || key.length !=16 ){
        return NO;
    }
    return YES;
}

#pragma AES 256 cbc no padding

+(BOOL)valid256Key:(NSString*)key
{
    if( key==nil || key.length !=32 ){
        return NO;
    }
    return YES;
}

+(NSString *)AES128Decrypt:(NSData *)data withKey:(NSString *)key
{
    if( ![self validKey:key] ){
        return nil;
    }
    
    char keyPtr[kCCKeySizeAES128 + 1];
    memset(keyPtr, 0, sizeof(keyPtr));
    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    
    char ivPtr[kCCBlockSizeAES128 + 1];
    memset(ivPtr, 0, sizeof(ivPtr));
    [key getCString:ivPtr maxLength:sizeof(ivPtr) encoding:NSUTF8StringEncoding];
    
    NSUInteger dataLength = [data length];
    size_t bufferSize = dataLength + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    
    size_t numBytesCrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt,
                                          kCCAlgorithmAES128,
                                          0x0000,
                                          [key UTF8String],
                                          kCCBlockSizeAES128,
                                          [key UTF8String],
                                          [data bytes],
                                          dataLength,
                                          buffer,
                                          bufferSize,
                                          &numBytesCrypted);
    if (cryptStatus == kCCSuccess) {
        NSData *resultData = [NSData dataWithBytesNoCopy:buffer length:numBytesCrypted];
        
        NSString *decoded=[[NSString alloc] initWithData:resultData encoding:NSUTF8StringEncoding];
        return [self processDecodedString:decoded];
    }
    
    free(buffer);
    return nil;
    
}

+(NSString *)processDecodedString:(NSString *)decoded
{
    if( decoded==nil || decoded.length==0 ){
        return nil;
    }
    const char *tmpStr=[decoded UTF8String];
    int i=0;
    
    while( tmpStr[i]!='\0' )
    {
        i++;
    }
    NSString *final=[[NSString alloc]initWithBytes:tmpStr length:i encoding:NSUTF8StringEncoding];
    return final;
}

+(NSData *)AES128Encrypt:(NSData *)data withKey:(NSString *)key
{
    if( ![self validKey:key] ){
        return nil;
    }
    
    char keyPtr[kCCKeySizeAES128+1];
    memset(keyPtr, 0, sizeof(keyPtr));
    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    
    
    char ivPtr[kCCBlockSizeAES128+1];
    memset(ivPtr, 0, sizeof(ivPtr));
    [key getCString:ivPtr maxLength:sizeof(ivPtr) encoding:NSUTF8StringEncoding];
    
    NSUInteger dataLength = [data length];
    
    int diff = kCCKeySizeAES128 - (dataLength % kCCKeySizeAES128);
    unsigned long newSize = 0;
    
    if(diff > 0)
    {
        newSize = dataLength + diff;
        NSLog(@"diff is %d",diff);
    }
    
    char dataPtr[newSize];
    memcpy(dataPtr, [data bytes], [data length]);
    for(int i = 0; i < diff; i++)
    {
        dataPtr[i + dataLength] =0x0000;
    }
    
    size_t bufferSize = newSize + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    memset(buffer, 0, bufferSize);
    
    size_t numBytesCrypted = 0;
    
    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt,
                                          kCCAlgorithmAES128,
                                          0x0000,
                                          [key UTF8String],
                                          kCCKeySizeAES128,
                                          [key UTF8String],
                                          dataPtr,
                                          sizeof(dataPtr),
                                          buffer,
                                          bufferSize,
                                          &numBytesCrypted);
    
    if (cryptStatus == kCCSuccess) {
        return [NSData dataWithBytesNoCopy:buffer length:numBytesCrypted];
    }
    free(buffer);
    return nil;
}

+(NSData *)AES256Encrypt:(NSData *)data withKey:(NSString *)key
{
    if( ![self valid256Key:key] ){
        return nil;
    }
    
    char keyPtr[kCCKeySizeAES128+1];
    memset(keyPtr, 0, sizeof(keyPtr));
    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    
    
    char ivPtr[kCCBlockSizeAES128+1];
    memset(ivPtr, 0, sizeof(ivPtr));
    [key getCString:ivPtr maxLength:sizeof(ivPtr) encoding:NSUTF8StringEncoding];
    
    NSUInteger dataLength = [data length];
    
    int diff = kCCKeySizeAES128 - (dataLength % kCCKeySizeAES128);
    unsigned long newSize = 0;
    
    if(diff > 0)
    {
        newSize = dataLength + diff;
        NSLog(@"diff is %d",diff);
    }
    
    char dataPtr[newSize];
    memcpy(dataPtr, [data bytes], [data length]);
    for(int i = 0; i < diff; i++)
    {
        dataPtr[i + dataLength] =0x0000;
    }
    
    size_t bufferSize = newSize + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    memset(buffer, 0, bufferSize);
    
    size_t numBytesCrypted = 0;
    
    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt,
                                          kCCAlgorithmAES128,
                                          0x0002,
                                          [key UTF8String],
                                          kCCKeySizeAES256,
                                          [key UTF8String],
                                          dataPtr,
                                          sizeof(dataPtr),
                                          buffer,
                                          bufferSize,
                                          &numBytesCrypted);
    
    if (cryptStatus == kCCSuccess) {
        return [NSData dataWithBytesNoCopy:buffer length:numBytesCrypted];
    }
    free(buffer);
    return nil;
}

@end