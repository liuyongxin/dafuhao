//
//  LotteryView.m
//  大富豪
//
//  Created by Louis on 2016/11/2.
//  Copyright © 2016年 Louis. All rights reserved.
//

#import "LotteryView.h"

@interface LotteryView()

@property(nonatomic,retain)UIImageView *bgImageView;
@property(nonatomic,retain)UIImageView *lotteryImageView;

@end

@implementation LotteryView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _bgImageView = [[UIImageView alloc]initWithFrame:self.bounds];
        _bgImageView.image = [UIImage imageNamed:@"LotteryBg.png" bundle:DFHImageResourceBundle_Main];
        [self addSubview:_bgImageView];
        self.type = LotteryTypeColor;
    }
    return self;
}

- (UIImageView *)lotteryImageView
{
    if (!_lotteryImageView) {
        CGFloat space = 3;
        _lotteryImageView = [[UIImageView alloc]initWithFrame:CGRectMake(space, space, _bgImageView.frame.size.width - 2*space, _bgImageView.frame.size.height - 2*space)];
        [_bgImageView addSubview:_lotteryImageView];
    }
    return _lotteryImageView;
}

- (void)assignmentColour:(NSString *)colour  number:(NSString *)number
{
    //color	所押花色	S：黑
    //C：梅
    //H：红
    //D：方
    //O：王
    if (self.type == LotteryTypeColor) {
        NSMutableString *str = [NSMutableString stringWithString:@"Main_Poker_Lottery_"];
        if ([colour isEqualToString:@"O"])//王
        {
                [str appendString:@"King"];
                [str appendString:number];
        }
        else
        {
            if ([colour isEqualToString:@"S"]) { //黑桃♠️
                [str appendString:@"Spade"];
            }
            else if ([colour isEqualToString:@"C"]) //梅花♣️
            {
                [str appendString:@"Club"];
            }
            else if ([colour isEqualToString:@"H"])//红桃♥️
            {
                [str appendString:@"Heart"];
            }
            else if ([colour isEqualToString:@"D"]) //方片♦️
            {
                [str appendString:@"Diamond"];
            }
            [str appendString:number];
        }
        [str appendString:@".png"];
        self.lotteryImageView.image = [UIImage imageNamed:str bundle:DFHImageResourceBundle_Main_Poker_Lottery];
    }
    else if (self.type == LotteryTypeBeauty) {
        NSMutableString *str = [NSMutableString stringWithString:@"Main_Beauty_"];
        [str appendString:number];
        [str appendString:@".png"];
        self.lotteryImageView.image = [UIImage imageNamed:str bundle:DFHImageResourceBundle_Main_Beauty];
    }
    else if (self.type == LotteryTypeDefualt)
    {
    
    }

}

@end
