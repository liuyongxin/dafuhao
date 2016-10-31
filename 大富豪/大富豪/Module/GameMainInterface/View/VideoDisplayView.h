//
//  VideoDisplayView.h
//  大富豪
//
//  Created by Louis on 2016/10/31.
//  Copyright © 2016年 Louis. All rights reserved.
//
//视讯展示视图

typedef NS_ENUM(NSInteger,VideoDisplayType)
{
    VideoDisplayTypeNone,
    VideoDisplayTypeDefault,
    VideoDisplayTypeNormal
};
#import <UIKit/UIKit.h>

@interface VideoDisplayView : UIView

@property(nonatomic,assign)VideoDisplayType displayType;
@property(nonatomic,copy)NSString *playUrlStr;

@end
