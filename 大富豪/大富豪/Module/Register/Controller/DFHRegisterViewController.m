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
#import "DFHHttpRequest.h"
#import "DFHRequestDataInterface.h"
#import "DFHDataUrl.h"
#import "AES.h"

@interface DFHRegisterViewController ()
{
    DFHHttpRequest *_httpRequest;
}
@property(nonatomic,retain)TPKeyboardAvoidingScrollView *mainView;
@property(nonatomic,retain)UIImageView *bgImageView;        //背景框419*300
@property(nonatomic,retain)UITextField *accountTextField;                  //账号
@property(nonatomic,retain)UITextField *passwordTextField;               //密码
@property(nonatomic,retain)UITextField *confirmPasswordTextField;  //确认密码
@property(nonatomic,retain)PositionButton  *oldyMemberBtn;  //旧会员登陆
@property(nonatomic,retain)PositionButton  *newlyMemberBtn;  //新会员注册
@property(nonatomic,retain)UILabel *invitationCodeLabel;
@property(nonatomic,retain)UITextField *invitationCodeTextField;       //邀请码

@end

@implementation DFHRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    [self prepareData];
    [self configUI];
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
    
    _bgImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 419, 300)];
    _bgImageView.image = [UIImage imageNamed:@"login_kuang.png" bundle:DFHImageResourceBundle_Login];
    _bgImageView.userInteractionEnabled = YES;
    [_mainView addSubview:_bgImageView];
    _bgImageView.center = self.view.center;
    
    CGFloat xAxis = 0.0;
    CGFloat yAxis = 0.0;
    CGFloat space = 10;
    CGFloat labelWidth = 100;
    CGFloat textFieldWidth = 150;
    CGFloat labelHeight = 35;
    xAxis = (419 - (labelWidth + textFieldWidth  +space))/2;
    yAxis = space*2;
    UILabel *accountLabel = [[UILabel alloc]initWithFrame:CGRectMake(xAxis, yAxis, labelWidth, labelHeight)];
    accountLabel.text = @"账号:";
    accountLabel.adjustsFontSizeToFitWidth = YES;
    accountLabel.textAlignment = NSTextAlignmentRight;
    accountLabel.textColor = [UIColor whiteColor];
    xAxis  += space+labelWidth;
    [_bgImageView addSubview:accountLabel];
    _accountTextField = [[UITextField alloc]initWithFrame:CGRectMake(xAxis, yAxis, textFieldWidth, labelHeight)];
    _accountTextField.borderStyle = UITextBorderStyleRoundedRect;
    [_bgImageView addSubview:_accountTextField];
    
    yAxis +=space +labelHeight;
    xAxis = (419 - (labelWidth + textFieldWidth  +space))/2;
    UILabel *passwordLabel = [[UILabel alloc]initWithFrame:CGRectMake(xAxis, yAxis, labelWidth, labelHeight)];
    passwordLabel.text = @"密码:";
    passwordLabel.adjustsFontSizeToFitWidth = YES;
    passwordLabel.textAlignment = NSTextAlignmentRight;
    passwordLabel.textColor = [UIColor whiteColor];
    [_bgImageView addSubview:passwordLabel];
    xAxis  += space+labelWidth;
    _passwordTextField = [[UITextField alloc]initWithFrame:CGRectMake(xAxis, yAxis, textFieldWidth, labelHeight)];
    _passwordTextField.borderStyle = UITextBorderStyleRoundedRect;
    _passwordTextField.secureTextEntry = YES;
    [_bgImageView addSubview:_passwordTextField];
    
    yAxis +=space +labelHeight;
    xAxis = (419 - (labelWidth + textFieldWidth  +space))/2;
    UILabel *confirmPasswordLabel = [[UILabel alloc]initWithFrame:CGRectMake(xAxis, yAxis, labelWidth, labelHeight)];
    confirmPasswordLabel.text = @"确认密码:";
    confirmPasswordLabel.adjustsFontSizeToFitWidth = YES;
    confirmPasswordLabel.textAlignment = NSTextAlignmentRight;
    confirmPasswordLabel.textColor = [UIColor whiteColor];
    [_bgImageView addSubview:confirmPasswordLabel];
    xAxis  += space+labelWidth;
    _confirmPasswordTextField = [[UITextField alloc]initWithFrame:CGRectMake(xAxis, yAxis, textFieldWidth, labelHeight)];
    _confirmPasswordTextField.borderStyle = UITextBorderStyleRoundedRect;
    _confirmPasswordTextField.secureTextEntry = YES;
    [_bgImageView addSubview:_confirmPasswordTextField];
    
    yAxis +=space +labelHeight;
    xAxis = (419 - (labelWidth + textFieldWidth  +space))/2;
    
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
    _oldyMemberBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    _oldyMemberBtn.adjustsImageWhenHighlighted = NO;
    [_oldyMemberBtn addTarget:self action:@selector(selectedBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [_bgImageView addSubview:_oldyMemberBtn];
    
    _newlyMemberBtn = [PositionButton buttonWithType:UIButtonTypeCustom];
    _newlyMemberBtn.frame = CGRectMake(xAxis +(labelWidth+textFieldWidth+space - selectedBtnWidth), yAxis,selectedBtnWidth, 23);
    _newlyMemberBtn.contentPosition = ButtonContentPositionTitleRight;
    _newlyMemberBtn.titleScale = ((selectedBtnWidth - selectedBtnHeight)/selectedBtnWidth);
    [_newlyMemberBtn setImage:[UIImage imageNamed:@"login_weixuan.png" bundle:DFHImageResourceBundle_Login] forState:UIControlStateNormal];
    [_newlyMemberBtn setImage:[UIImage imageNamed:@"login_xuan.png" bundle:DFHImageResourceBundle_Login] forState:UIControlStateSelected];
    [_newlyMemberBtn setTitle:@" 新会员注册" forState:UIControlStateNormal];
    [_newlyMemberBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _newlyMemberBtn.titleLabel.adjustsFontSizeToFitWidth = YES;
    _newlyMemberBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    _newlyMemberBtn.adjustsImageWhenHighlighted = NO;
    [_newlyMemberBtn addTarget:self action:@selector(selectedBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [_bgImageView addSubview:_newlyMemberBtn];
    
    yAxis +=space +selectedBtnHeight;
    xAxis = (419 - (labelWidth + textFieldWidth  +space))/2;
    _invitationCodeLabel = [[UILabel alloc]initWithFrame:CGRectMake(xAxis, yAxis, labelWidth, labelHeight)];
    _invitationCodeLabel.text = @"邀请码:";
    _invitationCodeLabel.adjustsFontSizeToFitWidth = YES;
    _invitationCodeLabel.textAlignment = NSTextAlignmentRight;
    _invitationCodeLabel.textColor = [UIColor whiteColor];
    [_bgImageView addSubview:_invitationCodeLabel];
    xAxis  += space+labelWidth;
    _invitationCodeTextField = [[UITextField alloc]initWithFrame:CGRectMake(xAxis, yAxis, textFieldWidth, labelHeight)];
    _invitationCodeTextField.borderStyle = UITextBorderStyleRoundedRect;
    [_bgImageView addSubview:_invitationCodeTextField];
    
    
    yAxis +=space +labelHeight + space;
    xAxis = (419 - (labelWidth + textFieldWidth  +space))/2;
    CGFloat confirmBtnWidth = 125;
    CGFloat confirmBtnHeight = 35;
    UIButton *confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    confirmBtn.frame = CGRectMake(xAxis, yAxis, confirmBtnWidth, confirmBtnHeight);
    [confirmBtn setTitle:@"确定" forState:UIControlStateNormal];
    [confirmBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [confirmBtn setBackgroundImage:[UIImage imageNamed:@"login_registBtn_normal.png" bundle:DFHImageResourceBundle_Login] forState:UIControlStateNormal];
        [confirmBtn setBackgroundImage:[UIImage imageNamed:@"login_registBtn_select.png" bundle:DFHImageResourceBundle_Login] forState:UIControlStateSelected];
    [confirmBtn addTarget:self action:@selector(confirmBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [_bgImageView addSubview:confirmBtn];
    
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(xAxis + (labelWidth + textFieldWidth + space - confirmBtnWidth), yAxis, confirmBtnWidth, confirmBtnHeight);
    [backBtn setTitle:@"返回" forState:UIControlStateNormal];
    [backBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [backBtn setBackgroundImage:[UIImage imageNamed:@"login_registBtn_normal.png" bundle:DFHImageResourceBundle_Login] forState:UIControlStateNormal];
    [backBtn setBackgroundImage:[UIImage imageNamed:@"login_registBtn_select.png" bundle:DFHImageResourceBundle_Login] forState:UIControlStateSelected];
    [backBtn addTarget:self action:@selector(backBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [_bgImageView addSubview:backBtn];
    
    //设置默认选中登陆
    _oldyMemberBtn.selected = NO;
    _newlyMemberBtn.selected = YES;
}

- (void)selectedBtnAction:(UIButton *)btn
{
    if (btn == _oldyMemberBtn && btn.selected == NO) {
        _newlyMemberBtn.selected = _oldyMemberBtn.selected;
        _oldyMemberBtn.selected = !_oldyMemberBtn.selected;
        _invitationCodeLabel.hidden = YES;
        _invitationCodeTextField.hidden = YES;
        _invitationCodeTextField.text = nil;
    }
    else if (btn == _newlyMemberBtn && btn.selected == NO)
    {
        _oldyMemberBtn.selected = _newlyMemberBtn.selected;
        _newlyMemberBtn.selected = !_newlyMemberBtn.selected;
        _invitationCodeLabel.hidden = NO;
        _invitationCodeTextField.hidden = NO;
    }
}

 - (void)confirmBtnAction:(UIButton *)btn  //确认
{
    if ([self detectionOfLegitimacy])
    {
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
    NSDictionary *param = [DFHRequestDataInterface makeRequestMemberRegister:_accountTextField.text password:_passwordTextField.text code:@"" inviteName:@""];
    [_httpRequest getWithURLString:DFH_MemberLogin parameters:param success:^(id responseObject) {
        NSData *dataStr = responseObject;
        NSData *data = [AES DataAES128Decrypt:[[NSString alloc]initWithData:dataStr encoding:NSUTF8StringEncoding] key:Decryption_AESSecretKey];
    } failure:^(NSError *error) {
        NSString *str = error.localizedDescription;
    }];
}

- (void)requestMemberRegister
{
    NSDictionary *param = [DFHRequestDataInterface makeRequestMemberRegister:_accountTextField.text password:_passwordTextField.text code:_invitationCodeTextField.text inviteName:@""];
    [_httpRequest getWithURLString:DFH_MemberRegister parameters:param success:^(id responseObject) {
    } failure:^(NSError *error) {
        NSString *str = error.localizedDescription;
    }];
}
 - (BOOL)detectionOfLegitimacy
{
    NSString *msg = nil;
    if (_accountTextField.text.length == 0) {
        msg = @"账号不能为空";
    }
    else if (_passwordTextField.text.length == 0)
    {
        msg = @"密码不能为空";
    }
    else if (_confirmPasswordTextField.text.length == 0)
    {
        msg = @"确认密码不能为空";
    }
    else if (![_passwordTextField.text isEqualToString:_confirmPasswordTextField.text])
    {
       msg = @"确认密码与密码不匹配";
    }
    else if(_newlyMemberBtn.selected)
    {
        if (_invitationCodeTextField.text.length == 0) {
             msg = @"邀请码不能为空";
        }
    }
    else
    {
    
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
    [self dismissViewControllerAnimated:NO completion:nil];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
   NSString *str =  [AES AES128Encrypt:@"123" key:Decryption_AESSecretKey];
   NSString *str2 = [AES AES128Decrypt:str key:Decryption_AESSecretKey];
}
@end
