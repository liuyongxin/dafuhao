
#define kNotifyProgressTimeOut @"kNotifyProgressTimeOut"
#define kDefaultTimeoutTime 7
@class MBProgressHUD;

/**
 * 网络请求提示浮窗控制分类
 */
@interface UIViewController (HUD)

/**浮窗视图*/
@property(nonatomic,retain)MBProgressHUD *hud;
/**添加浮窗的目标视图*/
@property(nonatomic,retain)UIView *targetView;
/**浮窗视图显示、隐藏的标志，bool值*/
@property(nonatomic,retain)NSNumber *showing;
@property (nonatomic, assign) NSTimeInterval timeOutVal;

/**
 * 在self.view上添加hud
 */
- (void)initHUD;

/**
 * 在window上添加hud
 */
- (void)initHUDAtWindow;

/**
 * 在指定试图上添加hud
 * @param view 指定视图
 */
- (void)initHUDAtView:(UIView *)view;

/**
 * 释放hud相关资源
 */
- (void)destroyHUD;

/**
 * 显示hud
 * @param animated 是否使用动画
 */
- (void)showHudWithAnimation:(BOOL)animated;

/**
 * 显示hud
 * @param animated 是否使用动画
 * @param dimBackground 是否添加背景蒙板
 */
- (void)showHudWithAnimation:(BOOL)animated dimBackground:(BOOL)dimBackground;

- (void)showHudWithAnimation:(NSString *)tipInfo animated:(BOOL)animated dimBackground:(BOOL)dimBackground;
- (void)showHudWithAnimation:(NSString *)tipInfo animated:(BOOL)animated dimBackground:(BOOL)dimBackground hidenAfterDelay:(NSTimeInterval)delay;

/**
 * 隐藏hud
 * @param animated 是否使用动画
 */
- (void)hideHudWithAnimation:(BOOL)animated;

/**
 * 隐藏hud，不需要动画
 */
- (void)hideHudAtMainThreadWithoutAnmiation;

/**
 * 隐藏hud
 * @param animated 是否使用动画
 * @param delay 延迟一段时间后隐藏
 */
- (void)hideHudWithAnimation:(BOOL)animated afterDelay:(NSTimeInterval)delay;

/**
 * 隐藏hud方法快捷方法
 */
- (void)hideHudDefault;

@end
