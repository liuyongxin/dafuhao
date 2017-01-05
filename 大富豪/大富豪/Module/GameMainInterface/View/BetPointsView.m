//
//  BetPointsView.m
//  大富豪
//
//  Created by Louis on 2016/11/2.
//  Copyright © 2016年 Louis. All rights reserved.
//

#import "BetPointsView.h"
#import "BetPointsButton.h"

@interface BetPointsView()

@property(nonatomic,retain)BetPointsButton *spadesBtn;  //黑桃
@property(nonatomic,retain)BetPointsButton *heartsBtn;    //红桃
@property(nonatomic,retain)BetPointsButton *clubsBtn;         //梅花
@property(nonatomic,retain)BetPointsButton *diamondsBtn; //方块
@property(nonatomic,retain)BetPointsButton *kingBtn;         //王
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
    CGFloat btnWidth = 65 *0.9;
    CGFloat btnHeight = 60 *0.9;
    
    CGFloat xStart = xSpace;
    CGFloat yStart = 0;
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
    for (int i = 0; i < 5; i++) {
         BetPointsButton *btn = [[BetPointsButton alloc]initWithFrame:CGRectMake(xAxis,yAxis, (size.width - btnWidth - xSpace*7)/5, size.height - 3)];
        [btn setBackgroundImage:normalImagesArray[i] forState:UIControlStateNormal];
        [btn setBackgroundImage:selectedImagesArray[i] forState:UIControlStateSelected];
        [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
        
        xAxis += xSpace + (size.width - btnWidth - xSpace*7)/5;
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
    }
    _confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _confirmBtn.frame = CGRectMake(xAxis + xSpace,(size.height - btnHeight)/2, btnWidth, btnHeight);
    [_confirmBtn setBackgroundImage:normalImagesArray[5] forState:UIControlStateNormal];
    [_confirmBtn setBackgroundImage:selectedImagesArray[5] forState:UIControlStateSelected];
    [_confirmBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_confirmBtn];
}

- (void)btnAction:(UIButton *)btn
{
    ClickBtnType type = ClickBtnTypeNone;
    if (btn == _spadesBtn) {
        type = ClickBtnTypeSpades;
    }
    else if(btn == _heartsBtn)
    {
        type = ClickBtnTypeHearts;
    }
    else if(btn == _clubsBtn)
    {
        type = ClickBtnTypeClubs;
    }
    else if(btn == _diamondsBtn)
    {
        type = ClickBtnTypeDiamonds;
    }
    else if(btn == _kingBtn)
    {
        type = ClickBtnTypeKing;
    }
    else if(btn == _confirmBtn)
    {
        
    }
    if (type == ClickBtnTypeNone) {   //提交按钮
        if (self.confirmAction) {
            self.confirmAction();
        }
    }
    else
    {
        if (self.betPointsAction) {
            self.betPointsAction(type);
        }
    }
}

@end
