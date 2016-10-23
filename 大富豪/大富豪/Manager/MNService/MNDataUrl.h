//
//  MNDataUrl.h
//  大富豪
//
//  Created by Louis on 16/6/22.
//  Copyright © 2016年 大富豪. All rights reserved.
//

#ifndef MNDataUrl_h
#define MNDataUrl_h

/*(0)*/
#define  MN_DataInterface_BaseURL   @"api.cos.yesbs.com:9090/yesbs-open-api/"   //数据接口统一访问测试地址 http://
/*(1)*/
#define  MN_UserInterface_BaseURL   @"api.cos.yesbs.com:9090/yesbs-open-api/passport/"  //用户类基本地址
/*(2)*/
#define  MN_ProductInterface_BaseURL   @"api.cos.yesbs.com:9090/yesbs-open-api/products/"  //产品类基本地址
/*(3)*/
#define  MN_ActivityInterface_BaseURL   @"api.cos.yesbs.com:9090/yesbs-open-api/events/"  //活动类基本地址
/*(4)*/
#define  MN_OrderInterface_BaseURL   @"api.cos.yesbs.com:9090/yesbs-open-api/orders/"  //订单类基本地址
/*(5)*/
#define  MN_CommunityInterface_BaseURL  @"api.cos.yesbs.com:9090/yesbs-open-api/community/"  //社区类基本接口


#define MN_UserRegisterPathURL @"cos.passport.reg"                  // 用户注册接口
#define MN_UserLoginURL @"cos.passport.clogin"                      // 用户登录接口
#define MN_UserLoginOutURL @"cos.passport.clogout"                  // 退出登录
#define MN_UserForgetPasswordURL @"cos.passport.reset.passkey"      // 用户重置密码
#define MN_GetVerificationCodeURL @"cos.passport.identifyingcode"   // 获取短信验证码
#define MN_UserInfoURL @"cos.passport.cinfo"                        // 用户自己信息
#define MN_UserAddNewAddressURL @"cos.passport.address.add"         // 新增地址
#define MN_UserDeleteAddressURL @"cos.passport.address.delete"      // 删除地址
#define MN_UserChangeAddressURL @"cos.passport.address.update"      // 修改（更新）地址
#define MN_UserQueryAddressURL @"cos.passport.address.get"          // 查询收货地址
#define MN_ProductsSearchURL  @"cos.products.search"                // 搜索商品接口
#define MN_OrdersSearch @"cos.orders.search"                        // 订单查询
#define MN_OrdersCartGet @"cos.orders.cart.get"                     // 单独购物车查询
#define MN_GetCartAddressURL @"cos.orders.cart"                     // 购物车数据


#define MN_InterfaceName          

#endif /* MNDataUrl_h */
