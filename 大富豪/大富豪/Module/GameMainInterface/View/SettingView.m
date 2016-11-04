//
//  SettingView.m
//  大富豪
//
//  Created by Louis on 2016/11/2.
//  Copyright © 2016年 Louis. All rights reserved.
//

#import "SettingView.h"

@interface SettingView()<UIAlertViewDelegate,CAAnimationDelegate>

@property(nonatomic,assign)BOOL isShow;
@property(nonatomic,retain)UIImageView *backgroundView; //背景图
@property(nonatomic,retain)UIView *alertView;

@end

@implementation SettingView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.frame = CGRectMake(0, 0, DFHScreenW, DFHScreenH);
        UIView *view = [[UIView alloc]initWithFrame:self.frame];
        view.backgroundColor = [UIColor whiteColor];
        view.alpha = 0.5;
        [self addSubview:view];
        [self configUI];
    }
    return self;
}

- (void)configUI
{
    CGFloat bgWidth = 377;
    CGFloat bgHeight = 196.5;
    _alertView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, bgWidth, bgHeight)];
    _alertView.center = self.center;
    [self addSubview:_alertView];
    _backgroundView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, bgWidth, bgHeight)];
    _backgroundView.userInteractionEnabled = YES;
    _backgroundView.image = [UIImage imageNamed:@"Main_Setting_Bg.png" bundle:DFHImageResourceBundle_Main_Setting];
    [_alertView addSubview:_backgroundView];
    //270,110

    CGFloat space = 10;
    CGFloat btnWidth = 115;
    CGFloat btnHeight = 32;
    CGFloat xStart =  (bgWidth-btnWidth*2 - space)/2;
    CGFloat yStart =  (bgHeight - btnHeight *3 - 2*space)/2;
    CGFloat xAxis = xStart;
    CGFloat yAxis = yStart;
    NSArray *imagesNormalStr = @[@"Main_Setting_001.png",@"Main_Setting_002.png",@"Main_Setting_003.png",@"Main_Setting_004.png",@"Main_Setting_NormalCancel.png"];
    NSArray *imagesSelectedStr = @[@"Main_Setting_008.png",@"Main_Setting_007.png",@"Main_Setting_006.png",@"Main_Setting_005.png",@"Main_Setting_SelectedCancel.png"];
    for (int i = 0; i < 5; i++) {
        xAxis = xStart + (i%2)*(btnWidth + space);
        yAxis = yStart +(i/2)*(btnHeight + space);
        if (i ==4) {
            xAxis += (btnWidth + space);
        }
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.tag = 100+i;
        btn.frame = CGRectMake(xAxis, yAxis, btnWidth, btnHeight);
        [btn setBackgroundImage:[UIImage imageNamed:imagesNormalStr[i] bundle:DFHImageResourceBundle_Main_Setting] forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageNamed:imagesSelectedStr[i] bundle:DFHImageResourceBundle_Main_Setting] forState:UIControlStateSelected];
        [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
        [_alertView addSubview:btn];
    }
}

- (void)btnAction:(UIButton *)btn
{
    if (btn.tag == 100) {  //游戏设定
    }
    else if (btn.tag == 101) //游戏说明
    {
    }
    else if (btn.tag == 102) //加退通知
    {
    }
    else if (btn.tag == 103)//退出游戏
    {
    }
    else if (btn.tag == 104)//取消
    {
        [self dismiss:YES];
    }

}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    UITouch *touch = [event.allTouches anyObject];
    CGPoint point  = [touch locationInView:_selfSuperView];
    if (self.isShow && !CGRectContainsPoint(self.alertView.frame, point))
    {
        if (_touchDismissAction!=nil) {
            _touchDismissAction();
        }
        [self dismiss:NO];
    }
}

- (void)showInSuperView:(UIView *)view targetView:(UIView *)targetView animated:(BOOL)animated
{
    self.selfTargetView = targetView;
    self.selfSuperView = view;

    [self.selfSuperView addSubview:self];
    if (animated) {
        [self showAnimation];
    }
    else
    {
        self.isShow = YES;
    }
}

- (void)showAnimation  //仿UIAlertView动画效果
{
    CAKeyframeAnimation *popAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    popAnimation.duration = 0.4;
    popAnimation.delegate=self;
    popAnimation.removedOnCompletion = NO;
    popAnimation.values = @[[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.01f, 0.01f, 1.0f)],
                            [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.1f, 1.1f, 1.0f)],
                            [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.9f, 0.9f, 1.0f)],
                            [NSValue valueWithCATransform3D:CATransform3DIdentity]];
    popAnimation.keyTimes = @[@0.0f, @0.5f, @0.75f, @1.0f];
    popAnimation.timingFunctions = @[[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                                     [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                                     [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    [self.alertView.layer addAnimation:popAnimation forKey:@"showAnimation"];
}

- (void)dismiss:(BOOL)animation
{
    if (animation) {
        [self dismissAnimation];
    }
    else
    {
        self.isShow = NO;
        [self removeFromSuperview];
    }
}

- (void)dismissAnimation
{
    CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    scaleAnimation.fromValue = [NSNumber numberWithFloat:1.0];
    scaleAnimation.toValue = [NSNumber numberWithFloat:0];
    scaleAnimation.fillMode = kCAFillModeForwards;
    //    scaleAnimation.fillMode = kCAFillModeRemoved;
    scaleAnimation.duration = 0.1;
    scaleAnimation.delegate = self;
    scaleAnimation.removedOnCompletion = NO;
    [self.alertView.layer addAnimation:scaleAnimation forKey:@"scaleAnimation"];
}

-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag //动画代理
{
    if(anim ==[self.alertView.layer animationForKey:@"scaleAnimation"])
    {
        [self.alertView.layer removeAnimationForKey:@"scaleAnimation"];
        self.isShow = NO;
        [self removeFromSuperview];
    }
    else if (anim == [self.alertView.layer animationForKey:@"showAnimation"])
    {
        [self.alertView.layer removeAnimationForKey:@"showAnimation"];
        self.isShow = YES;
    }
}

@end
