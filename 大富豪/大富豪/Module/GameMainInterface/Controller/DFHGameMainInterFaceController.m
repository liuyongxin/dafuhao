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
    
    CGFloat VideoDisplayViewWidth = 105;
    CGFloat VideoDisplayViewHeight = 117.5;
    CGFloat ScoreStatisticsViewWidth = 105;
    CGFloat ScoreStatisticsViewHeight = 85;
    CGFloat RoundInningViewWidth = 105*0.7;
    CGFloat RoundInningViewHeight = 84*0.7;

    CGFloat startY = 10;
    CGFloat startX = 10;
    CGFloat ySpace = (320 - VideoDisplayViewHeight - ScoreStatisticsViewHeight - RoundInningViewHeight - startY - 25)/4 * DFHSizeWidthRatio;
    CGFloat xAxis = startX;
    CGFloat yAxis = startY;
    
    _videoDisplayView = [[VideoDisplayView alloc]initWithFrame:CGRectMake(xAxis, yAxis, VideoDisplayViewWidth, VideoDisplayViewHeight)];
    [_mainBGImageView addSubview:_videoDisplayView];
    yAxis += VideoDisplayViewHeight + ySpace;
    
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(xAxis, yAxis, VideoDisplayViewWidth/2, 25)];
    titleLabel.text = @"计时";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.adjustsFontSizeToFitWidth = YES;
    [_mainBGImageView addSubview:titleLabel];
    _timingLabel = [[UILabel alloc]initWithFrame:CGRectMake(xAxis+VideoDisplayViewWidth/2, yAxis,VideoDisplayViewWidth/2 , 25)];
    _timingLabel.adjustsFontSizeToFitWidth = YES;
    _timingLabel.textAlignment = NSTextAlignmentCenter;
    _timingLabel.text = @"0";
    [_mainBGImageView addSubview:_timingLabel];
    yAxis += 25;
    
    _scoreStatisticsView = [[ScoreStatisticsView alloc]initWithFrame:CGRectMake(xAxis, yAxis, ScoreStatisticsViewWidth, ScoreStatisticsViewHeight)];
    [_mainBGImageView addSubview:_scoreStatisticsView];
    yAxis += ScoreStatisticsViewHeight + ySpace;
    
    _roundInningView = [[RoundInningView alloc]initWithFrame:CGRectMake(xAxis, yAxis, RoundInningViewWidth, RoundInningViewHeight)];
    [_mainBGImageView addSubview:_roundInningView];
    
    yAxis = startY;
    CGFloat MachineStatusViewWidth = 316;
    CGFloat  MachineStatusViewHeight = 30;
    CGFloat LotteryViewWidth = 115;
    CGFloat  LotteryViewHeight = 178;
    CGFloat RecordViewWidth = 192.5;
    CGFloat  RecordViewHeight = 181.75;
    CGFloat SingleViewWidth = 29.75;
    CGFloat  SingleViewHeight = 181.75;
    
    CGFloat xSpace = 10 *DFHSizeWidthRatio;
    xAxis = VideoDisplayViewWidth + xSpace;
    _machineStatusView = [[MachineStatusView alloc]initWithFrame:CGRectMake(xAxis, xSpace, MachineStatusViewWidth, MachineStatusViewHeight)];
    [_mainBGImageView addSubview:_machineStatusView];
    
    _settingButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _settingButton.frame = CGRectMake(xAxis + MachineStatusViewWidth + xSpace, 1, 31.25, 30.5);
    [_settingButton setBackgroundImage:[UIImage imageNamed:@"Main_Setting_Normal.png" bundle:DFHImageResourceBundle_Main_Setting] forState:UIControlStateNormal];
    [_settingButton setBackgroundImage:[UIImage imageNamed:@"Main_Setting_Selected.png" bundle:DFHImageResourceBundle_Main_Setting] forState:UIControlStateSelected];
    [_mainBGImageView addSubview:_settingButton];
    [_settingButton addTarget:self action:@selector(settingButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    _settingView = [[SettingView alloc]initWithFrame:self.view.bounds];
    
    yAxis += ySpace+MachineStatusViewHeight;
    _lotteryView = [[LotteryView alloc]initWithFrame:CGRectMake(xAxis, yAxis, LotteryViewWidth, LotteryViewHeight)];
    [_mainBGImageView addSubview:_lotteryView];
    
    xAxis += xSpace+LotteryViewWidth;
    _recordView = [[RecordView alloc]initWithFrame:CGRectMake(xAxis, yAxis, RecordViewWidth, RecordViewHeight)];
    [_mainBGImageView addSubview:_recordView];
    
     xAxis += xSpace+ RecordViewWidth;
    _singleView = [[SingleView alloc]initWithFrame:CGRectMake(xAxis, yAxis, SingleViewWidth, SingleViewHeight)];
    [_mainBGImageView addSubview:_singleView];
    
}


- (void)settingButtonAction:(UIButton *)btn
{
    [_settingView showInSuperView:self.view targetView:nil animated:YES];
}

@end
