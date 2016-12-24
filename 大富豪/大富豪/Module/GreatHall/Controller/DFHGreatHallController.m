//
//  DFHGreatHallController.m
//  大富豪
//
//  Created by Louis_liu on 2016/12/21.
//  Copyright © 2016年 Louis. All rights reserved.
//

#import "DFHGreatHallController.h"
#import "DFHMachineSelectionController.h"
#import "DFHRegisterViewController.h"
#import "DFHGameMainInterFaceController.h"
#import "DFHAppDelegate.h"
#import "DFHInvitationCodeSelectionController.h"

@interface DFHGreatHallController ()

@property(nonatomic,retain)UIImageView *bgImageView;

@end

@implementation DFHGreatHallController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    [self prepareData];
    [self configUI];
}

- (void)prepareData
{
    
}

- (void)configUI
{
    CGFloat btnW = 90;
    _bgImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, DFHScreenW, DFHScreenH)];
    _bgImageView.userInteractionEnabled = YES;
    _bgImageView.center = self.view.center;
    _bgImageView.image = [UIImage imageNamed:@"login_bg2.png" bundle:DFHImageResourceBundle_Login];
    [self.view addSubview:_bgImageView];
    
    CGFloat spaceX = 20.0;
    CGFloat xAxis = (DFHScreenW - btnW*3 - spaceX*2)/2;
    CGFloat yAxis = (DFHScreenH - btnW)/2;
    
    UIButton *playBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    playBtn.tag = 10;
    playBtn.frame = CGRectMake(xAxis, yAxis, btnW, btnW);
    [playBtn setTitle:@"游玩" forState:UIControlStateNormal];
    [playBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [playBtn setBackgroundImage:[UIImage imageNamed:@"login_loginBtn.png" bundle:DFHImageResourceBundle_Login] forState:UIControlStateNormal];
    [playBtn setBackgroundImage:[UIImage imageNamed:@"login_loginSelectedBtn.png" bundle:DFHImageResourceBundle_Login] forState:UIControlStateSelected];
    [playBtn addTarget:self action:@selector(tapBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:playBtn];
    
    xAxis +=(btnW+spaceX);
    
    UIButton *registerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    registerBtn.tag = 11;
    registerBtn.frame = CGRectMake(xAxis, yAxis, btnW, btnW);
    [registerBtn setTitle:@"注册" forState:UIControlStateNormal];
    [registerBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [registerBtn setBackgroundImage:[UIImage imageNamed:@"login_loginBtn.png" bundle:DFHImageResourceBundle_Login] forState:UIControlStateNormal];
    [registerBtn setBackgroundImage:[UIImage imageNamed:@"login_loginSelectedBtn.png" bundle:DFHImageResourceBundle_Login] forState:UIControlStateSelected];
    [registerBtn addTarget:self action:@selector(tapBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:registerBtn];
    
    xAxis +=(btnW+spaceX);
    UIButton *endBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    endBtn.tag = 12;
    endBtn.frame = CGRectMake(xAxis, yAxis, btnW, btnW);
    [endBtn setTitle:@"结束" forState:UIControlStateNormal];
    [endBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [endBtn setBackgroundImage:[UIImage imageNamed:@"login_loginBtn.png" bundle:DFHImageResourceBundle_Login] forState:UIControlStateNormal];
    [endBtn setBackgroundImage:[UIImage imageNamed:@"login_loginSelectedBtn.png" bundle:DFHImageResourceBundle_Login] forState:UIControlStateSelected];
    [endBtn addTarget:self action:@selector(tapBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:endBtn];
    
    playBtn.titleLabel.font = [UIFont boldSystemFontOfSize:25];
    registerBtn.titleLabel.font = [UIFont boldSystemFontOfSize:25];
    endBtn.titleLabel.font = [UIFont boldSystemFontOfSize:25];
    
    NSString *shortVersionString = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
    //获得build号：
    //[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
    UILabel *versionNumLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, DFHScreenH - 30, 100, 30)];
    versionNumLabel.text = [NSString stringWithFormat:@"Version:%@",shortVersionString];
    versionNumLabel.adjustsFontSizeToFitWidth = YES;
    versionNumLabel.backgroundColor = [UIColor clearColor];
    versionNumLabel.textColor = [UIColor lightGrayColor];
    [self.view addSubview:versionNumLabel];
}

- (void)tapBtnAction:(UIButton *)btn
{
    if(btn.tag == 12)
    {
        [self exitApplication];
    }
    else if(btn.tag == 10)  //游玩
    {
        if (DFHSharedDataManager.isLogin) {  //已登录,直接进入选择邀请码界面
            DFHInvitationCodeSelectionController *controller = [[DFHInvitationCodeSelectionController alloc]init];
            [self.navigationController pushViewController:controller animated:YES];
        }
        else  //未登录,进入登录几面
        {
            DFHRegisterViewController *controller = [[DFHRegisterViewController alloc]init];
            controller.type = LoginListType;
            [self.navigationController pushViewController:controller animated:YES];
        }
    }
    else if (btn.tag ==11)  //注册
    {
        DFHRegisterViewController *controller = [[DFHRegisterViewController alloc]init];
        controller.type =  RegisterListType;
        [self.navigationController pushViewController:controller animated:YES];
    }
}

- (void)exitApplication { //退出app
    DFHAppDelegate *app = (DFHAppDelegate *)[UIApplication sharedApplication].delegate;
    UIWindow *window = app.window;
    [UIView animateWithDuration:0.3f animations:^{
        window.alpha = 0;
        window.frame = CGRectMake(0, window.bounds.size.width, 0, 0);
    } completion:^(BOOL finished) {
        exit(0);
    }];
}

@end
