//
//  BetPointsView.m
//  大富豪
//
//  Created by Louis on 2016/11/2.
//  Copyright © 2016年 Louis. All rights reserved.
//

#import "BetPointsView.h"

@interface BetPointsView()

@property(nonatomic,retain)UIButton *spadesBtn;  //黑桃
@property(nonatomic,retain)UIButton *heartsBtn;    //红桃
@property(nonatomic,retain)UIButton *clubsBtn;         //梅花
@property(nonatomic,retain)UIButton *diamondsBtn; //方块
@property(nonatomic,retain)UIButton *kingBtn;         //王
@property(nonatomic,retain)UIButton *confirmBtn;   //确认

@end

@implementation BetPointsView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self configUI];
    }
    return self;
}

- (void)configUI
{
    CGSize size = self.frame.size;
    CGFloat xSpace = 1;
    CGFloat btnWidth = 65;
    CGFloat btnHeight = 60;
    
    CGFloat xStart = (size.width -  btnWidth * 6 - xSpace*5)/2;
    CGFloat yStart = (size.height - btnHeight) /2;
    CGFloat xAxis = xStart;
    CGFloat yAxis = yStart;

    NSArray *normalImagesArray = @[
                             [UIImage imageNamed:@"Main_ChargePoints_NormalHeitao.png" bundle:DFHImageResourceBundle_Main_ChargePoints],
                             [UIImage imageNamed:@"Main_ChargePoints_NormalHongtao.png" bundle:DFHImageResourceBundle_Main_ChargePoints],
                             [UIImage imageNamed:@"Main_ChargePoints_NormalMeihua.png" bundle:DFHImageResourceBundle_Main_ChargePoints],
                             [UIImage imageNamed:@"Main_ChargePoints_NormalFangkuai.png" bundle:DFHImageResourceBundle_Main_ChargePoints],
                             [UIImage imageNamed:@"Main_ChargePoints_NormalWang.png" bundle:DFHImageResourceBundle_Main_ChargePoints],
                             [UIImage imageNamed:@"Main_ChargePoints_NormalConfirm.png" bundle:DFHImageResourceBundle_Main_ChargePoints]];
    NSArray *selectedImagesArray = @[
                                     [UIImage imageNamed:@"Main_ChargePoints_SelectedHeitao.png" bundle:DFHImageResourceBundle_Main_ChargePoints],
                                     [UIImage imageNamed:@"Main_ChargePoints_SelectedHongtao.png" bundle:DFHImageResourceBundle_Main_ChargePoints],
                                     [UIImage imageNamed:@"Main_ChargePoints_SelectedMeihua.png" bundle:DFHImageResourceBundle_Main_ChargePoints],
                                     [UIImage imageNamed:@"Main_ChargePoints_SelectedFangkuai.png" bundle:DFHImageResourceBundle_Main_ChargePoints],
                                     [UIImage imageNamed:@"Main_ChargePoints_SelectedWang.png" bundle:DFHImageResourceBundle_Main_ChargePoints],
                                     [UIImage imageNamed:@"Main_ChargePoints_SelectedConfirm.png" bundle:DFHImageResourceBundle_Main_ChargePoints]];
    for (int i = 0; i < 6; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(xAxis,yAxis, btnWidth, btnHeight);
        [btn setBackgroundImage:normalImagesArray[i] forState:UIControlStateNormal];
        [btn setBackgroundImage:selectedImagesArray[i] forState:UIControlStateSelected];
        [self addSubview:btn];
        xAxis += xSpace + btnWidth;
        [btn setTitleEdgeInsets:UIEdgeInsetsMake(btn.frame.size.height/3, btn.frame.size.width/3, btn.frame.size.height/3, 5)];
        if (i == 0) {
            _spadesBtn = btn;
        }
        else if (i == 1)
        {
            _heartsBtn = btn;
        }
        else if (i == 2)
        {
            _clubsBtn = btn;
        }
        else if (i == 3)
        {
            _diamondsBtn = btn;
        }
        else if (i == 4)
        {
            _kingBtn = btn;
        }
        else if (i == 5)
        {
            [btn setTitleEdgeInsets:UIEdgeInsetsZero];
            _confirmBtn = btn;
        }
    }
    
    
}


@end
