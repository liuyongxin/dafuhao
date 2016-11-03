//
//  VideoDisplayView.m
//  大富豪
//
//  Created by Louis on 2016/10/31.
//  Copyright © 2016年 Louis. All rights reserved.
//

#import "VideoDisplayView.h"
#import <AVFoundation/AVFoundation.h>
#import <AVKit/AVKit.h>

@interface VideoDisplayView ()

@property(nonatomic,retain)UIImageView *videoBlankImageView;
@property(nonatomic,retain)UIButton *eyeBtn;
@property(nonatomic,retain)AVPlayer *player;

@end

@implementation VideoDisplayView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.displayType = VideoDisplayTypeNone;
    }
    return self;
}

 - (void)setDisplayType:(VideoDisplayType)displayType
{
    if (_displayType != displayType) {
        _displayType = displayType;
    }
    if (displayType == VideoDisplayTypeNone) {
        self.videoBlankImageView.image = [UIImage imageNamed:@"Main_Video_NoSignal.png" bundle:DFHImageResourceBundle_Main_Video];
    }
    else if (displayType == VideoDisplayTypeDefault)
    {
        self.videoBlankImageView.image = [UIImage imageNamed:@"Main_Video_Default.png" bundle:DFHImageResourceBundle_Main_Video];
    }
    else if (displayType == VideoDisplayTypeNormal)
    {
        self.videoBlankImageView.image = [UIImage imageNamed:@"Main_Video_BlankBoxpng" bundle:DFHImageResourceBundle_Main_Video];
    }
}

- (UIImageView *)videoBlankImageView
{
    if (!_videoBlankImageView) {
        _videoBlankImageView = [[UIImageView alloc]initWithFrame:self.bounds];
        _videoBlankImageView.userInteractionEnabled = YES;
        [self addSubview:_videoBlankImageView];
        [self.eyeBtn setSelected:NO];
    }
    return _videoBlankImageView;
}

- (UIButton *)eyeBtn{
    if (!_eyeBtn) { //420,470
        CGFloat eyeBtnWidth = 30;
        CGFloat eyeBtnHeight = 31;
        _eyeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _eyeBtn.adjustsImageWhenHighlighted = NO;
        _eyeBtn.frame = CGRectMake(self.frame.size.width - eyeBtnWidth, self.frame.size.height - eyeBtnHeight, eyeBtnWidth, eyeBtnHeight);
        [_eyeBtn setBackgroundImage:[UIImage imageNamed:@"Main_Video_PurpleEye.png" bundle:DFHImageResourceBundle_Main_Video] forState:UIControlStateNormal];
        [_eyeBtn setBackgroundImage:[UIImage imageNamed:@"Main_Video_BlueEye.png" bundle:DFHImageResourceBundle_Main_Video] forState:UIControlStateSelected];
        [_eyeBtn addTarget:self action:@selector(eyeBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_eyeBtn];
    }
    return _eyeBtn;
}

 - (void)eyeBtnAction:(UIButton *)btn
{
    if (btn == _eyeBtn) {
        _eyeBtn.selected = !btn.selected;
        if (_eyeBtn.selected) {
            AVPlayerItem *item = [AVPlayerItem playerItemWithURL:[NSURL URLWithString:_playUrlStr]];
            [_player replaceCurrentItemWithPlayerItem:item];
            [_player play];
        }
        else
        {
            [_player pause];
        }
    }
}

 - (AVPlayer *)player
{
    if (!_player) {
        AVPlayerItem *item = [[AVPlayerItem alloc]initWithURL:[NSURL URLWithString:_playUrlStr]];
        _player = [[AVPlayer alloc]initWithPlayerItem:item];
        AVPlayerLayer *layer = [AVPlayerLayer playerLayerWithPlayer:_player];
        layer.frame = self.bounds;
        layer.backgroundColor = [UIColor clearColor].CGColor;
        layer.videoGravity = AVLayerVideoGravityResizeAspect;
        [self.layer addSublayer:layer];
        self.player.volume = 1.0f;
    }
    return _player;
}

- (void)setPlayUrlStr:(NSString *)playUrlStr
{
    if (_playUrlStr != playUrlStr) {
        _playUrlStr = nil;
        _playUrlStr = [playUrlStr copy];
        AVPlayerItem *item = [AVPlayerItem playerItemWithURL:[NSURL URLWithString:_playUrlStr]];
        [self.player replaceCurrentItemWithPlayerItem:item];
    }
}


@end
