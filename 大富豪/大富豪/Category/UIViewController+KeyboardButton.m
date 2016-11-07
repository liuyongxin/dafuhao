
#import <UIKit/UIKit.h>
#import "UIViewController+KeyboardButton.h"

@implementation UIViewController (KeyboardButton)

- (void)addCloseButtonForTextFields:(NSArray *)textFieldArray
{
    for (UIView *view in textFieldArray)
    {
        UIView *toolView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, DFHScreenW, 25)];
        toolView.backgroundColor = [UIColor clearColor];
        CGRect switchFrame = CGRectMake(DFHScreenW-60, 0, 56, 25);
        UIButton *downBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        downBtn.frame = switchFrame;
        [downBtn setBackgroundImage:[UIImage imageNamed:@"keypad_BtnDown@2x.png" bundle:DFHImageResourceBundle_Util] forState:UIControlStateNormal];
        [downBtn addTarget:self action:@selector(closeAction:) forControlEvents:UIControlEventTouchUpInside];
        [toolView addSubview:downBtn];
        [view performSelector:@selector(setInputAccessoryView:) withObject:toolView];
    }
}

- (void)addCloseButtonToKeyboard
{
    [self addCloseButtonToKeyboard:self.view];
}

- (void)addCloseButtonToKeyboard:(UIView *)containerView
{
    for (UIView *view in containerView.subviews)
    {
        if ([view isKindOfClass:[UITextField class]] || [view isKindOfClass:[UITextView class]])
        {
            UIView *toolView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, DFHScreenW, 25)];
            toolView.backgroundColor = [UIColor clearColor];
            CGRect switchFrame = CGRectMake(DFHScreenW-60, 0, 56, 25);
            UIButton *downBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            downBtn.frame = switchFrame;
            [downBtn setBackgroundImage:[UIImage imageNamed:@"keypad_BtnDown@2x.png" bundle:DFHImageResourceBundle_Util] forState:UIControlStateNormal];
            [downBtn addTarget:self action:@selector(closeAction:) forControlEvents:UIControlEventTouchUpInside];
            [toolView addSubview:downBtn];
            [view performSelector:@selector(setInputAccessoryView:) withObject:toolView];
        }
    }
}

- (void)closeAction:(UIButton *)sender
{
    [self.view endEditing:YES];
}
@end
