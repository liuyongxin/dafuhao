//
//  LotteryView.m
//  大富豪
//
//  Created by Louis on 2016/11/2.
//  Copyright © 2016年 Louis. All rights reserved.
//

#import "LotteryView.h"

@interface LotteryView()

@property(nonatomic,retain)UIImageView *bgImageView;
@property(nonatomic,retain)UIImageView *lotteryImageView;

@end

@implementation LotteryView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _bgImageView = [[UIImageView alloc]initWithFrame:self.bounds];
        _bgImageView.image = [UIImage imageNamed:@"LotteryBg.png" bundle:DFHImageResourceBundle_Main];
        [self addSubview:_bgImageView];
    }
    return self;
}

- (UIImageView *)lotteryImageView
{
    if (!_lotteryImageView) {
        CGFloat space = 3;
        _lotteryImageView = [[UIImageView alloc]initWithFrame:CGRectMake(space, space, _bgImageView.frame.size.width - 2*space, _bgImageView.frame.size.height - 2*space)];
        [_bgImageView addSubview:_lotteryImageView];
    }
    return _lotteryImageView;
}


@end
