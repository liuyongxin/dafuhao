//
//  ScoreStatisticsView.m
//  大富豪
//
//  Created by Louis on 2016/11/1.
//  Copyright © 2016年 Louis. All rights reserved.
//

#import "ScoreStatisticsView.h"
@interface ScoreStatisticsView()

@property(nonatomic,retain)UIImageView *bgImageView;
@property(nonatomic,retain)UILabel *balanceLabel;
@property(nonatomic,retain)UILabel *signPointsLabel;
@property(nonatomic,retain)UILabel *winPointsLabel;
@property(nonatomic,retain)UILabel *lastWinPointsLabel;


@end

@implementation ScoreStatisticsView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.bgImageView.image = [UIImage imageNamed:@"Main_Balance_Bg.png" bundle:DFHImageResourceBundle_Main_Balance];
    }
    return self;
}

 -(UIImageView *)bgImageView
{
    if (!_bgImageView) {//419,104.75,339,84.75
        _bgImageView = [[UIImageView alloc]initWithFrame:self.bounds];
        _bgImageView.userInteractionEnabled = YES;
        [self addSubview:_bgImageView];
        [self configSubImageViews];
    }
    return _bgImageView;
}

- (void)configSubImageViews
{
    CGFloat width = 34.75;
    CGFloat height = 14; //.75
    CGFloat space =  5;
    CGFloat yAxis = space + 5;
    NSArray *imagesArray = @[[
                              UIImage imageNamed:@"Main_Balance_Balance.png" bundle:DFHImageResourceBundle_Main_Balance],
                             [UIImage imageNamed:@"Main_Balance_SignPoints.png" bundle:DFHImageResourceBundle_Main_Balance],
                             [UIImage imageNamed:@"Main_Balance_WinPoints.png" bundle:DFHImageResourceBundle_Main_Balance],
                             [UIImage imageNamed:@"Main_Balance_LastWinPoints.png" bundle:DFHImageResourceBundle_Main_Balance]];
    for (int i = 0; i<imagesArray.count; i++) {
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(space, yAxis, width, height)];
        imageView.userInteractionEnabled = YES;
        imageView.image = imagesArray[i];
        [_bgImageView addSubview:imageView];
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(space + width + space, yAxis,self.frame.size.width - width - 3* space, height)];
        label.adjustsFontSizeToFitWidth = YES;
        label.font = [UIFont boldSystemFontOfSize:16];
        label.textAlignment = NSTextAlignmentRight;
        label.textColor = [UIColor whiteColor];
        label.text = @"0";
        [_bgImageView addSubview:label];
        if (i == 0) {
            _balanceLabel = label;
        }
        else if (i == 1)
        {
            _signPointsLabel = label;
        }
        else if (i == 2)
        {
            _winPointsLabel = label;
        }
        else if (i == 3)
        {
            _lastWinPointsLabel = label;
        }
        yAxis += height + space;
    }

}
@end
