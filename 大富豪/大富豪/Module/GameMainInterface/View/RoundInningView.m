//
//  RoundInningView.m
//  大富豪
//
//  Created by Louis on 2016/11/1.
//  Copyright © 2016年 Louis. All rights reserved.
//

#import "RoundInningView.h"
@interface RoundInningView()

@property(nonatomic,retain)UIImageView *roundBgView;
@property(nonatomic,retain)UIImageView *inningBgView;

@end

@implementation RoundInningView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

- (UIImageView *)roundBgView //277,116
{
    if (!_roundBgView) {
        _roundBgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height/2)];
        _roundBgView.userInteractionEnabled = YES;
        [self addSubview:_roundBgView];
    }
    return _roundBgView;
}

- (UIImageView *)inningBgView
{
    if (!_inningBgView) {
        _inningBgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, self.frame.size.height/2, self.frame.size.width, self.frame.size.height/2)];
        _inningBgView.userInteractionEnabled = YES;
        [self addSubview:_inningBgView];
    }
    return _inningBgView;
}

@end
