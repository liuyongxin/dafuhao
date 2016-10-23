//
//  AESCrypt.h
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

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonCrypto.h>
#import "NSData+Base64.h"
#import "NSString+Base64.h"


@interface AESCrypt : NSObject

+ (NSString *)generate32ByteAESKey;     // 生成32字节AES密钥匙，密钥字符范围[0~9],[a~z],[A~Z]
+ (NSData *)encryptData:(NSString *)message password:(NSString *)password;
+ (NSData *)encryptDataWithByteKey:(NSString *)message password:(const void *)password;
+ (NSData *)encryptByteData:(NSData *)data password:(NSString *)password;
+ (NSData *)encryptByteDataWithByteKey:(NSData *)data password:(const void *)password;
+ (NSData *)encryptByteDataWithByteKey:(NSData *)data password:(const void *)password paddingMode:(NSInteger)paddingMode;
+ (NSString *)encrypt:(NSString *)message password:(NSString *)password;
+ (NSString *)encryptWithByteData:(NSData *)data password:(NSString *)password;
+ (NSString *)encryptWithByteKey:(NSString *)message password:(const void *)password;
+ (NSString *)decrypt:(NSString *)base64EncodedString password:(NSString *)password;
+ (NSString *)decryptWithByteKey:(NSString *)base64EncodedString password:(const void *)password;
+ (NSData *)decryptData:(NSData *)data password:(NSString *)password;
+ (NSData *)decryptDataWithByteKey:(NSData *)data password:(const void *)password;
+ (NSData *)decryptDataWithByteKey:(NSData *)data password:(const void *)password paddingMode:(NSInteger)paddingMode;

/**************************************************************************
 FunctionName:  encryptByteDataWithByteKey
 FunctionDesc:  AES数据加密
 Parameters:
 Param1Name:    data:NSData
 Param1Desc:    源数据
 Param2Name:    password:const void *
 Param2Desc:    AES密钥
 Param3Name:    paddingMode:NSInteger
 Param3Desc:
 Param4Name:    keyBitType:NSInteger
 Param4Desc:    AES128位、AES192位或AES256位加密算法, 取值如下:
 (kCCKeySizeAES128          = 16,
 kCCKeySizeAES192          = 24,
 kCCKeySizeAES256          = 32,)
 ReturnVal:     NSData (AES加密后的数据)
 **************************************************************************/
+ (NSData *)encryptByteDataWithByteKey:(NSData *)data password:(const void *)password paddingMode:(NSInteger)paddingMode keyBitType:(NSInteger)keyBitType;

/**************************************************************************
 FunctionName:  decryptDataWithByteKey
 FunctionDesc:  AES数据解密
 Parameters:
 Param1Name:    data:NSData
 Param1Desc:    AES密文
 Param2Name:    password:const void *
 Param2Desc:    AES密钥
 Param3Name:    paddingMode:NSInteger
 Param3Desc:
 Param4Name:    keyBitType:NSInteger
 Param4Desc:    AES128位、AES192位或AES256位加密算法, 取值如下:
 (kCCKeySizeAES128          = 16,
 kCCKeySizeAES192          = 24,
 kCCKeySizeAES256          = 32,)
 ReturnVal:     NSData (AES解密后的数据)
 **************************************************************************/
+ (NSData *)decryptDataWithByteKey:(NSData *)data password:(const void *)password paddingMode:(NSInteger)paddingMode keyBitType:(NSInteger)keyBitType;

+(NSData *)AES128Encrypt:(NSData *)data withKey:(NSString *)key;
+(NSData *)AES256Encrypt:(NSData *)data withKey:(NSString *)key;
+(NSString *)AES128Decrypt:(NSData *)data withKey:(NSString *)key;

@end