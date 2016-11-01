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

@interface DFHGameMainInterFaceController ()

@property(nonatomic,retain)UIImageView *mainBGImageView;
@property(nonatomic,retain)VideoDisplayView *videoDisplayView;
@property(nonatomic,retain)ScoreStatisticsView *scoreStatisticsView;
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
    
    CGFloat xSpace = 10;
    CGFloat ySpace = 10;
    CGFloat xAxis = xSpace;
    CGFloat yAxis = xSpace;
    
    CGFloat VideoDisplayViewWidth = 420/4; //105
    CGFloat VideoDisplayViewHeight = 470/4; //117.5
    _videoDisplayView = [[VideoDisplayView alloc]initWithFrame:CGRectMake(xAxis, yAxis, VideoDisplayViewWidth, VideoDisplayViewHeight)];
    [_mainBGImageView addSubview:_videoDisplayView];
    
    yAxis += VideoDisplayViewHeight + ySpace;
    
    CGFloat ScoreStatisticsViewWidth = 419/4;
    CGFloat ScoreStatisticsViewHeight = 339/4;
    _scoreStatisticsView = [[ScoreStatisticsView alloc]initWithFrame:CGRectMake(xAxis, yAxis, ScoreStatisticsViewWidth, ScoreStatisticsViewHeight)];
    [_mainBGImageView addSubview:_scoreStatisticsView];
    
       yAxis += ScoreStatisticsViewHeight + ySpace;
    
}

@end
