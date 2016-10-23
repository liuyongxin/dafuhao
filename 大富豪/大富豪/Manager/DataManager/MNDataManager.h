//
//  MNDataManager.h
//  大富豪
//
//  Created by Louis on 16/6/23.
//  Copyright © 2016年 大富豪. All rights reserved.
//

#define MNSharedDataManager [MNDataManager sharedInstance]   

#import <Foundation/Foundation.h>
#import "MNDataDefine.h"

@interface MNDataManager : NSObject

@property(nonatomic,retain)MNAccountInfo *accountInfo;  //账户登录信息
@property(nonatomic,retain)MNLoginInfo   *loginInfo;    //账户登录返回信息
@property (assign,nonatomic) BOOL isLogin; // 是否登录

+ (MNDataManager *)sharedInstance;

@end
