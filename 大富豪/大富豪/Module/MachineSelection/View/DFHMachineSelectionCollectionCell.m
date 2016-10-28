//
//  DFHMachineSelectionCollectionCell.m
//  大富豪
//
//  Created by Louis on 2016/10/25.
//  Copyright © 2016年 Louis. All rights reserved.
//

#import "DFHMachineSelectionCollectionCell.h"
@interface DFHMachineSelectionCollectionCell ()

@property(nonatomic,retain)UIImageView *bgImageView;
@property(nonatomic,retain)UILabel *numLabel;
@property(nonatomic,retain)UILabel *nameLabel;
@property(nonatomic,retain)UILabel *scaleLabel;

@end

@implementation DFHMachineSelectionCollectionCell

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
    CGFloat space = 20;
    CGFloat yAxis = space;
    CGFloat labelHeight = (selfHeight - space*2)/3;
    self.bgImageView.frame = CGRectMake(0, 0, selfWidth, selfHeight);
    self.numLabel.frame = CGRectMake(0, yAxis, selfWidth, labelHeight);
    yAxis += labelHeight;
    self.nameLabel.frame = CGRectMake(0,yAxis, selfWidth, labelHeight);
    yAxis += labelHeight;
    self.scaleLabel.frame = CGRectMake(0, yAxis, selfWidth, labelHeight);
}

- (UIImageView *)bgImageView
{
    if (!_bgImageView) {
        _bgImageView = [[UIImageView alloc]init];
        _bgImageView.image = [UIImage imageNamed:@"login_loginBtn.png" bundle:DFHImageResourceBundle_Login];
        _bgImageView.userInteractionEnabled = YES;
        [self.contentView addSubview:_bgImageView];
    }
    return _bgImageView;
}

- (UILabel *)numLabel
{
    if (!_numLabel) {
        _numLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        _numLabel.text = @" xx ";
        _numLabel.adjustsFontSizeToFitWidth = YES;
        _numLabel.textAlignment = NSTextAlignmentCenter;
        _numLabel.textColor = [UIColor redColor];
        [self.contentView addSubview:_numLabel];
    }
    return _numLabel;
}

- (UILabel *)nameLabel
{
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        _nameLabel.text = @" xxxx ";
        _nameLabel.adjustsFontSizeToFitWidth = YES;
        _nameLabel.textAlignment = NSTextAlignmentCenter;
        _nameLabel.textColor = [UIColor blackColor];
        [self.contentView addSubview:_nameLabel];
    }
    return _nameLabel;
}

-(UILabel *)scaleLabel
{
    if (!_scaleLabel) {
        _scaleLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        _scaleLabel.text = @" xx ";
        _scaleLabel.adjustsFontSizeToFitWidth = YES;
        _scaleLabel.textAlignment = NSTextAlignmentCenter;
        _scaleLabel.textColor = [UIColor blueColor];
        [self.contentView addSubview:_scaleLabel];
    }
    return _scaleLabel;
}

- (void)fillDataWithDic:(NSDictionary *)dataDic
{
    NSDictionary *machineInfoDic = [JSONFormatFunc dictionaryValueForKey:@"machineInfo" ofDict:dataDic];
    NSDictionary *machineSetDic = [JSONFormatFunc dictionaryValueForKey:@"machineSet" ofDict:dataDic];
    _numLabel.text = [NSString stringWithFormat:@"%@",[JSONFormatFunc strValueForKey:@"maxMember" ofDict:machineSetDic]];
    _nameLabel.text =  [NSString stringWithFormat:@"%@",[JSONFormatFunc strValueForKey:@"areaName" ofDict:machineInfoDic]];
    _scaleLabel.text = [NSString stringWithFormat:@"1:%@",[JSONFormatFunc strValueForKey:@"currencyRatio" ofDict:machineSetDic]];
}


@end

@implementation DFHMachineSelectionCollectionModel

@end
