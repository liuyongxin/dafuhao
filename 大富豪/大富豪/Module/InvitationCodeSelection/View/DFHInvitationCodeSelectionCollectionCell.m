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
        _nameButton.titleLabel.font = [UIFont systemFontOfSize:14];
        _nameButton.titleLabel.textColor = [UIColor colorWithRed:0.16 green:0.01 blue:0.69 alpha:1.00];
        [self.contentView addSubview:_nameButton];
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
