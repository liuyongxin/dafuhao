//
//  DFHResponsePackageDataDefine.m
//  大富豪
//
//  Created by Louis on 2016/10/24.
//  Copyright © 2016年 Louis. All rights reserved.
//

#import "DFHResponsePackageDataDefine.h"
#import "JSONFormatFunc.h"

@implementation DFHResponsePackageDataBase
- (ResponsePackageType)parseFromData:(NSData *)data
{
    [NSException raise:NSInternalInconsistencyException format:@"在%@的子类中必须override:%@方法", [NSString stringWithUTF8String:object_getClassName(self)], NSStringFromSelector(_cmd)];
    
    return ResponsePackageParserFailed;
}

// 解析出错信息
- (void)parseErrorDictFromData:(NSData *)data
{
    
}

@end

@implementation CosPassportClogin

- (ResponsePackageType)parseFromData:(NSData *)data
{
    NSError *error = nil;
    id jsonData = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&error];
    if (!error) {
        if ([jsonData isKindOfClass:[NSDictionary class]]) {
        }
    }
    else
    {
        //        self.errorMessage = error.userInfo;
    }
    return ResponsePackageSuccess;
}
@end
