//
//  DFHRegisterViewController.h
//  大富豪
//
//  Created by Louis on 2016/10/25.
//  Copyright © 2016年 Louis. All rights reserved.
//
//注册登录界面
typedef NS_ENUM(NSInteger,ListType)
{
    LoginListType = 1, //登录
    RegisterListType   //注册
};
#import "DFHBaseViewController.h"

@interface DFHRegisterViewController : DFHBaseViewController

@property(nonatomic,assign)ListType type;

@end
