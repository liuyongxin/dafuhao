//
//  MNRequestDataInterface.h
//  大富豪
//
//  Created by Louis on 16/6/20.
//  Copyright © 2016年 大富豪. All rights reserved.
//

#import "MNRequestBaseInterface.h"

@interface MNRequestDataInterface : MNRequestBaseInterface


#pragma mark - 用户登录 cos_passport_clogin
/**
 *  用户登录
 *  @param userid  用户名
 *  @param passkey 用户登录密钥（md5加密）
 *  @return 拼接完成字典
 */
+ (NSMutableDictionary *)makeRequestCosPassportClogin:(NSString *)userid passkey:(NSString *)passkey;

/**
 *  购物车
 *
 *  @return 拼接
 */
+ (NSMutableDictionary *)makeRequestOrderCart;

+ (NSMutableDictionary *)makeRequestCosProductsPsortPsid:(NSInteger)psid;

/**
 *  地推活动列表接口(移动店)
 *  @param pos  当前页码
 *  @param num 每页记录数
 *  @return 拼接完成字典
 */
+(NSMutableDictionary *)makeRequestCosEventsSpotsale:(int )pos pagesize:(int )num;

/**
 *  地推活动内容接口(移动店)
 *  @param activityNumber 活动编号
 *  @return 拼接完成字典
 */
+(NSMutableDictionary *)makeRequestCosEventsSpotsaleDetail:(NSString *)activityNumber;

/**
 *  搜索商品
 *
 *  @param params 搜索需要的参数字典
 *
 *  @return 获取到的商品信息
 */
+ (NSMutableDictionary *)makeRequestCosProductsSearchWithParams:(NSDictionary *)params;

@end
