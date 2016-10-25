//
//  MNUtil.h
//  大富豪
//
//  Created by Louis on 16/6/22.
//  Copyright © 2016年 大富豪. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface JSONFormatFunc : NSObject
// 格式化json字段的值
+ (NSString *)formatJsonValue:(id)value;
+ (NSString *)strValueForKey:(id)key ofDict:(NSDictionary *)dict;
+ (NSNumber *)numberValueForKey:(id)key ofDict:(NSDictionary *)dict;
+ (NSArray *)arrayValueForKey:(id)key ofDict:(NSDictionary *)dict;
+ (NSDictionary *)dictionaryValueForKey:(id)key ofDict:(NSDictionary *)dict;

// 把应答数据解析成字典
+ (NSDictionary *)parseToDict:(NSString *)jsonStr;
+ (NSDictionary *)parseDataToDict:(NSData *)jsonData;
// 把应答数据解析成列表
+ (NSArray *)parseToArray:(NSString *)jsonStr;
+ (NSArray *)parseDataToArray:(NSData *)jsonData;

// 解析json为对象
+ (id)jsonObjectFromData:(NSData *)data error:(NSError **)err;
+ (id)jsonObjectFromDataWithOption:(NSData *)data options:(NSJSONReadingOptions)option error:(NSError **)err;
+ (id)jsonObjectFromString:(NSString *)str error:(NSError **)err;
+ (id)jsonObjectFromStringWithOption:(NSString *)data options:(NSJSONReadingOptions)option error:(NSError **)err;

//从文件解析数据到json对象
+ (id)jsonObjectFromFilePath:(NSString *)filePath error:(NSError **)err;

//把对象编码成json格式数据
+ (NSData *)dataFromjsonObject:(id)obj error:(NSError **)err;
+ (NSData *)dataFromjsonObjectWithOption:(id)obj options:(NSJSONWritingOptions)option error:(NSError **)err;

+ (NSString *)stringFromjsonObject:(id)obj error:(NSError **)err;
+ (NSString *)stringFromjsonObjectWithOption:(id)obj options:(NSJSONWritingOptions)option error:(NSError **)err;


+ (NSDictionary *)convertDictionary:(id)jsonObj;
+ (NSArray *)convertArray:(id)jsonObj;

+ (id)formatJsonStrData:(id)obj;
+ (NSString *)formatJsonStrWithStr:(NSString *)str;

+ (NSString *)formatJsonStrWithDictionary:(NSDictionary *)dict;
+ (NSString *)formatJsonStrWithArray:(NSArray *)array;
@end

#pragma mark Deserializing methods

@interface NSData (JSONDeserializing)
// The NSData MUST be UTF8 encoded JSON.
- (id)objectByJSONData;
- (id)objectByJSONDataWithParseOptions:(NSJSONReadingOptions)option error:(NSError **)err;
@end


////////////
#pragma mark Serializing methods
////////////

@interface NSString (JSONKitSerializing)
// Convenience methods for those that need to serialize the receiving NSString (i.e., instead of having to serialize a NSArray with a single NSString, you can "serialize to JSON" just the NSString).
// Normally, a string that is serialized to JSON has quotation marks surrounding it, which you may or may not want when serializing a single string, and can be controlled with includeQuotes:
// includeQuotes:YES `a "test"...` -> `"a \"test\"..."`
// includeQuotes:NO  `a "test"...` -> `a \"test\"...`
- (NSData *)toJSONData;     // Invokes JSONDataWithOptions:kNilOptions
- (NSData *)toJSONDataWithOptions:(NSJSONWritingOptions)opiton error:(NSError **)err;
- (NSString *)toJSONString; // Invokes JSONStringWithOptions:kNilOptions
- (NSString *)toJSONStringWithOptions:(NSJSONWritingOptions)opiton error:(NSError **)err;

@end

@interface NSArray (JSONKSerializing)
- (NSData *)toJSONData;
- (NSData *)toJSONDataWithOptions:(NSJSONWritingOptions)opiton error:(NSError **)err;
- (NSString *)toJSONString;
- (NSString *)toJSONStringWithOptions:(NSJSONWritingOptions)opiton error:(NSError **)err;
@end

@interface NSDictionary (JSONKitSerializing)
- (NSData *)toJSONData;
- (NSData *)toJSONDataWithOptions:(NSJSONWritingOptions)opiton error:(NSError **)err;
- (NSString *)toJSONString;
- (NSString *)toJSONStringWithOptions:(NSJSONWritingOptions)opiton error:(NSError **)err;
@end

