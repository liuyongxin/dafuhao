//
//  DFHDataManager.m
//  大富豪
//
//  Created by Louis on 2016/10/24.
//  Copyright © 2016年 Louis. All rights reserved.
//

#import "DFHDataManager.h"

@implementation DFHDataManager

static DFHDataManager*sharedMNDataManager = nil;
+ (DFHDataManager *)sharedMNDataManager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMNDataManager = [[DFHDataManager alloc] init];
    });
    return sharedMNDataManager;
}

+ (DFHDataManager *)sharedInstance
{
    return [self sharedMNDataManager];
}

@end
