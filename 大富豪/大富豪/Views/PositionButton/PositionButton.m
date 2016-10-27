//
//  PositionButton.m
//  大富豪
//
//  Created by Louis on 2016/10/27.
//  Copyright © 2016年 Louis. All rights reserved.
//

#import "PositionButton.h"

@implementation PositionButton

+ (instancetype)buttonWithType:(UIButtonType)buttonType
{
    PositionButton *button = [super  buttonWithType:buttonType];
    button.titleScale = 2.0/3.0;
    return button;
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    CGRect rect = CGRectZero;
    CGFloat n = _titleScale;
    CGFloat perHeight = contentRect.size.height * n;
    CGFloat perWidth = contentRect.size.width * n;
    if (self.contentPosition == ButtonContentPositionTitleDown)  //下
    {
        rect = CGRectMake(0,contentRect.size.height -  perHeight, contentRect.size.width, perHeight);
    }
    else if (self.contentPosition == ButtonContentPositionTitleLeft) //左
    {
        rect = CGRectMake(0, 0, perWidth, contentRect.size.height);
    }
    else if(self.contentPosition == ButtonContentPositionTitleRight) //右
    {
        rect = CGRectMake(contentRect.size.width - perWidth, 0, perWidth, contentRect.size.height);
    }
    else          //上
    {
        rect = CGRectMake(0, 0, contentRect.size.width, perHeight);
    }
    return rect;
}

- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    CGRect rect = CGRectZero;
    CGFloat n = (1- _titleScale);
    CGFloat perHeight = contentRect.size.height*n;
    CGFloat perWidth = contentRect.size.width*n;
    if (self.contentPosition == ButtonContentPositionTitleDown)
    {
        rect = CGRectMake(0, 0, contentRect.size.width, perHeight);
    }
    else if (self.contentPosition == ButtonContentPositionTitleLeft)
    {
        rect = CGRectMake(contentRect.size.width - perWidth, 0, perWidth, contentRect.size.height);
    }
    else if(self.contentPosition == ButtonContentPositionTitleRight)
    {
        rect = CGRectMake(0, 0, perWidth, contentRect.size.height);
    }
    else
    {
        rect = CGRectMake(0,contentRect.size.height - perHeight,contentRect.size.width, perHeight);
    }
    return rect;
}
@end
