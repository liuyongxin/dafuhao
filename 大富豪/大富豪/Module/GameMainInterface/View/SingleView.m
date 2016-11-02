//
//  SingleView.m
//  大富豪
//
//  Created by Louis on 2016/11/2.
//  Copyright © 2016年 Louis. All rights reserved.
//

#import "SingleView.h"

@interface SingleView()

@property(nonatomic,retain)UIImageView *bgImageView;
@property(nonatomic,retain)UIScrollView *scrollView;

@end

@implementation SingleView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _bgImageView = [[UIImageView alloc]initWithFrame:self.bounds];
        _bgImageView.image = [UIImage imageNamed:@"SingleBg.png" bundle:DFHImageResourceBundle_Main];
        _bgImageView.userInteractionEnabled = YES;
        [self addSubview:_bgImageView];
    }
    return self;
}

@end
