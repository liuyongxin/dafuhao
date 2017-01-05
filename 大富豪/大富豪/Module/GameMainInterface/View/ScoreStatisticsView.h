//
//  ScoreStatisticsView.h
//  大富豪
//
//  Created by Louis on 2016/11/1.
//  Copyright © 2016年 Louis. All rights reserved.
//
//分数统计
#import <UIKit/UIKit.h>

@interface ScoreStatisticsView : UIView

- (void)assignmentBalance:(NSString *)text;
- (void)assignmentSignPoints:(NSString *)text;
- (void)assignmentWinPoints:(NSString *)text;
- (void)assignmentLastWinPoints:(NSString *)text;
- (void)assignmentBalance:(NSString *)balanceText signPoints:(NSString *)signPointsText winPoints:(NSString *)winPointsText lastWinPoints:(NSString *)lastWinPointsText;


@end
