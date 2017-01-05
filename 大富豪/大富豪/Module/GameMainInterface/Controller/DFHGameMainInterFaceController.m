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
#import "PopupView.h"

@interface DFHGameMainInterFaceController ()
{
    DFHHttpRequest *_httpRequest;
    CGFloat _kickOffTime;  //开球时间
    CGFloat _betTime;       //押分时间
    CGFloat _readyTime;   //每局间隔时间
    CGFloat _spaceTime;  //每轮间隔时间
    CGFloat _showWinningInfoTime; //10秒用于展示中奖信息
    CGFloat _minimumBetPoints; //切换最小押分
}
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
@property(nonatomic,retain)PopupView *popupView;

@property(nonatomic,retain)NSTimer *getStatusTimer; //定时获取机器状态,每隔1s
@property(nonatomic,assign)long roundsNum; //轮
@property(nonatomic,assign)long boutsNum;  //局
@property(nonatomic,assign)int currentStatus;
@property(nonatomic,assign)CGFloat waitingTime;

@end

@implementation DFHGameMainInterFaceController

- (void)dealloc
{
    if ([self.getStatusTimer isValid]) {
        [self.getStatusTimer invalidate];
        self.getStatusTimer = nil;
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self prepareData];
    [self configUI];
}

- (void)prepareData
{
    _httpRequest = [[DFHHttpRequest alloc]init];
    self.getStatusTimer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(getLatestBrandRoad) userInfo:nil repeats:YES];
    self.getStatusTimer.fireDate  = [NSDate distantFuture];
    _showWinningInfoTime = 10.0f;  //展示中奖信息时间
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

    CGFloat startX = 2 * xSpace;
    CGFloat startY = 2 * ySpace;
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

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self requestHistoryBrandRoad:self.machineId];
    self.getStatusTimer.fireDate  = [NSDate distantPast];  //启动定时请求
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.getStatusTimer.fireDate = [NSDate distantFuture]; //暂停定时器
}
//获取最新牌路,每秒调用一次
- (void)getLatestBrandRoad
{
    [self requestObtainSingleCard:self.machineId rounds:@"" bouts:@""];
}

#pragma mark - request
//批量押分
- (void)requestBatchPoints:(NSString *)memberId  machineId:(NSString *)machineId rounds:(long )rounds bouts:(long)bounts betPointsField:(NSArray *)betPointsArr
{
    PopupView *pView = [[PopupView alloc]initWithTitle:@"正在押分中,请稍候...." icon:nil description:nil];
    [pView showInView:self.view targetView:nil animated:YES];
//    __weak typeof(self) weakSelf = self;
    NSString *token = [[NSString stringWithFormat:@"%@%ld%ld%@",machineId,rounds,bounts,memberId] md5String];
    NSMutableDictionary *paramDic = [NSMutableDictionary dictionary];
    [paramDic setObject:machineId forKey:@"machineId"]; //机器ID
    [paramDic setObject:@(rounds) forKey:@"rounds"]; //轮数
    [paramDic setObject:@(bounts) forKey:@"bouts"];   //局数
    [paramDic setObject:memberId forKey:@"memberId"]; //用户ID
    [paramDic setObject:token forKey:@"token"];
    [paramDic setObject:betPointsArr forKey:@"field"];
    NSString *paramString = [JSONFormatFunc formatJsonStrWithDictionary:paramDic];
    NSString *urlStr = [DFHRequestDataInterface makeRequestModifyPoints:paramString];
    [_httpRequest postWithURLString:urlStr parameters:nil success:^(id responseObject) {
       [pView dismiss:NO];
        
    } failure:^(NSError *error) {
        
    }];
}

//修改押分接口(手游版)
- (void)requestModifyPoints:(NSString *)memberId score:(NSString *)score machineId:(NSString *)machineId rounds:(NSString *)rounds bouts:(NSString *)bounts color:(NSString *)color
{
    NSString *urlStr = [DFHRequestDataInterface makeRequestModifyPoints:memberId score:score machineId:machineId rounds:rounds bouts:bounts color:color];
    [_httpRequest postWithURLString:urlStr parameters:nil success:^(id responseObject) {
        
    } failure:^(NSError *error) {
        
    }];
}

//修改盈利接口(手游版)<每局结束时调用>
 - (void)requestModifyProfit:(NSString *)memberId profit:(NSString *)profit machineId:(NSString *)machineId
{
    NSString *urlStr = [DFHRequestDataInterface makeRequestModifyProfit:memberId profit:profit machineId:machineId];
    [_httpRequest postWithURLString:urlStr parameters:nil success:^(id responseObject) {
        
    } failure:^(NSError *error) {
        
    }];
}

//获取单个牌路(请求返回为 aes 加密字符串) //每秒调用一次，用来实时获取当前牌路状态
- (void)requestObtainSingleCard:(NSString *)machineId rounds:(NSString *)rounds bouts:(NSString *)bouts
{
    NSString *urlStr = [DFHRequestDataInterface makeRequestObtainSingleCard:machineId rounds:rounds bouts:bouts];
    [_httpRequest postWithURLString:urlStr parameters:nil success:^(id responseObject) {
        
    } failure:^(NSError *error) {
        
    }];
}
//现在状态有3种：所有时间单位为秒
//1初始化（洗球中,status=1）
//等待时间是：机台设置的kickOffTime（开球时间）+20，20秒为机械运动时间（用于运行开球，运行到指定位置），之后status=2
//2.押分status=2，时间是：机台设置的betTime，之后是status=4
//3.结束status=4
//第一种情况：下一局，时间是：机台设置的20+10，20秒为机械运动时间（用于开奖），10秒用于展示中奖信息；之后再次等待机台设置的readyTime，之后再次轮回，status=1
//第二种情况：到达最大局，进入下一轮，机台设置的20+10，20秒为机械运动时间（用于开奖），10秒用于展示中奖信息；之后进入轮等待时间spaceTime，之后再次轮回，从下一轮的第一局开始，status=1
//
//注意：每轮结束（根据每轮局数gamesNum判断是否要进入下一轮），有轮间隔时间spaceTime
//时间判断：当前时间 - 最后操作时间（即每局牌路中返回的updateTime） >= 需要等待的时间
- (void)handDisplayAccordingStatus:(NSString *)status
{
    
    if ([status isEqualToString:@"1"]) { //初始化
        
    }
    else if ([status isEqualToString:@"2"]) //押分
    {
    
    }
    else if ([status isEqualToString:@"4"]) //结束
    {
        
    }
    else
    {
    
    }
}

//修改某局状态接口(请求返回为 aes 加密字符串)
 - (void)requestModifyBureauState:(NSString *)machineId rounds:(NSString *)rounds bouts:(NSString *)bouts status:(NSString *)status
{
    NSString *urlStr = [DFHRequestDataInterface makeRequestModifyBureauState:machineId rounds:rounds bouts:bouts status:status];
    [_httpRequest postWithURLString:urlStr parameters:nil success:^(id responseObject) {
        
    } failure:^(NSError *error) {
        
    }];
}

//获取历史牌路接口(请求返回为 aes 加密字符串)
- (void)requestHistoryBrandRoad:(NSString *)machineId
{
    __weak typeof(self) weakSelf = self;
    NSString *urlStr = [DFHRequestDataInterface makeRequestHistoryBrandRoad:machineId];
    [_httpRequest getWithURLString:urlStr parameters:nil success:^(id responseObject) {
        if ([responseObject isKindOfClass:[NSData class]]) {
         NSString *str = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
         NSString *jsonStr =  [AES AES128Decrypt:str key:Decryption_AESSecretKey];
         NSDictionary *dataDic = [JSONFormatFunc parseToDict:jsonStr];
         NSDictionary *subDic = [JSONFormatFunc dictionaryValueForKey:@"result" ofDict:dataDic];
         NSArray *dataArray = [JSONFormatFunc arrayValueForKey:@"historyList" ofDict:subDic];
            if ([dataArray isValidArray]) {
                [weakSelf.recordView refreshRecordData:dataArray];
            }
        }
    } failure:^(NSError *error) {
        
    }];
}

//生成牌路接口
 - (void)requestGenerateBrandRoad:(NSString *)machineId
{
    NSString *urlStr = [DFHRequestDataInterface makeRequestGenerateBrandRoad:machineId];
    [_httpRequest postWithURLString:urlStr parameters:nil success:^(id responseObject) {
        
    } failure:^(NSError *error) {
        
    }];
}

@end
