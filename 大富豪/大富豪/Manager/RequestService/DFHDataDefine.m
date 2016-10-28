//
//  DFHDataDefine.m
//  大富豪
//
//  Created by Louis on 2016/10/24.
//  Copyright © 2016年 Louis. All rights reserved.
//

#import "DFHDataDefine.h"
@implementation DFHBaseInfo

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{

}

@end

@implementation DFHAccountInfo


@end

@implementation DFHLoginInfo


+ (DFHLoginInfo *)analyticalDataWithDictionary:(NSDictionary *)dic {
    DFHLoginInfo *loginInfo = [[DFHLoginInfo alloc]init];
    [loginInfo setValuesForKeysWithDictionary:dic];
    return loginInfo;
}

@end
