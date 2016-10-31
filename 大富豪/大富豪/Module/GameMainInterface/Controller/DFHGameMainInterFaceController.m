//
//  DFHGameMainInterFaceController.m
//  大富豪
//
//  Created by Louis on 2016/10/28.
//  Copyright © 2016年 Louis. All rights reserved.
//

#import "DFHGameMainInterFaceController.h"
#import "VideoDisplayView.h"

@interface DFHGameMainInterFaceController ()

@property(nonatomic,retain)UIImageView *mainBGImageView;
@property(nonatomic,retain)VideoDisplayView *videoDisplayView;

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
    
    CGFloat space = 5;
    CGFloat xAxis = space;
    CGFloat yAxis = space;
    
    CGFloat VideoDisplayViewWidth = 420/4; //105
    CGFloat VideoDisplayViewHeight = 470/4; //117.5
    _videoDisplayView = [[VideoDisplayView alloc]initWithFrame:CGRectMake(xAxis, yAxis, VideoDisplayViewWidth, VideoDisplayViewHeight)];
    
    [_mainBGImageView addSubview:_videoDisplayView];
    
    yAxis += VideoDisplayViewHeight + space;
    
    
    
}

@end
