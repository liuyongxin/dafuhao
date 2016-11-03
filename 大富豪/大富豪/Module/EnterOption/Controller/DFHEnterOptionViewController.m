//
//  DFHEnterOptionViewController.m
//  大富豪
//
//  Created by Louis on 2016/10/24.
//  Copyright © 2016年 Louis. All rights reserved.
//

#import "DFHEnterOptionViewController.h"
#import "DFHMachineSelectionController.h"
#import "DFHRegisterViewController.h"
#import "DFHGameMainInterFaceController.h"

@interface DFHEnterOptionViewController ()

@property(nonatomic,retain)UIImageView *bgImageView;

@end

@implementation DFHEnterOptionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    // Do any additional setup after loading the view.
    [self configUI];
}

- (void)configUI
{
    CGFloat bgW = 400 * DFHSizeMinRatio;
    CGFloat bgH = 208 * DFHSizeMinRatio;
    CGFloat btnW = 100;
    _bgImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, bgW, bgH)];
    _bgImageView.userInteractionEnabled = YES;
    _bgImageView.center = self.view.center;
    _bgImageView.image = [UIImage imageNamed:@"login_bg.png" bundle:DFHImageResourceBundle_Login];
    [self.view addSubview:_bgImageView];
    
    CGFloat spaceX = 50.0;
    CGFloat xAxis = (bgW - btnW*2 - spaceX)/2;
    CGFloat yAxis = (bgH - btnW)/2;
    
    UIButton *playBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    playBtn.tag = 10;
    playBtn.frame = CGRectMake(xAxis, yAxis, btnW, btnW);
    [playBtn setTitle:@"游玩" forState:UIControlStateNormal];
    [playBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [playBtn setBackgroundImage:[UIImage imageNamed:@"login_loginBtn.png" bundle:DFHImageResourceBundle_Login] forState:UIControlStateNormal];
    [playBtn addTarget:self action:@selector(tapBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [_bgImageView addSubview:playBtn];
    
    xAxis +=(btnW+spaceX);
    
    UIButton *registerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    registerBtn.tag = 11;
    registerBtn.frame = CGRectMake(xAxis, yAxis, btnW, btnW);
    [registerBtn setTitle:@"注册" forState:UIControlStateNormal];
    [registerBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [registerBtn setBackgroundImage:[UIImage imageNamed:@"login_loginBtn.png" bundle:DFHImageResourceBundle_Login] forState:UIControlStateNormal];
    [registerBtn addTarget:self action:@selector(tapBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [_bgImageView addSubview:registerBtn];
    
    playBtn.titleLabel.font = [UIFont systemFontOfSize:25];
    registerBtn.titleLabel.font = [UIFont systemFontOfSize:25];
}

 - (void)tapBtnAction:(UIButton *)btn
{
    DFHRegisterViewController *controller = [[DFHRegisterViewController alloc]init];
    if (btn.tag == 10) {
        controller.type = LoginListType;
    }
    else if (btn.tag ==11)
    {
        controller.type =  RegisterListType;
    }
    [self presentViewController:controller animated:NO completion:nil];
}

@end
