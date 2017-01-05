//
//  DFHRegisterViewController.m
//  大富豪
//
//  Created by Louis on 2016/10/25.
//  Copyright © 2016年 Louis. All rights reserved.
//

#import "DFHRegisterViewController.h"
#import "PositionButton.h"
#import "TPKeyboardAvoidingScrollView.h"
#import "DFHMachineSelectionController.h"
#import "DFHInvitationCodeSelectionController.h"
#import "PopupView.h"

@interface DFHRegisterViewController ()
{
    DFHHttpRequest *_httpRequest;
}
@property(nonatomic,retain)TPKeyboardAvoidingScrollView *mainView;
@property(nonatomic,retain)UIImageView *bgImageView;
@property(nonatomic,retain)UITextField *phoneNumberTextField; //手机号
@property(nonatomic,retain)UITextField *phoneSecurityCodeTextField; //手机验证码
@property(nonatomic,retain)UITextField *nicknameTextField;                  //昵称
@property(nonatomic,retain)UITextField *passwordTextField;               //密码
@property(nonatomic,retain)UILabel *confirmPasswordLabel;
@property(nonatomic,retain)UITextField *confirmPasswordTextField;  //确认密码
@property(nonatomic,retain)PositionButton  *oldyMemberBtn;  //旧会员登陆
@property(nonatomic,retain)PositionButton  *newlyMemberBtn;  //新会员注册
@property(nonatomic,retain)UILabel *invitationCodeLabel;
@property(nonatomic,retain)UITextField *invitationCodeTextField;       //邀请码

@end

@implementation DFHRegisterViewController
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self clearData];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    [self prepareData];
    [self configUI];
    [self defaultSeting:self.type];
    if (_oldyMemberBtn.isSelected && [DFHDataManager sharedInstance].accountInfo) {
        DFHAccountInfo *accountInfo = [DFHDataManager sharedInstance].accountInfo;
        _phoneNumberTextField.text = accountInfo.phoneNumber;
        _nicknameTextField.text = accountInfo.userName;
        _passwordTextField.text = accountInfo.passkey;
    }
}

- (void)prepareData
{
    _httpRequest = [[DFHHttpRequest alloc]init];
}

- (void)configUI
{
    _mainView = [[TPKeyboardAvoidingScrollView alloc]initWithFrame:self.view.bounds];
    _mainView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_mainView];
    
    CGFloat bgWidth = 419;
    CGFloat bgHeight = 300;
    _bgImageView = [[UIImageView alloc]initWithFrame:CGRectMake((DFHScreenW - (DFHScreenH/bgHeight)*bgWidth)/2, 0, (DFHScreenH/bgHeight)*bgWidth, DFHScreenH)];
    _bgImageView.image = [UIImage imageNamed:@"login_kuang.png" bundle:DFHImageResourceBundle_Login];
    _bgImageView.userInteractionEnabled = YES;
    [_mainView addSubview:_bgImageView];
    _bgImageView.center = self.view.center;
    
    CGFloat xAxis = 0.0;
    CGFloat yAxis = 0.0;
    CGFloat xSpace = 10;
    CGFloat ySpace = 8;
    CGFloat labelWidth = 100;
    CGFloat textFieldWidth = 160;
    CGFloat labelHeight = 30;
    UIFont *labelFont = [UIFont systemFontOfSize:14];
    UIFont *textFieldFont = [UIFont systemFontOfSize:14];
    CGFloat startX = (DFHScreenW - (labelWidth + textFieldWidth  + xSpace))/2;
    CGFloat startY = (DFHScreenH -  (ySpace*7 + labelHeight*8))/2;
    xAxis = startX;
    yAxis = startY;
    
    UILabel *phoneNumberLabel = [[UILabel alloc]initWithFrame:CGRectMake(xAxis, yAxis, labelWidth, labelHeight)];
    phoneNumberLabel.text = @"手机号:";
    phoneNumberLabel.adjustsFontSizeToFitWidth = YES;
    phoneNumberLabel.textAlignment = NSTextAlignmentRight;
    phoneNumberLabel.textColor = [UIColor whiteColor];
    phoneNumberLabel.font = labelFont;
    [_mainView addSubview:phoneNumberLabel];
    xAxis  += xSpace + labelWidth;
    _phoneNumberTextField = [[UITextField alloc]initWithFrame:CGRectMake(xAxis, yAxis, textFieldWidth, labelHeight)];
    _phoneNumberTextField.borderStyle = UITextBorderStyleRoundedRect;
    _phoneNumberTextField.keyboardType = UIKeyboardTypeNumberPad;
    _phoneNumberTextField.placeholder = @"请输入您的手机号";
    _phoneNumberTextField.font = textFieldFont;
    [_mainView addSubview:_phoneNumberTextField];
    yAxis += ySpace +labelHeight;
    xAxis = startX;
    
    UILabel *phoneSecurityCodeLabel = [[UILabel alloc]initWithFrame:CGRectMake(xAxis, yAxis, labelWidth, labelHeight)];
    phoneSecurityCodeLabel.text = @"手机验证码:";
    phoneSecurityCodeLabel.adjustsFontSizeToFitWidth = YES;
    phoneSecurityCodeLabel.textAlignment = NSTextAlignmentRight;
    phoneSecurityCodeLabel.textColor = [UIColor whiteColor];
    phoneSecurityCodeLabel.font = labelFont;
    [_mainView addSubview:phoneSecurityCodeLabel];
    xAxis  += xSpace+labelWidth;
    _phoneSecurityCodeTextField = [[UITextField alloc]initWithFrame:CGRectMake(xAxis, yAxis, textFieldWidth, labelHeight)];
    _phoneSecurityCodeTextField.borderStyle = UITextBorderStyleRoundedRect;
    _phoneSecurityCodeTextField.keyboardType = UIKeyboardTypeNumberPad;
    _phoneSecurityCodeTextField.placeholder = @"请输入您的手机校验码";
    _phoneSecurityCodeTextField.font = textFieldFont;
    [_mainView addSubview:_phoneSecurityCodeTextField];
    yAxis += ySpace + labelHeight;
    xAxis = startX;
    
    UILabel *nicknameLabel = [[UILabel alloc]initWithFrame:CGRectMake(xAxis, yAxis, labelWidth, labelHeight)];
    nicknameLabel.text = @"昵称:";
    nicknameLabel.adjustsFontSizeToFitWidth = YES;
    nicknameLabel.textAlignment = NSTextAlignmentRight;
    nicknameLabel.textColor = [UIColor whiteColor];
    nicknameLabel.font = labelFont;
    [_mainView addSubview:nicknameLabel];
    xAxis  += xSpace + labelWidth;
    _nicknameTextField = [[UITextField alloc]initWithFrame:CGRectMake(xAxis, yAxis, textFieldWidth, labelHeight)];
    _nicknameTextField.borderStyle = UITextBorderStyleRoundedRect;
    _nicknameTextField.placeholder = @"请输入您的昵称";
    _nicknameTextField.font = textFieldFont;
    [_mainView addSubview:_nicknameTextField];
    yAxis += ySpace +labelHeight;
    xAxis = startX;
    
    UILabel *passwordLabel = [[UILabel alloc]initWithFrame:CGRectMake(xAxis, yAxis, labelWidth, labelHeight)];
    passwordLabel.text = @"密码:";
    passwordLabel.adjustsFontSizeToFitWidth = YES;
    passwordLabel.textAlignment = NSTextAlignmentRight;
    passwordLabel.textColor = [UIColor whiteColor];
    passwordLabel.font = labelFont;
    [_mainView addSubview:passwordLabel];
    xAxis  += xSpace+labelWidth;
    _passwordTextField = [[UITextField alloc]initWithFrame:CGRectMake(xAxis, yAxis, textFieldWidth, labelHeight)];
    _passwordTextField.borderStyle = UITextBorderStyleRoundedRect;
    _passwordTextField.secureTextEntry = YES;
    _passwordTextField.placeholder = @"请输入您的密码";
    _passwordTextField.font = textFieldFont;
    [_mainView addSubview:_passwordTextField];
    yAxis += ySpace + labelHeight;
    xAxis = startX;
    
    _confirmPasswordLabel = [[UILabel alloc]initWithFrame:CGRectMake(xAxis, yAxis, labelWidth, labelHeight)];
    _confirmPasswordLabel.text = @"确认密码:";
    _confirmPasswordLabel.adjustsFontSizeToFitWidth = YES;
    _confirmPasswordLabel.textAlignment = NSTextAlignmentRight;
    _confirmPasswordLabel.textColor = [UIColor whiteColor];
    _confirmPasswordLabel.font = labelFont;
    [_mainView addSubview:_confirmPasswordLabel];
    xAxis  += xSpace + labelWidth;
    _confirmPasswordTextField = [[UITextField alloc]initWithFrame:CGRectMake(xAxis, yAxis, textFieldWidth, labelHeight)];
    _confirmPasswordTextField.borderStyle = UITextBorderStyleRoundedRect;
    _confirmPasswordTextField.secureTextEntry = YES;
    _confirmPasswordTextField.placeholder = @"请确认您的密码";
    _confirmPasswordTextField.font = textFieldFont;
    [_mainView addSubview:_confirmPasswordTextField];
    yAxis += ySpace + labelHeight;
    xAxis = startX;
    
    CGFloat selectedBtnWidth = 110.0;
    CGFloat selectedBtnHeight = 23.0;
    _oldyMemberBtn = [PositionButton buttonWithType:UIButtonTypeCustom];
    _oldyMemberBtn.frame = CGRectMake(xAxis, yAxis,selectedBtnWidth, selectedBtnHeight);
    _oldyMemberBtn.contentPosition = ButtonContentPositionTitleRight;
    _oldyMemberBtn.titleScale = ((selectedBtnWidth - selectedBtnHeight)/selectedBtnWidth);
    [_oldyMemberBtn setImage:[UIImage imageNamed:@"login_weixuan.png" bundle:DFHImageResourceBundle_Login] forState:UIControlStateNormal];
    [_oldyMemberBtn setImage:[UIImage imageNamed:@"login_xuan.png" bundle:DFHImageResourceBundle_Login] forState:UIControlStateSelected];
    [_oldyMemberBtn setTitle:@" 旧会员登陆" forState:UIControlStateNormal];
    [_oldyMemberBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _oldyMemberBtn.titleLabel.adjustsFontSizeToFitWidth = YES;
    _oldyMemberBtn.titleLabel.font = labelFont;
    _oldyMemberBtn.adjustsImageWhenHighlighted = NO;
    [_oldyMemberBtn addTarget:self action:@selector(selectedBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [_mainView addSubview:_oldyMemberBtn];
    
    _newlyMemberBtn = [PositionButton buttonWithType:UIButtonTypeCustom];
    _newlyMemberBtn.frame = CGRectMake(xAxis +(labelWidth + textFieldWidth+ xSpace - selectedBtnWidth), yAxis,selectedBtnWidth, 23);
    _newlyMemberBtn.contentPosition = ButtonContentPositionTitleRight;
    _newlyMemberBtn.titleScale = ((selectedBtnWidth - selectedBtnHeight)/selectedBtnWidth);
    [_newlyMemberBtn setImage:[UIImage imageNamed:@"login_weixuan.png" bundle:DFHImageResourceBundle_Login] forState:UIControlStateNormal];
    [_newlyMemberBtn setImage:[UIImage imageNamed:@"login_xuan.png" bundle:DFHImageResourceBundle_Login] forState:UIControlStateSelected];
    [_newlyMemberBtn setTitle:@" 新会员注册" forState:UIControlStateNormal];
    [_newlyMemberBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _newlyMemberBtn.titleLabel.adjustsFontSizeToFitWidth = YES;
    _newlyMemberBtn.titleLabel.font = labelFont;
    _newlyMemberBtn.adjustsImageWhenHighlighted = NO;
    [_newlyMemberBtn addTarget:self action:@selector(selectedBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [_mainView addSubview:_newlyMemberBtn];
    yAxis += ySpace + selectedBtnHeight;
    xAxis = startX;
    
    _invitationCodeLabel = [[UILabel alloc]initWithFrame:CGRectMake(xAxis, yAxis, labelWidth, labelHeight)];
    _invitationCodeLabel.text = @"邀请码:";
    _invitationCodeLabel.adjustsFontSizeToFitWidth = YES;
    _invitationCodeLabel.textAlignment = NSTextAlignmentRight;
    _invitationCodeLabel.textColor = [UIColor whiteColor];
    _invitationCodeLabel.font = labelFont;
    [_mainView addSubview:_invitationCodeLabel];
    xAxis  += xSpace + labelWidth;
    _invitationCodeTextField = [[UITextField alloc]initWithFrame:CGRectMake(xAxis, yAxis, textFieldWidth, labelHeight)];
    _invitationCodeTextField.borderStyle = UITextBorderStyleRoundedRect;
    _invitationCodeTextField.placeholder = @"请输入您的邀请码";
    _invitationCodeTextField.font = textFieldFont;
    [_mainView addSubview:_invitationCodeTextField];
    
    yAxis += ySpace + labelHeight;
    CGFloat confirmBtnWidth = 100;
    CGFloat confirmBtnHeight = 30;
    xAxis = (DFHScreenW - confirmBtnWidth*3)/2;
    UIButton *confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    confirmBtn.frame = CGRectMake(xAxis, yAxis, confirmBtnWidth, confirmBtnHeight);
    [confirmBtn setTitle:@"确定" forState:UIControlStateNormal];
    [confirmBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [confirmBtn setBackgroundImage:[UIImage imageNamed:@"login_registBtn_normal.png" bundle:DFHImageResourceBundle_Login] forState:UIControlStateNormal];
        [confirmBtn setBackgroundImage:[UIImage imageNamed:@"login_registBtn_select.png" bundle:DFHImageResourceBundle_Login] forState:UIControlStateSelected];
    [confirmBtn addTarget:self action:@selector(confirmBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [_mainView addSubview:confirmBtn];
    xAxis += confirmBtnWidth*2;
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(xAxis, yAxis, confirmBtnWidth, confirmBtnHeight);
    [backBtn setTitle:@"返回" forState:UIControlStateNormal];
    [backBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [backBtn setBackgroundImage:[UIImage imageNamed:@"login_registBtn_normal.png" bundle:DFHImageResourceBundle_Login] forState:UIControlStateNormal];
    [backBtn setBackgroundImage:[UIImage imageNamed:@"login_registBtn_select.png" bundle:DFHImageResourceBundle_Login] forState:UIControlStateSelected];
    [backBtn addTarget:self action:@selector(backBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [_mainView addSubview:backBtn];
   
    [self addCloseButtonToKeyboard:_mainView];
}

- (void)defaultSeting:(ListType )type
{
    if (type == LoginListType) {         //选中登陆时
        _oldyMemberBtn.selected = YES;
        _newlyMemberBtn.selected = NO;
        _oldyMemberBtn.userInteractionEnabled = NO;
        _newlyMemberBtn.userInteractionEnabled = YES;
        _confirmPasswordLabel.hidden = YES;
        _confirmPasswordTextField.hidden = YES;
        _invitationCodeLabel.hidden = YES;
        _invitationCodeTextField.hidden = YES;
    }
    else if (type == RegisterListType) //选中注册时
    {
        _oldyMemberBtn.selected = NO;
        _newlyMemberBtn.selected = YES;
        _oldyMemberBtn.userInteractionEnabled = YES;
        _newlyMemberBtn.userInteractionEnabled = NO;
        _confirmPasswordLabel.hidden = NO;
        _confirmPasswordTextField.hidden = NO;
        _invitationCodeLabel.hidden = NO;
        _invitationCodeTextField.hidden = NO;
    }
}

 - (void)clearData
{
    _phoneNumberTextField.text = nil;
    _phoneSecurityCodeTextField.text = nil;
    _nicknameTextField.text = nil;
    _passwordTextField.text = nil;
    _confirmPasswordTextField.text = nil;
    _invitationCodeTextField.text = nil;
}

- (void)selectedBtnAction:(UIButton *)btn
{
    [self clearData];
    if (btn == _oldyMemberBtn && btn.selected == NO) {
        [self defaultSeting:LoginListType];
    }
    else if (btn == _newlyMemberBtn && btn.selected == NO)
    {
        [self defaultSeting:RegisterListType];
    }
}

 - (void)confirmBtnAction:(UIButton *)btn  //确认
{
    if ([self detectionOfLegitimacy])
    {
        [[DFHDataManager sharedInstance] logOut];
        if(_newlyMemberBtn.selected)
        {
            [self requestMemberRegister];
        }
        else
        {
            [self requestMemberLogin];
        }
    }
}

 - (void)requestMemberLogin
{
    PopupView *pView = [[PopupView alloc]initWithTitle:@"正在登录中,请稍候...." icon:nil description:nil];
    [pView showInView:self.view targetView:nil animated:YES];
    __weak typeof(self) weakSelf = self;
    NSString*urlStr = [DFHRequestDataInterface makeRequestMemberLogin:_nicknameTextField.text password:_passwordTextField.text];
    [_httpRequest postWithURLString:urlStr parameters:nil success:^(id responseObject) {
        [pView dismiss:NO];
        NSDictionary *dataDic = [JSONFormatFunc convertDictionary:responseObject];
        if ([dataDic isValidDictionary]) {
            NSString *code = [JSONFormatFunc strValueForKey:@"code" ofDict:dataDic];
            if ([code isEqualToString:@"1"]) {
                NSDictionary *result = [JSONFormatFunc dictionaryValueForKey:@"result" ofDict:dataDic];
                if ([result isValidDictionary]) {
                    DFHAccountInfo *accountInfo = [[DFHAccountInfo alloc]init];
                    accountInfo.phoneNumber = _phoneNumberTextField.text;
                    accountInfo.userName = _nicknameTextField.text;
                    accountInfo.passkey = _passwordTextField.text;
                    [DFHDataManager sharedInstance].accountInfo = accountInfo;
                    [DFHDataManager sharedInstance].isLogin = YES;
                    [DFHDataManager sharedInstance].loginInfo = [DFHLoginInfo analyticalDataWithDictionary:result];
                    DFHInvitationCodeSelectionController *controller = [[DFHInvitationCodeSelectionController alloc]init];
                    [weakSelf.navigationController pushViewController:controller animated:YES];
                }
            }
            else
            {
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示信息" message:[JSONFormatFunc strValueForKey:@"msg" ofDict:dataDic] delegate:nil cancelButtonTitle:@"确认" otherButtonTitles:nil];
                [alert show];
            }
        }
    } failure:^(NSError *error) {

    }];
//    [self showHudWithAnimation:YES];
}

- (void)requestMemberRegister
{
    __weak typeof(self) weakSelf = self;
    NSDictionary *parametersDic = [DFHRequestDataInterface makeRequestMemberRegister:_nicknameTextField.text password:_passwordTextField.text code:_invitationCodeTextField.text nickName:_nicknameTextField.text inviteName:@""];
    [_httpRequest postWithURLString:DFH_MemberRegister parameters:parametersDic success:^(id responseObject) {
        [weakSelf hideHudDefault];
        NSDictionary *dataDic = [JSONFormatFunc convertDictionary:responseObject];
        if ([dataDic isValidDictionary]) {
            NSString *code = [JSONFormatFunc strValueForKey:@"code" ofDict:dataDic];
            if ([code isEqualToString:@"1"]) {
                NSDictionary *result = [JSONFormatFunc dictionaryValueForKey:@"result" ofDict:dataDic];
                if ([result isValidDictionary]) {
                    DFHAccountInfo *accountInfo = [[DFHAccountInfo alloc]init];
                    accountInfo.phoneNumber = _phoneNumberTextField.text;
                    accountInfo.userName = _nicknameTextField.text;
                    accountInfo.passkey = _passwordTextField.text;
                    [DFHDataManager sharedInstance].accountInfo = accountInfo;
                    [DFHDataManager sharedInstance].isLogin = YES;
                    [DFHDataManager sharedInstance].loginInfo = [DFHLoginInfo analyticalDataWithDictionary:result];
                    DFHInvitationCodeSelectionController *controller = [[DFHInvitationCodeSelectionController alloc]init];
                    [weakSelf.navigationController pushViewController:controller animated:YES];
                }
            }
            else
            {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示信息" message:[JSONFormatFunc strValueForKey:@"msg" ofDict:dataDic] delegate:nil cancelButtonTitle:@"确认" otherButtonTitles:nil];
                [alert show];
            }
        }
    } failure:^(NSError *error) {

    }];
    [self showHudWithAnimation:YES];
}
 - (BOOL)detectionOfLegitimacy
{
    NSString *msg = nil;
    if (_phoneNumberTextField.text.length == 0) {
        msg = @"手机号不能为空";
    }
    else if ( ![DFHUtil validMobile:_phoneNumberTextField.text]) {
        msg = @"请输入正确的手机号";
    }
    else if (_passwordTextField.text.length == 0)
    {
        msg = @"密码不能为空";
    }
    else if (_newlyMemberBtn.selected)
    {
        if (_confirmPasswordTextField.text.length == 0)
        {
            msg = @"确认密码不能为空";
        }
        else if (![_passwordTextField.text isEqualToString:_confirmPasswordTextField.text])
        {
             msg = @"确认密码与密码不匹配";
        }
        else if (_nicknameTextField.text.length == 0) {
            msg = @"昵称不能为空";
        }
        else if (_invitationCodeTextField.text.length == 0) {
            msg = @"邀请码不能为空";
        }
    }
    if (msg.length > 0) {
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"提示信息" message:msg delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alertView show];
        return NO;
    }
    return YES;
}

- (void)backBtnAction:(UIButton *)btn   //返回
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
