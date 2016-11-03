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
    CGFloat width = 40;
    CGFloat height = 14;

    CGFloat xStart = 10;
    CGFloat yStart = 10;
    CGFloat xAxis = xStart;
    CGFloat yAxis = yStart;
    CGFloat space =  3;
    NSArray *imagesArray = @[@"余    额",@"本次押分",@"本次赢分",@"上次赢分"];
    for (int i = 0; i<imagesArray.count; i++) {
        xAxis = xStart;
        UILabel *view = [[UILabel alloc]initWithFrame:CGRectMake(xAxis, yAxis, width, height)];
        view.textColor = [UIColor colorWithRed:1.00 green:0.99 blue:0.25 alpha:1.00];
        view.text = imagesArray[i];
        view.adjustsFontSizeToFitWidth = YES;
        view.font = [UIFont boldSystemFontOfSize:10];
        [_bgImageView addSubview:view];
        
        xAxis += width + space;
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(xAxis, yAxis,self.frame.size.width - xAxis - 2*space, height)];
        label.adjustsFontSizeToFitWidth = YES;
        label.font = [UIFont boldSystemFontOfSize:10];
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

- (void)assignmentBalance:(NSString *)text
{
    _balanceLabel.text = text;
}
- (void)assignmentSignPoints:(NSString *)text
{
    _signPointsLabel.text = text;
}
- (void)assignmentWinPoints:(NSString *)text
{
    _winPointsLabel.text = text;
}
- (void)assignmentLastWinPoints:(NSString *)text
{
    _lastWinPointsLabel.text = text;
}
@end
