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
        [self settingNum:0 targetView:self.roundBgView];
        [self settingNum:0 targetView:self.inningBgView];
    }
    return self;
}

- (UIImageView *)roundBgView //277,116
{
    if (!_roundBgView) {
        _roundBgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height/2)];
        _roundBgView.image = [UIImage imageNamed:@"Main_Inning_Rounds.png" bundle:DFHImageResourceBundle_Main_Inning];
        _roundBgView.userInteractionEnabled = YES;
        [self addSubview:_roundBgView];
        CGFloat btnWidth = 16;
        CGFloat itemSpace = 5;
        CGFloat space = (self.frame.size.width - btnWidth*3 - itemSpace)/2;
        CGFloat xAxis = space;
        CGFloat yAxis = 7*(_roundBgView.frame.size.height - btnWidth)/9;
        for (int i = 0; i<3; i++) {
            UIButton *btn = [self createNumButtonRect:CGRectMake(xAxis, yAxis, btnWidth, btnWidth)];
            btn.tag = i+1;
            [_roundBgView addSubview:btn];
            xAxis +=itemSpace + btnWidth;
        }
    }
    return _roundBgView;
}

- (UIImageView *)inningBgView
{
    if (!_inningBgView) {
        _inningBgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, self.frame.size.height/2, self.frame.size.width, self.frame.size.height/2)];
        _inningBgView.image = [UIImage imageNamed:@"Main_Inning_Inning.png" bundle:DFHImageResourceBundle_Main_Inning];
        _inningBgView.userInteractionEnabled = YES;
        [self addSubview:_inningBgView];
        CGFloat btnWidth = 16;
        CGFloat itemSpace = 3;
        CGFloat space = (self.frame.size.width - btnWidth*3 - itemSpace)/2;
        CGFloat xAxis = space;
        CGFloat yAxis = 7*(_inningBgView.frame.size.height - btnWidth)/9;
        for (int i = 0; i<3; i++) {
            UIButton *btn = [self createNumButtonRect:CGRectMake(xAxis, yAxis, btnWidth, btnWidth)];
            btn.tag = i+1;
            [_inningBgView addSubview:btn];
            xAxis +=itemSpace + btnWidth;
        }
    }
    return _inningBgView;
}

- (void)settingNum:(NSInteger )num targetView:(UIView *)targetView
{
   UIButton *btn1 = [targetView viewWithTag:1];
   UIButton *btn2 = [targetView viewWithTag:2];
   UIButton *btn3 = [targetView viewWithTag:3];

//    NSString *numStr = [NSString stringWithFormat:@"%03d",num];
    int n = 3;
    NSString *numStr = [NSString stringWithFormat:@"%0*d",n,num];
    if (numStr.length == 3) {
        NSString *str1 = [numStr substringWithRange:NSMakeRange(0, 1)];
        [btn1 setTitle:str1 forState:UIControlStateNormal];
        NSString *str2 = [numStr substringWithRange:NSMakeRange(1, 1)];
        [btn2 setTitle:str2 forState:UIControlStateNormal];
        NSString *str3 = [numStr substringWithRange:NSMakeRange(2, 1)];
        [btn3 setTitle:str3 forState:UIControlStateNormal];
    }
    else
    {
        [btn1 setTitle:@"0" forState:UIControlStateNormal];
        [btn2 setTitle:@"0" forState:UIControlStateNormal];
        [btn3 setTitle:@"0" forState:UIControlStateNormal];
    }

}

- (UIButton *)createNumButtonRect:(CGRect )frame
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.userInteractionEnabled = NO;
    btn.frame = frame;
    [btn setBackgroundImage:[UIImage imageNamed:@"Main_Inning_NumBg.png" bundle:DFHImageResourceBundle_Main_Inning] forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont boldSystemFontOfSize:12];
    btn.titleLabel.adjustsFontSizeToFitWidth = YES;
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    return btn;
}
@end
