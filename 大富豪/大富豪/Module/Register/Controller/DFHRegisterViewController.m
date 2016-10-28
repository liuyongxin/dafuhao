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

@interface DFHRegisterViewController ()
{
    DFHHttpRequest *_httpRequest;
}
@property(nonatomic,retain)TPKeyboardAvoidingScrollView *mainView;
@property(nonatomic,retain)UIImageView *bgImageView;        //背景框419*300
@property(nonatomic,retain)UITextField *accountTextField;                  //账号
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
    [self defaultSeting:self.type];
}

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
    _confirmPasswordLabel = [[UILabel alloc]initWithFrame:CGRectMake(xAxis, yAxis, labelWidth, labelHeight)];
    _confirmPasswordLabel.text = @"确认密码:";
    _confirmPasswordLabel.adjustsFontSizeToFitWidth = YES;
    _confirmPasswordLabel.textAlignment = NSTextAlignmentRight;
    _confirmPasswordLabel.textColor = [UIColor whiteColor];
    [_bgImageView addSubview:_confirmPasswordLabel];
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
   
}

- (void)defaultSeting:(ListType )type
{
    if (type == LoginListType) {
        //设置默认选中登陆
        _oldyMemberBtn.selected = YES;
        _newlyMemberBtn.selected = NO;
        _confirmPasswordLabel.hidden = YES;
        _confirmPasswordTextField.hidden = YES;
        _invitationCodeLabel.hidden = YES;
        _invitationCodeTextField.hidden = YES;
    }
    else if (type == RegisterListType)
    {
        //设置默认选中登陆
        _oldyMemberBtn.selected = NO;
        _newlyMemberBtn.selected = YES;
        _confirmPasswordLabel.hidden = NO;
        _confirmPasswordTextField.hidden = NO;
        _invitationCodeLabel.hidden = NO;
        _invitationCodeTextField.hidden = NO;
    }

}

 - (void)clearData
{
    _accountTextField.text = nil;
    _passwordTextField.text = nil;
    _confirmPasswordTextField.text = nil;
    _invitationCodeTextField.text = nil;
}

- (void)selectedBtnAction:(UIButton *)btn
{
    [self clearData];
    if (btn == _oldyMemberBtn && btn.selected == NO) {
        _newlyMemberBtn.selected = _oldyMemberBtn.selected;
        _oldyMemberBtn.selected = !_oldyMemberBtn.selected;
        _confirmPasswordLabel.hidden = YES;
        _confirmPasswordTextField.hidden = YES;
        _invitationCodeLabel.hidden = YES;
        _invitationCodeTextField.hidden = YES;
    }
    else if (btn == _newlyMemberBtn && btn.selected == NO)
    {
        _oldyMemberBtn.selected = _newlyMemberBtn.selected;
        _newlyMemberBtn.selected = !_newlyMemberBtn.selected;
        _confirmPasswordLabel.hidden = NO;
        _confirmPasswordTextField.hidden = NO;
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
    __weak typeof(self) weakSelf = self;
    NSString*urlStr = [DFHRequestDataInterface makeRequestMemberLogin:_accountTextField.text password:_passwordTextField.text];
    [_httpRequest postWithURLString:urlStr parameters:nil success:^(id responseObject) {
        [weakSelf hideHudDefault];
        NSDictionary *dataDic = [JSONFormatFunc convertDictionary:responseObject];
        if ([dataDic isValidDictionary]) {
            NSString *code = [JSONFormatFunc strValueForKey:@"code" ofDict:dataDic];
            if ([code isEqualToString:@"1"]) {
                NSDictionary *result = [JSONFormatFunc dictionaryValueForKey:@"result" ofDict:dataDic];
                if ([result isValidDictionary]) {
                    [DFHDataManager sharedInstance].loginInfo = [DFHLoginInfo analyticalDataWithDictionary:result];
                    DFHMachineSelectionController *controller = [[DFHMachineSelectionController alloc]init];
                    controller.type = MembersIntoType;
                    controller.code = [DFHDataManager sharedInstance].loginInfo.code;
                    [weakSelf presentViewController:controller animated:NO completion:nil];
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

- (void)requestMemberRegister
{
    __weak typeof(self) weakSelf = self;
    NSString *urlStr = [DFHRequestDataInterface makeRequestMemberRegister:_accountTextField.text password:_passwordTextField.text code:_invitationCodeTextField.text inviteName:@""];
    [_httpRequest postWithURLString:urlStr parameters:nil success:^(id responseObject) {
        [weakSelf hideHudDefault];
        NSDictionary *dataDic = [JSONFormatFunc convertDictionary:responseObject];
        if ([dataDic isValidDictionary]) {
            NSString *code = [JSONFormatFunc strValueForKey:@"code" ofDict:dataDic];
            if ([code isEqualToString:@"1"]) {
//                NSDictionary *result = [JSONFormatFunc dictionaryValueForKey:@"result" ofDict:dataDic];
//                if ([result isValidDictionary]) {
//                    [DFHDataManager sharedInstance].loginInfo = [DFHLoginInfo analyticalDataWithDictionary:result];
//                    DFHMachineSelectionController *controller = [[DFHMachineSelectionController alloc]init];
//                    controller.type = MembersIntoType;
//                    controller.code = [DFHDataManager sharedInstance].loginInfo.code;
//                    [weakSelf presentViewController:controller animated:NO completion:nil];
//                }
            }
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示信息" message:[JSONFormatFunc strValueForKey:@"msg" ofDict:dataDic] delegate:nil cancelButtonTitle:@"确认" otherButtonTitles:nil];
                [alert show];
        }
    } failure:^(NSError *error) {

    }];
    [self showHudWithAnimation:YES];
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

@end
