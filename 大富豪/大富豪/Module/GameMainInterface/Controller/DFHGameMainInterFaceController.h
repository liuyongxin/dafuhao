//
//  DFHGameMainInterFaceController.h
//  大富豪
//
//  Created by Louis on 2016/10/28.
//  Copyright © 2016年 Louis. All rights reserved.
//
//游戏主机面
#import "DFHBaseViewController.h"

@interface DFHGameMainInterFaceController : DFHBaseViewController

@property(nonatomic,copy)NSString *machineId;
@property(nonatomic,retain)NSDictionary *memberInfo;
@property(nonatomic,retain)NSDictionary *machinesetInfo;

@end
