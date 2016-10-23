//
//  MNUtil.m
//  大富豪
//
//  Created by Louis on 16/6/22.
//  Copyright © 2016年 大富豪. All rights reserved.
//

#define JSON_ENCODE NSUTF8StringEncoding
#define ToSafeStr(str) ([str length]>0?str:@"")

#import "JSONFormatFunc.h"

@implementation JSONFormatFunc

// 格式化json字段的值
+ (NSString *)formatJsonValue:(id)value
{
	if (value == [NSNull null])
		return @"";
	else if ([value isKindOfClass:[NSString class]])
		return value;
	else if ([value isKindOfClass:[NSNumber class]])
		return [(NSNumber *)value stringValue];
    else if ([value isKindOfClass:[NSArray class]])
		return [(NSArray *)value componentsJoinedByString:@","];
    
	return @"";
}

+ (NSString *)strValueForKey:(id)key ofDict:(NSDictionary *)dict
{
	return [self formatJsonValue:[dict objectForKey:key]];
}

+ (NSNumber *)numberValueForKey:(id)key ofDict:(NSDictionary *)dict
{
    NSNumber *val   = nil;
    id objVal       = [dict objectForKey:key];
    
    if (objVal && objVal != [NSNull null])
    {
        if ([objVal isKindOfClass:[NSNumber class]])
            val = objVal;
        else if ([objVal isKindOfClass:[NSString class]])
        {
            NSNumberFormatter *f = [[NSNumberFormatter alloc] init];
            val = [f numberFromString:objVal];
        }
    }
    
    return val;
}

+ (NSArray *)arrayValueForKey:(id)key ofDict:(NSDictionary *)dict
{
    id obj = [dict objectForKey:key];
    
    if ([obj isKindOfClass:[NSArray class]])
        return [NSArray arrayWithArray:obj];
    else
        return nil;
}

+ (NSDictionary *)dictionaryValueForKey:(id)key ofDict:(NSDictionary *)dict
{
    id obj = [dict objectForKey:key];
    
    if ([obj isKindOfClass:[NSDictionary class]])
        return obj;
    else
        return nil;
}

// 把应答数据解析成字典
+ (NSDictionary *)parseToDict:(NSString *)jsonStr
{
    //id jsonValue = [jsonStr objectFromJSONString];

    NSError *err = nil;
    id jsonValue = [self jsonObjectFromString:jsonStr error:&err];

	if ([jsonValue isKindOfClass:[NSDictionary class]])
		return (NSDictionary *)jsonValue;
	return nil;
}

+ (NSDictionary *)parseDataToDict:(NSData *)jsonData
{
    //id jsonValue = [jsonData objectFromJSONData];
    
    NSError *err = nil;
    id jsonValue = [self jsonObjectFromData:jsonData error:&err];

	if ([jsonValue isKindOfClass:[NSDictionary class]])
		return (NSDictionary *)jsonValue;
	return nil;
}

// 把应答数据解析成列表
+ (NSArray *)parseToArray:(NSString *)jsonStr
{
	//id jsonValue = [jsonStr objectFromJSONString];
    
    NSError *err = nil;
    id jsonValue = [self jsonObjectFromString:jsonStr error:&err];
	
	if ([jsonValue isKindOfClass:[NSArray class]])
		return (NSArray *)jsonValue;
	return nil;
}

+ (NSArray *)parseDataToArray:(NSData *)jsonData
{
    //id jsonValue = [jsonData objectFromJSONData];
    
    NSError *err = nil;
    id jsonValue = [self jsonObjectFromData:jsonData error:&err];
	
	if ([jsonValue isKindOfClass:[NSArray class]])
		return (NSArray *)jsonValue;
	return nil;
}

//把数据从json string或者data解析成对象
#pragma mark decode json
+ (id)jsonObjectFromData:(NSData *)data error:(NSError **)err
{
    return [self jsonObjectFromDataWithOption:data options:kNilOptions error:err];
}

+ (id)jsonObjectFromDataWithOption:(NSData *)data options:(NSJSONReadingOptions)option error:(NSError **)err
{
    return [NSJSONSerialization JSONObjectWithData:data options:option error:err];
}

+ (id)jsonObjectFromString:(NSString *)str error:(NSError **)err
{
    return [self jsonObjectFromStringWithOption:str options:kNilOptions error:err];
}

+ (id)jsonObjectFromStringWithOption:(NSString *)str options:(NSJSONReadingOptions)option error:(NSError **)err
{
    return [NSJSONSerialization JSONObjectWithData:[ToSafeStr(str) dataUsingEncoding:JSON_ENCODE] options:option error:err];
}

//从文件把json数据解析成对象
+ (id)jsonObjectFromFilePath:(NSString *)filePath error:(NSError **)err
{
	NSString * jsonStr = [NSString stringWithContentsOfFile:filePath encoding:JSON_ENCODE error:err];
	
//    CMLogInfo(@"---json file string is:%@", jsonStr);

	if (err != nil && *err != nil) {
		return nil;
	}
	
	if (jsonStr == nil)
		return nil;
    
    return [self jsonObjectFromString:jsonStr error:err];
}

//把数据解析成json格式
#pragma mark encode json data
+ (NSData *)dataFromjsonObject:(id)obj error:(NSError **)err
{
    return [self dataFromjsonObjectWithOption:obj options:kNilOptions error:err];
}

+ (NSData *)dataFromjsonObjectWithOption:(id)obj options:(NSJSONWritingOptions)option error:(NSError **)err;
{
    if(![NSJSONSerialization isValidJSONObject:obj])
    {
        return nil;
    }
    return [NSJSONSerialization dataWithJSONObject:obj options:option error:err];
}

+ (NSString *)stringFromjsonObject:(id)obj error:(NSError **)err
{
    return [self stringFromjsonObjectWithOption:obj options:kNilOptions error:err];

}

+ (NSString *)stringFromjsonObjectWithOption:(id)obj options:(NSJSONWritingOptions)option error:(NSError **)err
{
    if(![NSJSONSerialization isValidJSONObject:obj])
    {
        return nil;
    }
    
    NSData *data = [NSJSONSerialization dataWithJSONObject:obj options:option error:err];
    return [[NSString alloc] initWithData:data encoding:JSON_ENCODE];
}


+ (NSDictionary *)convertDictionary:(id)jsonObj
{
    NSDictionary *retDic = [jsonObj isKindOfClass:[NSDictionary class]] ? (NSDictionary *)jsonObj : nil;
    return retDic;
}

+ (NSArray *)convertArray:(id)jsonObj
{
    NSArray *retArr = [jsonObj isKindOfClass:[NSArray class]] ? (NSArray *)jsonObj : nil;
    return retArr;
}

+ (id)formatJsonStrData:(id)obj
{
//    NSString *strParameter = obj ? [NSString stringWithFormat:@"\"%@\"", obj] : @"\"\"";
    id strParameter = obj ? [NSString stringWithFormat:@"%@", obj] : [NSNull null];
    return strParameter;
}

+ (NSString *)formatJsonStrWithStr:(NSString *)str
{
    NSString *strParameter = str ? [NSString stringWithFormat:@"%@", str] : @"";
    return strParameter;
}

+ (NSString *)formatJsonStrWithDictionary:(NSDictionary *)dict
{
//    NSLog(@"%@", [dict JSONString]);
    NSString *retVal = [dict toJSONString];
//    int index = 0;
//    
//    if (dict)
//    {
//        for (NSString *keys in dict.allKeys)
//        {
//            retVal = [retVal stringByAppendingString:[NSString stringWithFormat:@"\"%@\":%@", keys, [dict objectForKey:keys]]];
//            if (index++ < [dict.allKeys count] - 1)
//                retVal = [retVal stringByAppendingString:@","];
//        }
//        
//        if ([dict.allKeys count] > 0)
//        {
//            retVal = [NSString stringWithFormat:@"{%@}", retVal];
//        }
//    }
    
    return retVal;
}

+ (NSString *)formatJsonStrWithArray:(NSArray *)array
{
    NSString *retVal = [array toJSONString];
    return retVal;
}

@end


////以下是为了适配jsonkit给string等类添加的category
////jason解码
//////////////
//#pragma mark Methods for serializing a single NSString.
//////////////
//@implementation NSString (JSONDeserializing)
//- (id)objectByJSONString{
//    return [self objectByJSONStringWithParseOptions:kNilOptions error:noErr];
//}
//- (id)objectByJSONStringWithParseOptions:(NSJSONReadingOptions)option error:(NSError **)err{
//    return [JSONFormatFunc jsonObjectFromStringWithOption:self options:option error:err];
//}
//@end

////////////
#pragma mark Deserializing methods
////////////
@implementation NSData (JSONDeserializing)
// The NSData MUST be UTF8 encoded JSON.
- (id)objectByJSONData{
    return [self objectByJSONDataWithParseOptions:kNilOptions error:noErr];
}
- (id)objectByJSONDataWithParseOptions:(NSJSONReadingOptions)option error:(NSError **)err{
    return [JSONFormatFunc jsonObjectFromDataWithOption:self options:option error:err];
}
@end

//json编码
@implementation NSString (JSONSerializing)

////////////
#pragma mark Methods for serializing a single NSString.
////////////

// Useful for those who need to serialize just a NSString.  Otherwise you would have to do something like [NSArray arrayWithObject:stringToBeJSONSerialized], serializing the array, and then chopping of the extra ^\[.*\]$ square brackets.

// NSData returning methods...
- (NSData *)toJSONData
{
    return [self toJSONDataWithOptions:kNilOptions error:noErr];
}
- (NSData *)toJSONDataWithOptions:(NSJSONWritingOptions)opiton error:(NSError **)err;
{
    return [JSONFormatFunc dataFromjsonObjectWithOption:self options:opiton error:err];
}

// NSString returning methods...

- (NSString *)toJSONString
{
    return [self toJSONStringWithOptions:kNilOptions error:noErr];
}
- (NSString *)toJSONStringWithOptions:(NSJSONWritingOptions)opiton error:(NSError **)err
{
    return [JSONFormatFunc stringFromjsonObjectWithOption:self options:opiton error:err];
}
@end

@implementation NSArray (JSONKitSerializing)

// NSData returning methods...
- (NSData *)toJSONData
{
    return [self toJSONDataWithOptions:kNilOptions error:noErr];
}
- (NSData *)toJSONDataWithOptions:(NSJSONWritingOptions)opiton error:(NSError **)err;
{
    return [JSONFormatFunc dataFromjsonObjectWithOption:self options:opiton error:err];
}

// NSString returning methods...

- (NSString *)toJSONString
{
    return [self toJSONStringWithOptions:kNilOptions error:noErr];
}
- (NSString *)toJSONStringWithOptions:(NSJSONWritingOptions)opiton error:(NSError **)err
{
    return [JSONFormatFunc stringFromjsonObjectWithOption:self options:opiton error:err];
}
@end

@implementation NSDictionary (JSONKitSerializing)

// NSData returning methods...

// NSData returning methods...
- (NSData *)toJSONData
{
    return [self toJSONDataWithOptions:kNilOptions error:noErr];
}
- (NSData *)toJSONDataWithOptions:(NSJSONWritingOptions)opiton error:(NSError **)err;
{
    return [JSONFormatFunc dataFromjsonObjectWithOption:self options:opiton error:err];
}

// NSString returning methods...

- (NSString *)toJSONString
{
    return [self toJSONStringWithOptions:kNilOptions error:noErr];
}
- (NSString *)toJSONStringWithOptions:(NSJSONWritingOptions)opiton error:(NSError **)err
{
    return [JSONFormatFunc stringFromjsonObjectWithOption:self options:opiton error:err];
}
@end

