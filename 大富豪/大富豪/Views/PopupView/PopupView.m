
#import "PopupView.h"

@interface PopupView ()<CAAnimationDelegate>

@property(nonatomic,copy)NSString *titleStr;
@property(nonatomic,retain)UIImage *iconImage;
@property(nonatomic,retain)NSAttributedString *descriptionAttrStr;
@property(nonatomic,retain)UIView *alertView;
@property(nonatomic,retain)UIImageView *mainBgView;
@property(nonatomic,retain)UIImageView *alertBgView;
@property(nonatomic,retain)UIActivityIndicatorView *activityIndicator;

@end

@implementation PopupView

-(void)setPopupViewbgColor:(UIColor *)popupViewbgColor
{
    if (_alertView) {
        _alertView.backgroundColor = popupViewbgColor;
    }
}

 - (void)setPopupViewbgImage:(UIImage *)popupViewbgImage
{
    if (_alertBgView) {
        _alertBgView.image = popupViewbgImage;
    }
}

- (instancetype)initWithTitle:(NSString *)titleStr icon:(UIImage *)iconImage description:(NSAttributedString *)descriptionAttrStr
{
    self = [super init];
    if (self) {
        self.isCanTouchDismiss = YES;
        self.titleStr = titleStr;
        self.iconImage = iconImage;
        self.descriptionAttrStr = descriptionAttrStr;
        self.autoDismissInterval = 5.0f;
    }
    return self;
}

- (void)showInView:(UIView *)view targetView:(UIView *)targetView animated:(BOOL)animated
{
    _selfTargetView = targetView;
    _selfSuperView = view;
    [self configUI];
    [_selfSuperView addSubview:self];
    [_activityIndicator startAnimating];
    if (animated) {
        [self showAnimation];
    }
    else
    {
        _isShow = YES;
    }
    [self performSelector:@selector(autoDismiss) withObject:nil afterDelay:5.0f];
}

- (void)configUI
{
    self.backgroundColor = [UIColor clearColor];
    self.frame = _selfSuperView.bounds;
    _mainBgView  = [[UIImageView alloc]initWithFrame:_selfSuperView.bounds];
    _mainBgView.backgroundColor = [UIColor blackColor];
    _mainBgView.userInteractionEnabled = YES;
    _mainBgView.alpha = 0.3;
    [self addSubview:_mainBgView];
    if (!_alertView) {
        _alertView = [self createAlertView];
    }
    _alertView.center = self.center;
    [self addSubview:_alertView];
}

- (UIView *)createAlertView
{
    UIView *alertView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 280, 170)];
    alertView.backgroundColor = [UIColor clearColor];
    _alertBgView = [[UIImageView alloc]initWithFrame:alertView.bounds];
    _alertBgView.userInteractionEnabled = YES;
    _alertBgView.backgroundColor = [UIColor whiteColor];
    _alertBgView.layer.cornerRadius = 5;
    _alertBgView.layer.masksToBounds = YES;
    [alertView addSubview:_alertBgView];
    
    CGFloat space = 10;
    CGFloat yAxis = space;
    CGSize size = alertView.frame.size;
    if(_titleStr)
    {
        CGFloat xAxis = space;
        _activityIndicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        _activityIndicator.frame = CGRectMake(xAxis, yAxis, 30, 30);
        [alertView addSubview:_activityIndicator];
        xAxis += 30 + space;
        UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(xAxis,yAxis, size.width - xAxis*2, 30)];
        titleLabel.text = _titleStr;
        titleLabel.textColor = [UIColor blackColor];
        titleLabel.adjustsFontSizeToFitWidth = YES;
        titleLabel.textAlignment = NSTextAlignmentCenter;
        [alertView addSubview:titleLabel];
        yAxis += 30 + space;
    }
    if(_iconImage){
        UIImageView *iconImageView = [[UIImageView alloc]initWithFrame:CGRectMake((size.width - 50)/2, yAxis, 50, 50)];
        iconImageView.userInteractionEnabled = YES;
        iconImageView.image = _iconImage;
        [alertView addSubview:iconImageView];
        yAxis += 50 + space;
    }
    if (_descriptionAttrStr) {
        UITextView *desTextView = [[UITextView alloc]initWithFrame:CGRectMake(space, yAxis, size.width - space*2, 50)];
        desTextView.textAlignment = NSTextAlignmentCenter;
        desTextView.editable = NO;
        desTextView.attributedText = _descriptionAttrStr;
        [alertView addSubview:desTextView];
        yAxis += 50 + space;
    }
    alertView.frame = CGRectMake(0, 0, 280, yAxis);
    _alertBgView.frame = alertView.bounds;
    return alertView;
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
    [_activityIndicator stopAnimating];
    if (animation) {
        [self dismissAnimation];
    }
    else
    {
        _isShow = NO;
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
        _isShow = NO;
        [self removeFromSuperview];
    }
    else if (anim == [self.alertView.layer animationForKey:@"showAnimation"])
    {
        [self.alertView.layer removeAnimationForKey:@"showAnimation"];
        _isShow = YES;
    }
}

- (void)closeBtnAction:(UIButton *)btn
{
    [self dismiss:NO];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    UITouch *touch = [event.allTouches anyObject];
    CGPoint point  = [touch locationInView:_selfSuperView];
    if (self.isCanTouchDismiss) {
        if (self.isShow && !CGRectContainsPoint(self.alertView.frame, point))
        {
            [self dismiss:NO];
        }
    }
}

- (void)autoDismiss
{
   [self dismiss:NO];
}

//移除perform
-(void)removeFromSuperview
{
    [super removeFromSuperview];
    [[self class] cancelPreviousPerformRequestsWithTarget:self selector:@selector(autoDismiss) object:nil];
}

+(PopupView *)showDefaultInView:(UIView *)view targetView:(UIView *)targetView animated:(BOOL)animated
{
    PopupView *popupView = [[PopupView alloc]initWithTitle:@"正在加载中....." icon:nil description:nil];
    [popupView showInView:view targetView:targetView animated:animated];
    [popupView performSelector:@selector(autoDismiss) withObject:nil afterDelay:popupView.autoDismissInterval];
    return popupView;
}

@end
