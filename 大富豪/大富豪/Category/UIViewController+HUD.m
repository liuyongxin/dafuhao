
#import "UIViewController+HUD.h"
#import "MBProgressHUD.h"
#import <objc/runtime.h>

@implementation UIViewController (HUD)

@dynamic hud;
@dynamic targetView;
@dynamic timeOutVal;

- (void)initHUD
{
    [self initHUDAtView:self.view];
}

- (void)initHUDAtWindow
{
    [self initHUDAtView:[[UIApplication sharedApplication] delegate].window];
}

- (void)initHUDAtView:(UIView *)view
{
    if (view)
    {
        self.targetView=view;
        self.timeOutVal = kDefaultTimeoutTime;
        MBProgressHUD *hud=[[MBProgressHUD alloc] initWithView:view];
        hud.labelText = @"正在加载...";
        hud.color = [UIColor grayColor];
        hud.opacity=.5;
        hud.labelFont = [UIFont systemFontOfSize:14.];
        [view addSubview:hud];
        self.hud=hud;
    }
}

- (void)destroyHUD
{
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(_showDefaultTimeoutHudAtView:) object:self.targetView];
    self.targetView=nil;
    if(self.hud && self.hud.superview)
        [self.hud removeFromSuperview];
    self.hud=nil;
    self.showing=nil;
}

- (void)showHudWithAnimation:(BOOL)animated
{
    [self showHudWithAnimation:animated dimBackground:NO];
}

- (void)showHudWithAnimation:(BOOL)animated dimBackground:(BOOL)dimBackground
{
    dispatch_async(dispatch_get_main_queue(), ^{
        if(!self.hud || [self.showing boolValue])
            return;
        
        self.showing=[NSNumber numberWithBool:YES];
        self.hud.dimBackground=dimBackground;
        [self.hud show:animated];
        
//        //根据网络类型设置不同的超时时间，wifi8秒，非wifi18秒
//        NSTimeInterval interval=self.timeOutVal;
//        Dzh_IphoneAppDelegate *dzhLTdelegate = (Dzh_IphoneAppDelegate *)dzhAppDelegate;
//        if([dzhLTdelegate.hostReach isReachableViaWiFi])
//            interval=kDefaultTimeoutTime;
        
        NSTimeInterval interval=self.timeOutVal;
        
        [self performSelector:@selector(_showDefaultTimeoutHudAtView:) withObject:self.targetView afterDelay:interval];
    });
}

- (void)showHudWithAnimation:(NSString *)tipInfo animated:(BOOL)animated dimBackground:(BOOL)dimBackground
{
    dispatch_async(dispatch_get_main_queue(), ^{
        if(!self.hud || [self.showing boolValue])
            return;
        
        [self.hud hide:NO];
        
        MBProgressHUD *hud  = [[MBProgressHUD alloc] initWithView:self.targetView];
        hud.customView      = [[UIView alloc] initWithFrame:CGRectZero] ;
        hud.mode            = MBProgressHUDModeCustomView;
        hud.labelText       = tipInfo;
        hud.opacity         = .5;
        hud.removeFromSuperViewOnHide = YES;
        hud.labelFont       = [UIFont systemFontOfSize:14.];
        [self.targetView addSubview:hud];
        [hud show:YES];
    });
}

- (void)showHudWithAnimation:(NSString *)tipInfo animated:(BOOL)animated dimBackground:(BOOL)dimBackground hidenAfterDelay:(NSTimeInterval)delay
{
    dispatch_async(dispatch_get_main_queue(), ^{
        if(!self.hud || [self.showing boolValue])
            return;
        
        [self.hud hide:NO];
        MBProgressHUD *hud  = [[MBProgressHUD alloc] initWithView:self.targetView];
        hud.customView      = [[UIView alloc] initWithFrame:CGRectZero] ;
        hud.mode            = MBProgressHUDModeCustomView;
        hud.labelText       = tipInfo;
        hud.opacity         = .5;
        hud.removeFromSuperViewOnHide = YES;
        hud.labelFont       = [UIFont systemFontOfSize:14.];
        [self.targetView addSubview:hud];
        [self.targetView bringSubviewToFront:hud];
        [hud show:YES];
        [hud hide:YES afterDelay:delay];
    });
}

- (void)hideHudWithAnimation:(BOOL)animated
{
    dispatch_async(dispatch_get_main_queue(), ^{
        if(!self.hud || ![self.showing boolValue])
            return;
        
        self.showing=[NSNumber numberWithBool:NO];
        [self.hud hide:animated];
        [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(_showDefaultTimeoutHudAtView:) object:self.targetView];
    });
}

- (void)hideHudAtMainThreadWithoutAnmiation
{
    dispatch_async(dispatch_get_main_queue(), ^{
        if(!self.hud || ![self.showing boolValue])
            return;
        
        self.showing=[NSNumber numberWithBool:NO];
        [self.hud hide:NO];
        [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(_showDefaultTimeoutHudAtView:) object:self.targetView];
    });
}

- (void)hideHudWithAnimation:(BOOL)animated afterDelay:(NSTimeInterval)delay
{
    dispatch_async(dispatch_get_main_queue(), ^{
        if(!self.hud || ![self.showing boolValue])
            return;
        
        self.showing=[NSNumber numberWithBool:NO];
        [self.hud hide:animated afterDelay:delay];
        [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(_showDefaultTimeoutHudAtView:) object:self.targetView];
    });
}

- (void)hideHudDefault
{
    [self hideHudWithAnimation:YES];
}

- (void)_showDefaultTimeoutHudAtView:(UIView *)view
{
    if (view)
    {
        [self.hud hide:NO];
        self.showing=[NSNumber numberWithBool:NO];
        MBProgressHUD *hud=[[MBProgressHUD alloc] initWithView:view];
        hud.customView=[[UIView alloc] initWithFrame:CGRectZero];
        hud.mode = MBProgressHUDModeCustomView;
        hud.labelText = @"数据请求失败,请重试!";
        hud.opacity=.5;
        hud.removeFromSuperViewOnHide=YES;
        hud.labelFont = [UIFont systemFontOfSize:14.];
        [view addSubview:hud];
        
        [hud show:YES];
        [hud hide:YES afterDelay:2.];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:kNotifyProgressTimeOut object:nil];
    }
}

#pragma mark - Getter setter

-(MBProgressHUD *)hud
{
    return objc_getAssociatedObject(self, @"hud");
}

-(void)setHud:(MBProgressHUD *)hud
{
    objc_setAssociatedObject(self, @"hud", hud, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIView *)targetView
{
    return objc_getAssociatedObject(self, @"targetView");
}

-(void)setTargetView:(UIView *)targetView
{
    objc_setAssociatedObject(self, @"targetView", targetView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSNumber *)showing
{
    return objc_getAssociatedObject(self, @"showing");
}

- (void)setShowing:(NSNumber *)showing
{
    objc_setAssociatedObject(self, @"showing", showing, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSTimeInterval)timeOutVal
{
    return [objc_getAssociatedObject(self, @"timeOutVal") doubleValue];
}

- (void)setTimeOutVal:(NSTimeInterval)timeVal
{
    objc_setAssociatedObject(self, @"timeOutVal", [NSNumber numberWithDouble:timeVal], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
