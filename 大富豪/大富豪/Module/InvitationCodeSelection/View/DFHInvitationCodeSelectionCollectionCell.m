//
//  DFHInvitationCodeSelectionCollectionCell.m
//  大富豪
//
//  Created by Louis on 2016/10/25.
//  Copyright © 2016年 Louis. All rights reserved.
//

#import "DFHInvitationCodeSelectionCollectionCell.h"
@interface DFHInvitationCodeSelectionCollectionCell ()

@property(nonatomic,retain)UIButton *nameButton;

@end

@implementation DFHInvitationCodeSelectionCollectionCell

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
    CGFloat labelWidth = selfWidth;
    CGFloat labelHeight = selfHeight;
    self.nameButton.frame = CGRectMake(0,0, labelWidth, labelHeight);
}

- (UIButton *)nameButton
{
    if (!_nameButton) {
        _nameButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _nameButton.frame = CGRectZero;
        [_nameButton setBackgroundImage:[UIImage imageNamed:@"login_loginBtn.png" bundle:DFHImageResourceBundle_Login] forState:UIControlStateNormal];
        [_nameButton setBackgroundImage:[UIImage imageNamed:@"login_loginSelectedBtn.png" bundle:DFHImageResourceBundle_Login] forState:UIControlStateSelected];
        _nameButton.titleLabel.font = [UIFont boldSystemFontOfSize:14];
        [_nameButton setTitleColor:[UIColor colorWithRed:0.17 green:0.00 blue:0.98 alpha:1.00] forState:UIControlStateNormal];
        _nameButton.titleLabel.adjustsFontSizeToFitWidth = YES;
        [self.contentView addSubview:_nameButton];
        _nameButton.userInteractionEnabled = NO;
    }
    return _nameButton;
}

- (void)fillDataWithStr:(NSString *)nameStr;
{
    [_nameButton setTitle:nameStr forState:UIControlStateNormal];
}

@end

@implementation DFHInvitationCodeSelectionCollectionModel

@end
