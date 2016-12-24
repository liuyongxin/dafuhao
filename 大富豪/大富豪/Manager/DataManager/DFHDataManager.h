//
//  DFHDataManager.h
//  大富豪
//
//  Created by Louis on 2016/10/24.
//  Copyright © 2016年 Louis. All rights reserved.
//

#define DFHSharedDataManager [DFHDataManager sharedInstance]
#import <Foundation/Foundation.h>
#import "DFHDataDefine.h"

@interface DFHDataManager : NSObject

@property(nonatomic,retain)DFHAccountInfo *accountInfo;  //账户登录信息
@property(nonatomic,retain)DFHLoginInfo   *loginInfo;    //账户登录返回信息
@property (assign,nonatomic) BOOL isLogin; // 是否登录

+ (DFHDataManager *)sharedInstance;
- (void)logOut;


@end
