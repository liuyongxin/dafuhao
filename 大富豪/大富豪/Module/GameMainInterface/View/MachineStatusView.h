//
//  MachineStatusView.h
//  大富豪
//
//  Created by Louis on 2016/11/2.
//  Copyright © 2016年 Louis. All rights reserved.
//
//顶部机器状态视图
#import <UIKit/UIKit.h>

@interface MachineStatusView : UIView

- (void)assignmentLimitRed:(NSString *)text;
- (void)assignmentMachineName:(NSString *)text;
- (void)assignmentPlayerType:(NSString *)text;

@end
