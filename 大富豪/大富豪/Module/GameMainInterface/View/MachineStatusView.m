//
//  MachineStatusView.m
//  大富豪
//
//  Created by Louis on 2016/11/2.
//  Copyright © 2016年 Louis. All rights reserved.
//

#import "MachineStatusView.h"

@interface MachineStatusView()

@property(nonatomic,retain)UIImageView *bgImageView;
@property(nonatomic,retain)UILabel *limitRedLabel;
@property(nonatomic,retain)UILabel *machineNameLabel;
@property(nonatomic,retain)UILabel *playerTypeLabel;


@end

@implementation MachineStatusView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _bgImageView = [[ UIImageView alloc]initWithFrame:self.bounds];
        _bgImageView.image = [UIImage imageNamed:@"Main_Text_Bg.png" bundle:DFHImageResourceBundle_Main_Text];
        _bgImageView.userInteractionEnabled = YES;
        [self addSubview:_bgImageView];
        UIImageView *lxImageView = [[UIImageView alloc]initWithFrame:CGRectMake((self.frame.size.width - 24)/2, (self.frame.size.height - 20)/2, 24, 20)];
        lxImageView.image = [UIImage imageNamed:@"Main_Text_LX.png" bundle:DFHImageResourceBundle_Main_Inning];
        [_bgImageView addSubview:lxImageView];
    }
    return self;
}

- (UILabel *)limitRedLabel
{
    if (!_limitRedLabel) {
        _limitRedLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 0, 0)];
        _limitRedLabel.textAlignment = NSTextAlignmentLeft;
        _limitRedLabel.textColor = [UIColor redColor];
        _limitRedLabel.text = @"限红: 厦门3000";
        _limitRedLabel.adjustsFontSizeToFitWidth = YES;
        [_bgImageView addSubview:_limitRedLabel];
    }
    return _limitRedLabel;
}

-(UILabel *)machineNameLabel
{
    if (!_machineNameLabel) {
        _machineNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 0, 0)];
        _machineNameLabel.textAlignment = NSTextAlignmentCenter;
        _machineNameLabel.textColor = [UIColor redColor];
        _machineNameLabel.text = @"威尼斯2";
        _machineNameLabel.adjustsFontSizeToFitWidth = YES;
        [_bgImageView addSubview:_machineNameLabel];
    }
    return _machineNameLabel;
}

-(UILabel *)playerTypeLabel
{
    if (!_playerTypeLabel) {
        _playerTypeLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 0, 0)];
        _playerTypeLabel.textAlignment = NSTextAlignmentLeft;
        _playerTypeLabel.textColor = [UIColor redColor];
        _playerTypeLabel.text = @"体验玩家";
        _playerTypeLabel.adjustsFontSizeToFitWidth = YES;
        [_bgImageView addSubview:_playerTypeLabel];
    }
    return _playerTypeLabel;
}
@end
