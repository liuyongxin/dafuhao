//
//  DFHMachineSelectionController.h
//  大富豪
//
//  Created by Louis on 2016/10/25.
//  Copyright © 2016年 Louis. All rights reserved.
//
typedef NS_ENUM(NSInteger,IntoType)
{
    MembersIntoType = 1,
    TouristsIntoType
};
#import "DFHBaseViewController.h"

@interface DFHMachineSelectionController : DFHBaseViewController

@property(nonatomic,assign)IntoType type;
@property(nonatomic,assign)NSString *code;  //邀请码

@end
