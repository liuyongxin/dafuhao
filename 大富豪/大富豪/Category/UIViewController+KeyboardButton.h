
#import <UIKit/UIKit.h>

@interface UIViewController (KeyboardButton)

- (void)addCloseButtonForTextFields:(NSArray *)textFieldArray;
- (void)addCloseButtonToKeyboard;
- (void)addCloseButtonToKeyboard:(UIView *)containerView;
@end
