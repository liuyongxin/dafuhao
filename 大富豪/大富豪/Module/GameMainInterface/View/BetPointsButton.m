//
//  BetPointsButton.m
//  大富豪
//
//  Created by louis on 2016/11/5.
//  Copyright © 2016年 Louis. All rights reserved.
//

#import "BetPointsButton.h"

@interface BetPointsButton ()

@property(nonatomic,retain)UILabel *titleOneLabel;
@property(nonatomic,retain)UILabel *titleTwoLabel;

@end

@implementation BetPointsButton

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        CGSize size = self.frame.size;
        self.titleOneLabel.frame = CGRectMake(size.width/6,size.height/10,2*size.width/3,size.height/5);
        self.titleTwoLabel.frame = CGRectMake(3*size.width/7,3*size.height/7, 10*size.width/21, size.height/5);
    }
    return self;
}

- (UILabel *)titleOneLabel
{
    if (!_titleOneLabel) {
        _titleOneLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        _titleOneLabel.adjustsFontSizeToFitWidth = YES;
        _titleOneLabel.font = [UIFont systemFontOfSize:13];
        _titleOneLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_titleOneLabel];
    }
    return _titleOneLabel;
}

- (UILabel *)titleTwoLabel
{
    if (!_titleTwoLabel) {
        _titleTwoLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        _titleTwoLabel.adjustsFontSizeToFitWidth =YES;
        _titleTwoLabel.font = [UIFont systemFontOfSize:13];
        _titleTwoLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_titleTwoLabel];
    }
    return _titleTwoLabel;
}
- (void)assignmentTitleOneLabel
{

}
@end
