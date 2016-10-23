//
//  MNSmartUtility.h
//  大富豪
//
//  Created by Louis on 16/7/4.
//  Copyright © 2016年 大富豪. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Trace)

//转成安全的数据
-(NSString*)toValidString;
//有效的字符串定义为类型是字符串并且长度>1
-(BOOL)isValidString;
//有效的数据定义为类型是数据并且长度>1
-(BOOL)isValidArray;
//有效的数据定义为字典而且长度>1
-(BOOL)isValidDictionary;

@end
