//
//  RecordView.m
//  大富豪
//
//  Created by Louis on 2016/11/2.
//  Copyright © 2016年 Louis. All rights reserved.
//

#import "RecordView.h"

@interface RecordView()

@property(nonatomic,retain)UIImageView *bgImageView;
@property(nonatomic,retain)UIScrollView *scrollView;

@end

@implementation RecordView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _bgImageView = [[UIImageView alloc]initWithFrame:self.bounds];
        _bgImageView.image = [UIImage imageNamed:@"RecordBg.png" bundle:DFHImageResourceBundle_Main];
        _bgImageView.userInteractionEnabled = YES;
        [self addSubview:_bgImageView];
    }
    return self;
}

@end
