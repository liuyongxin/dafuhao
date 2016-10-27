//
//  PositionButton.h
//  大富豪
//
//  Created by Louis on 2016/10/27.
//  Copyright © 2016年 Louis. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, ButtonContentPosition) {
    ButtonContentPositionTitleTop,
    ButtonContentPositionTitleDown,
    ButtonContentPositionTitleLeft,
    ButtonContentPositionTitleRight
};

@interface PositionButton : UIButton

@property(nonatomic,assign)ButtonContentPosition contentPosition;
@property(nonatomic,assign)CGFloat titleScale;

@end
