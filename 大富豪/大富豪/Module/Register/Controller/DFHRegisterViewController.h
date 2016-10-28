//
//  DFHRegisterViewController.h
//  大富豪
//
//  Created by Louis on 2016/10/25.
//  Copyright © 2016年 Louis. All rights reserved.
//

typedef NS_ENUM(NSInteger,ListType)
{
    LoginListType = 1,
    RegisterListType
};
#import "DFHBaseViewController.h"

@interface DFHRegisterViewController : DFHBaseViewController

@property(nonatomic,assign)ListType type;

@end
