//
//  LotteryView.h
//  大富豪
//
//  Created by Louis on 2016/11/2.
//  Copyright © 2016年 Louis. All rights reserved.
//
//开奖视图
typedef NS_ENUM(NSInteger,LotteryType)
{
    LotteryTypeNone = -1,
    LotteryTypeDefualt = 0,
    LotteryTypeColor
};
#import <UIKit/UIKit.h>

@interface LotteryView : UIView

@property(nonatomic,assign)LotteryType type;

- (void)assignmentColour:(NSString *)colour number:(NSString *)number;   //赋值花色

@end
