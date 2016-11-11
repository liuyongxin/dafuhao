//
//  DFHRecordCollectionViewCell.m
//  大富豪
//
//  Created by Louis on 2016/11/4.
//  Copyright © 2016年 Louis. All rights reserved.
//

#import "DFHRecordCollectionViewCell.h"

@interface DFHRecordCollectionViewCell()

@property(nonatomic,retain)UIImageView *bgImageView;
@property(nonatomic,retain)UIImageView *colorImageView;

@end

@implementation DFHRecordCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self optionSubViewsFrame];
    }
    return self;
}


-(void)optionSubViewsFrame
{
    CGFloat selfWidth = self.frame.size.width;
    CGFloat selfHeight = self.frame.size.height;
    CGFloat space = 2;
    self.bgImageView.frame = CGRectMake(0, 0, selfWidth, selfHeight);
    self.colorImageView.frame = CGRectMake(space, space, selfWidth - 2*space, selfHeight - 2*space);
}

- (UIImageView *)bgImageView
{
    if (!_bgImageView) {
        _bgImageView = [[UIImageView alloc]init];
        _bgImageView.image = [UIImage imageNamed:@"Main_Poker_Record_Default.png" bundle:DFHImageResourceBundle_Main_Poker_Record];
        _bgImageView.userInteractionEnabled = YES;
        [self.contentView addSubview:_bgImageView];
    }
    return _bgImageView;
}

- (UIImageView *)colorImageView
{
    if (!_colorImageView) {
        _colorImageView = [[UIImageView alloc]init];
        _colorImageView.userInteractionEnabled = YES;
        [self.contentView addSubview:_colorImageView];
    }
    return _colorImageView;
}

- (void)assignmentColour:(NSString *)colour  number:(NSString *)number
{
    //color	所押花色	S：黑
    //C：梅
    //H：红
    //D：方
    //O：王
    NSMutableString *str = [NSMutableString stringWithString:@"Main_Poker_Record_"];
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
        else
       {
            [str appendString:colour];
        }
    
        [str appendFormat:@"_%@",number];

    [str appendString:@".png"];
    self.colorImageView.image = [UIImage imageNamed:str bundle:DFHImageResourceBundle_Main_Poker_Record];
}

- (void)clearColorImage
{
    self.colorImageView.image = nil;
}
@end
