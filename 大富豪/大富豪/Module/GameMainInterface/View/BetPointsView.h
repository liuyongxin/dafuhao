//
//  BetPointsView.h
//  大富豪
//
//  Created by Louis on 2016/11/2.
//  Copyright © 2016年 Louis. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger,ClickBtnType)
{
    ClickBtnTypeNone = -1,
    ClickBtnTypeSpades = 0,
    ClickBtnTypeHearts,
    ClickBtnTypeClubs,
    ClickBtnTypeDiamonds,
    ClickBtnTypeKing
};

@interface BetPointsView : UIView

@property(nonatomic,copy)void(^betPointsAction)(ClickBtnType type);
@property(nonatomic,copy)void(^confirmAction)();

@end
