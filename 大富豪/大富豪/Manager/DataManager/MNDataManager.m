//
//  MNDataManager.m
//  大富豪
//
//  Created by Louis on 16/6/23.
//  Copyright © 2016年 大富豪. All rights reserved.
//

#import "MNDataManager.h"

@implementation MNDataManager

static MNDataManager*sharedMNDataManager = nil;
+ (MNDataManager *)sharedMNDataManager {
   static dispatch_once_t onceToken;
   dispatch_once(&onceToken, ^{
         sharedMNDataManager = [[MNDataManager alloc] init];
   });
   return sharedMNDataManager;
}

+ (MNDataManager *)sharedInstance
{
   return [self sharedMNDataManager];
}

@end
