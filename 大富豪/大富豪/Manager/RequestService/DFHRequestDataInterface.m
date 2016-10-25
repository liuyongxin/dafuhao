//
//  DFHRequestDataInterface.m
//  大富豪
//
//  Created by Louis on 2016/10/24.
//  Copyright © 2016年 Louis. All rights reserved.
//

#import "DFHRequestDataInterface.h"
#import "NSString+MD5.h"
#import "DFHUtil.h"

@implementation DFHRequestDataInterface
+ (NSMutableDictionary *)makeRequestCosPassportClogin:(NSString *)userid passkey:(NSString *)passkey
{
    NSMutableDictionary *param = [NSMutableDictionary dictionaryWithDictionary:
                                  @{@"userid"  : userid,
                                    @"passkey" : [passkey md5Encoding],
                                    }];
    
    return [self make0ProtocolSendData:@"cos.passport.clogin" param:param rspClass:[NSObject class]];
}
@end
