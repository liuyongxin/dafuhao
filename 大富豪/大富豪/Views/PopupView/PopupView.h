
#import <UIKit/UIKit.h>

@interface PopupView : UIView

@property(nonatomic,assign,readonly)BOOL isShow;
@property(nonatomic,assign,readonly)UIView *selfTargetView;
@property(nonatomic,assign,readonly)UIView *selfSuperView;
@property(nonatomic,assign)BOOL isCanTouchDismiss; //点击空白处消失,默认为YES
@property(nonatomic,retain)UIColor *popupViewbgColor;
@property(nonatomic,retain)UIImage *popupViewbgImage;
@property(nonatomic,assign)CGFloat autoDismissInterval;  //自动消失时间.默认5.0f s

- (instancetype)initWithTitle:(NSString *)titleStr icon:(UIImage *)iconImage description:(NSAttributedString *)descriptionAttrStr;
- (void)showInView:(UIView *)view targetView:(UIView *)targetView animated:(BOOL)animated;
- (void)dismiss:(BOOL)animation;
+(PopupView *)showDefaultInView:(UIView *)view targetView:(UIView *)targetView animated:(BOOL)animated;

@end
