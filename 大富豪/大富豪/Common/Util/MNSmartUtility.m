//
//  MNSmartUtility.m
//  大富豪
//
//  Created by Louis on 16/7/4.
//  Copyright © 2016年 大富豪. All rights reserved.
//

#import "MNSmartUtility.h"

@implementation NSObject (Trace)

-(NSString*)toValidString
{
    if ([self isValidString]) {
        return (NSString*)self;
    }else{
        return @"";
    }
}

-(BOOL)isValidString
{
    if (self) {
        if ([self isKindOfClass:[NSString class]]) {
            return [(NSString*) self length]>0;
        }
    }
    return NO;
}

-(BOOL)isValidArray
{
    if (self) {
        if ([self isKindOfClass:[NSArray class]]) {
            return [(NSArray*) self count]>0;
        }
    }
    return NO;
}

-(BOOL)isValidDictionary
{
    if (self) {
        if ([self isKindOfClass:[NSDictionary class]]) {
            return [(NSDictionary*) self count]>0;
        }
    }
    return NO;
}

@end
