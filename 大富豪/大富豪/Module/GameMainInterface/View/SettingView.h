//
//  SettingView.h
//  大富豪
//
//  Created by Louis on 2016/11/2.
//  Copyright © 2016年 Louis. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingView : UIView

@property(nonatomic,assign)UIView *selfTargetView;   //不持有
@property(nonatomic,assign)UIView *selfSuperView;    //不持有父视图
@property(nonatomic,copy)void(^touchDismissAction)();  //触摸屏幕隐藏视图时回调

- (void)showInSuperView:(UIView *)view targetView:(UIView *)targetView animated:(BOOL)animated;
- (void)dismiss:(BOOL)animation;

@end
