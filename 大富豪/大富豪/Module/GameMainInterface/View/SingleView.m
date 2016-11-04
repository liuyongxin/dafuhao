//
//  SingleView.m
//  大富豪
//
//  Created by Louis on 2016/11/2.
//  Copyright © 2016年 Louis. All rights reserved.
//

#import "SingleView.h"

@interface SingleView()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,retain)UIImageView *bgImageView;
@property(nonatomic,retain)UITableView *mTableView;
@property(nonatomic,retain)NSMutableArray *dataArray;

@end

@implementation SingleView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _bgImageView = [[UIImageView alloc]initWithFrame:self.bounds];
        _bgImageView.image = [UIImage imageNamed:@"SingleBg.png" bundle:DFHImageResourceBundle_Main];
        _bgImageView.userInteractionEnabled = YES;
        [self addSubview:_bgImageView];
        [self configUI];
    }
    return self;
}

- (void)configUI
{
    CGFloat space = 5;
    CGFloat xAxis = (self.frame.size.width - 20)/2;
    CGFloat height = self.frame.size.height - 2*space;
    _mTableView = [[UITableView alloc]initWithFrame:CGRectMake(xAxis, space, 20, height) style:UITableViewStylePlain];
    _mTableView.delegate = self;
    _mTableView.dataSource = self;
    [_bgImageView addSubview:_mTableView];
    _mTableView.backgroundColor = [UIColor clearColor];
    if ([_mTableView respondsToSelector:@selector(setSeparatorInset:)])
    {
        [_mTableView setSeparatorInset:UIEdgeInsetsZero];
    }
}

#pragma UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID=@"cellID";
    SingleViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil)
    {
        cell=[[SingleViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 32;
}
    
#pragma UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setLayoutMargins:)])
    {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
    if([cell respondsToSelector:@selector(setPreservesSuperviewLayoutMargins:)])
    {
        [cell setPreservesSuperviewLayoutMargins:NO];
    }
}

@end

@interface SingleViewCell ()

@property(nonatomic,retain)UIImageView *bgImageView;

@end

@implementation SingleViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
    }
    return self;
}
- (UIImageView *)bgImageView
{
    if (!_bgImageView) {
        _bgImageView = [[UIImageView alloc]initWithFrame:self.bounds];
        _bgImageView.userInteractionEnabled = YES;
        [self.contentView addSubview:_bgImageView];
    }
    return _bgImageView;
}

- (void)assignmentColour:(NSString *)colour  number:(NSString *)number
{
    //color	所押花色	S：黑
    //C：梅
    //H：红
    //D：方
    //O：王
        NSMutableString *str = [NSMutableString stringWithString:@"Main_Poker_Single_"];
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
        self.bgImageView.image = [UIImage imageNamed:str bundle:DFHImageResourceBundle_Main_Poker_Single];
}


@end
