//
//  MNRequestDataInterface.m
//  大富豪
//
//  Created by Louis on 16/6/20.
//  Copyright © 2016年 大富豪. All rights reserved.
//

#import "MNRequestDataInterface.h"
#import "NSString+MD5.h"
#import "MNUtil.h"

@implementation MNRequestDataInterface


+ (NSMutableDictionary *)makeRequestCosPassportClogin:(NSString *)userid passkey:(NSString *)passkey
{
    NSMutableDictionary *param = [NSMutableDictionary dictionaryWithDictionary:
                                  @{@"userid"  : userid,
                                    @"passkey" : [passkey md5Encoding],
                                    }];
    
    // 唯一能够登录的测试数据
//    NSDictionary *param = @{
//                            @"userid": @"app",
//                            @"passkey": @"7B38B662176D4511E6798C39FCB0A1AE",
//                            @"deviceid": @"A28H11253YHP",
//                            @"ip": @"186.120.1.21"
//                            };
    
    
    return [self make0ProtocolSendData:@"cos.passport.clogin" param:param rspClass:[NSObject class]];
}

#pragma mark - 产品分类接口
+ (NSMutableDictionary *)makeRequestCosProductsPsortPsid:(NSInteger)psid
{
    NSMutableDictionary *param = [NSMutableDictionary dictionaryWithDictionary:
                                  @{@"psid"  : @(psid),
                                    }];
    
    return [self makeCProtocolSendData:@"cos.products.psort.all" param:param rspClass:[NSObject class]];
}

#pragma mark - 购物车接口
+ (NSMutableDictionary *)makeRequestOrderCart
{
    NSMutableDictionary *param ;
    
    return [self makeCProtocolSendData:@"cos.orders.cart.get" param:nil rspClass:[NSObject class]];
}

+(NSMutableDictionary *)makeRequestCosEventsSpotsale:(int )pos pagesize:(int )num
{
    NSMutableDictionary *param = [NSMutableDictionary dictionaryWithDictionary:
                                  @{@"curpage"  : @(pos),
                                    @"pagesize"    : @(num)
                                    }];
    
    return [self makeCProtocolSendData:@"cos.events.spotsale" param:param rspClass:[NSObject class]];
}

+(NSMutableDictionary *)makeRequestCosEventsSpotsaleDetail:(NSString *)activityNumber
{
    NSMutableDictionary *param = [NSMutableDictionary dictionaryWithDictionary:
                                  @{@"eventcode"  : activityNumber,
                                    }];
    
    return [self makeCProtocolSendData:@"cos.events.spotsale.detail" param:param rspClass:[NSObject class]];
}

+ (NSMutableDictionary *)makeRequestCosProductsSearchWithParams:(NSDictionary *)params {
    return [self makeCProtocolSendData:MN_ProductsSearchURL param:[NSMutableDictionary dictionaryWithDictionary:params] rspClass:[NSObject class]];
}
@end
