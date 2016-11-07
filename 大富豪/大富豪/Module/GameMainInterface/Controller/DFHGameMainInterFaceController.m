//
//  DFHGameMainInterFaceController.m
//  大富豪
//
//  Created by Louis on 2016/10/28.
//  Copyright © 2016年 Louis. All rights reserved.
//

#import "DFHGameMainInterFaceController.h"
#import "VideoDisplayView.h"
#import "ScoreStatisticsView.h"
#import "RoundInningView.h"
#import "MachineStatusView.h"
#import "LotteryView.h"
#import "RecordView.h"
#import "SingleView.h"
#import "SettingView.h"
#import "BetPointsView.h"

@interface DFHGameMainInterFaceController ()

@property(nonatomic,retain)UIImageView *mainBGImageView;
@property(nonatomic,retain)UILabel *timingLabel;
@property(nonatomic,retain)VideoDisplayView *videoDisplayView;
@property(nonatomic,retain)ScoreStatisticsView *scoreStatisticsView;
@property(nonatomic,retain)RoundInningView *roundInningView;
@property(nonatomic,retain)UIButton *settingButton;
@property(nonatomic,retain)SettingView *settingView;
@property(nonatomic,retain)MachineStatusView *machineStatusView;
@property(nonatomic,retain)LotteryView *lotteryView;
@property(nonatomic,retain)RecordView *recordView;
@property(nonatomic,retain)SingleView *singleView;
@property(nonatomic,retain)BetPointsView *betPointsView;

@end

@implementation DFHGameMainInterFaceController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configUI];

}

- (void)configUI
{
    _mainBGImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, DFHScreenW, DFHScreenH)];
    _mainBGImageView.userInteractionEnabled = YES;
    _mainBGImageView.image = [UIImage imageNamed:@"MainBg.png" bundle:DFHImageResourceBundle_Main];
    [self.view addSubview:_mainBGImageView];
    
    CGFloat VideoDisplayViewWidth = 105*DFHSizeWidthRatio;
    CGFloat VideoDisplayViewHeight = 125*DFHSizeHeightRatio;
    CGFloat ScoreStatisticsViewWidth = 105*DFHSizeWidthRatio;
    CGFloat ScoreStatisticsViewHeight = 85*DFHSizeHeightRatio;
    CGFloat RoundInningViewWidth = 70*DFHSizeWidthRatio;
    CGFloat RoundInningViewHeight = 60*DFHSizeHeightRatio;
    CGFloat TimingLabelHeight = 20*DFHSizeHeightRatio;

    CGFloat MachineStatusViewWidth = 315*DFHSizeWidthRatio;
    CGFloat  MachineStatusViewHeight = 40*DFHSizeHeightRatio;
    CGFloat LotteryViewWidth = 115*DFHSizeWidthRatio;
    CGFloat  LotteryViewHeight = 185*DFHSizeHeightRatio;
    CGFloat RecordViewWidth = 195*DFHSizeWidthRatio;
    CGFloat  RecordViewHeight = 185*DFHSizeHeightRatio;
    CGFloat SingleViewWidth = 30*DFHSizeWidthRatio;
    CGFloat  SingleViewHeight = 185*DFHSizeHeightRatio;
    
    CGFloat  BetPointsViewWidth = 390*DFHSizeWidthRatio;
    CGFloat  BetPointsViewHeight = 75*DFHSizeHeightRatio;
    
    CGFloat xSpace = 5 *DFHSizeWidthRatio;
    CGFloat ySpace = 5*DFHSizeHeightRatio;

    CGFloat startX = 2 * xSpace;//(DFHScreenW - VideoDisplayViewWidth - MachineStatusViewWidth - SingleViewWidth)/2;
    CGFloat startY = 2 * ySpace;//(DFHScreenH - VideoDisplayViewHeight -ScoreStatisticsViewHeight - RoundInningViewHeight - TimingLabelHeight)/2;
    CGFloat xAxis = startX;
    CGFloat yAxis = startY;
    
    _videoDisplayView = [[VideoDisplayView alloc]initWithFrame:CGRectMake(xAxis, yAxis, VideoDisplayViewWidth, VideoDisplayViewHeight)];
    [_mainBGImageView addSubview:_videoDisplayView];
    yAxis += VideoDisplayViewHeight;
    
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(xAxis, yAxis, VideoDisplayViewWidth/2, TimingLabelHeight)];
    titleLabel.text = @"计时";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.adjustsFontSizeToFitWidth = YES;
    titleLabel.textColor = [UIColor whiteColor];
    [_mainBGImageView addSubview:titleLabel];
    _timingLabel = [[UILabel alloc]initWithFrame:CGRectMake(xAxis+VideoDisplayViewWidth/2, yAxis,VideoDisplayViewWidth/2 , TimingLabelHeight)];
    _timingLabel.adjustsFontSizeToFitWidth = YES;
    _timingLabel.textAlignment = NSTextAlignmentCenter;
    _timingLabel.text = @"0";
    _timingLabel.textColor = [UIColor whiteColor];
    [_mainBGImageView addSubview:_timingLabel];
    yAxis += TimingLabelHeight;
    
    _scoreStatisticsView = [[ScoreStatisticsView alloc]initWithFrame:CGRectMake(xAxis, yAxis, ScoreStatisticsViewWidth, ScoreStatisticsViewHeight)];
    [_mainBGImageView addSubview:_scoreStatisticsView];
    yAxis += ScoreStatisticsViewHeight + ySpace;
    _roundInningView = [[RoundInningView alloc]initWithFrame:CGRectMake(xAxis, yAxis, RoundInningViewWidth, RoundInningViewHeight)];
    [_mainBGImageView addSubview:_roundInningView];
    
    yAxis = startY;
    xAxis += VideoDisplayViewWidth;
    _machineStatusView = [[MachineStatusView alloc]initWithFrame:CGRectMake(xAxis, yAxis, MachineStatusViewWidth + xSpace, MachineStatusViewHeight)];
    [_mainBGImageView addSubview:_machineStatusView];
    
    _settingButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _settingButton.frame = CGRectMake(DFHScreenW - 35*DFHSizeMinRatio - 8*DFHSizeWidthRatio, 1, 35*DFHSizeMinRatio, 35*DFHSizeMinRatio);
    [_settingButton setBackgroundImage:[UIImage imageNamed:@"Main_Setting_Normal.png" bundle:DFHImageResourceBundle_Main_Setting] forState:UIControlStateNormal];
    [_settingButton setBackgroundImage:[UIImage imageNamed:@"Main_Setting_Selected.png" bundle:DFHImageResourceBundle_Main_Setting] forState:UIControlStateSelected];
    [_mainBGImageView addSubview:_settingButton];
    [_settingButton addTarget:self action:@selector(settingButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    _settingView = [[SettingView alloc]initWithFrame:self.view.bounds];
    
    yAxis += MachineStatusViewHeight;
    _lotteryView = [[LotteryView alloc]initWithFrame:CGRectMake(xAxis, yAxis, LotteryViewWidth, LotteryViewHeight)];
    [_mainBGImageView addSubview:_lotteryView];
    
    xAxis +=  LotteryViewWidth +xSpace;
    _recordView = [[RecordView alloc]initWithFrame:CGRectMake(xAxis, yAxis, RecordViewWidth, RecordViewHeight)];
    [_mainBGImageView addSubview:_recordView];
    
     xAxis +=  RecordViewWidth + xSpace;
    _singleView = [[SingleView alloc]initWithFrame:CGRectMake(xAxis, yAxis, SingleViewWidth, SingleViewHeight)];
    [_mainBGImageView addSubview:_singleView];
    
    yAxis +=  SingleViewHeight + ySpace;
    xAxis = startX + RoundInningViewWidth;
    _betPointsView = [[BetPointsView alloc]initWithFrame:CGRectMake(xAxis, yAxis, BetPointsViewWidth, BetPointsViewHeight)];
    [_mainBGImageView addSubview:_betPointsView];
}

- (void)settingButtonAction:(UIButton *)btn
{
    [_settingView showInSuperView:self.view targetView:nil animated:YES];
}

@end
