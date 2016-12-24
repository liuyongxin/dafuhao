//
//  DFHInvitationCodeSelectionController.m
//  大富豪
//
//  Created by Louis on 2016/10/25.
//  Copyright © 2016年 Louis. All rights reserved.
//

static NSString *collectionCellID = @"collectionCellID";

#import "DFHInvitationCodeSelectionController.h"
#import "DFHInvitationCodeSelectionCollectionCell.h"
#import "DFHGameMainInterFaceController.h"
#import "DFHMachineSelectionController.h"

@interface DFHInvitationCodeSelectionController ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property(nonatomic,retain)UIImageView *bgImageView;
@property(nonatomic,retain)UICollectionView *collectionView;
@property(nonatomic,retain)NSMutableArray *dataArray;
@property(nonatomic,retain)NSDictionary *memberInfo;

@end

@implementation DFHInvitationCodeSelectionController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [_dataArray removeAllObjects];
    NSString *codeNumber = @"731";
    if ([DFHSharedDataManager.loginInfo.codeNumber isValidString]) {
        codeNumber = DFHSharedDataManager.loginInfo.codeNumber;
    }
    [_dataArray addObjectsFromArray:@[codeNumber,@"体验帐号"]];
    [self resetCollectViewFrame];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    [self prepareData];
    [self configUI];
}

- (void)prepareData
{
    _dataArray = [[NSMutableArray alloc]init];
}

-(void)configUI
{
    CGFloat btnW = 90;
    CGFloat labelH = 30;
    CGFloat xSpace = 30;
    CGFloat ySpace = 10;
    CGFloat contentW = btnW*3 + xSpace*2;
    CGFloat xStart = (DFHScreenW - contentW)/2;
    CGFloat yStart = (DFHScreenH - btnW)/2 - labelH - ySpace;
    CGFloat yAxis = yStart;
    _bgImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, DFHScreenW, DFHScreenH)];
    _bgImageView.userInteractionEnabled = YES;
    _bgImageView.center = self.view.center;
    _bgImageView.image = [UIImage imageNamed:@"login_bg.png" bundle:DFHImageResourceBundle_Login];
    [self.view addSubview:_bgImageView];
    
    UILabel *tipLabel = [[UILabel alloc]initWithFrame:CGRectMake((DFHScreenW - 150)/2, yAxis, 150, labelH)];
    tipLabel.text = @"请选择机台";
    tipLabel.textAlignment = NSTextAlignmentCenter;
    tipLabel.textColor = [UIColor blackColor];
    [self.view addSubview:tipLabel];
    yAxis += labelH + ySpace;
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.minimumLineSpacing =  xSpace;
    layout.itemSize = CGSizeMake(btnW   , btnW);
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(xStart, yAxis, contentW,btnW) collectionViewLayout:layout];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.backgroundColor = [UIColor clearColor];
    [_bgImageView addSubview:_collectionView];
    [_collectionView registerClass:[DFHInvitationCodeSelectionCollectionCell class] forCellWithReuseIdentifier:collectionCellID];
    yAxis += btnW + ySpace;
    
    UIButton *backHomeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backHomeBtn.frame = CGRectMake((DFHScreenW - 150)/2, yAxis,150, 40);
    [backHomeBtn setImage:[UIImage imageNamed:@"login_backNormal.png" bundle:DFHImageResourceBundle_Login] forState:UIControlStateNormal];
        [backHomeBtn setImage:[UIImage imageNamed:@"login_backSelected.png" bundle:DFHImageResourceBundle_Login] forState:UIControlStateSelected];
    [backHomeBtn addTarget:self action:@selector(backHomeAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backHomeBtn];
}

 - (void)resetCollectViewFrame
{
    if ([_dataArray isValidArray]) {
        CGFloat btnW = 90;
        CGFloat xSpace = 30;
        CGRect rect = _collectionView.frame;
        if (_dataArray.count < 3) {
           UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout *)_collectionView.collectionViewLayout;
            rect.size.width = layout.minimumLineSpacing*(_dataArray.count - 1) + btnW*_dataArray.count;
            rect.origin.x = (DFHScreenW - rect.size.width)/2;
        }
        else
        {
           rect.size.width= btnW*3 + 2*xSpace;
        }
        _collectionView.frame = rect;
    }
    [_collectionView reloadData];
}

- (void)backHomeAction:(UIButton *)btn
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark -- UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _dataArray.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    DFHInvitationCodeSelectionCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:collectionCellID forIndexPath:indexPath];
    [cell fillDataWithStr:_dataArray[indexPath.row]];
    return cell;
}

#pragma mark -- UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    DFHMachineSelectionController *controller = [[DFHMachineSelectionController alloc]init];
    if (indexPath.row == 0) {  //会员
        controller.type = MemberIntoType;
        controller.code = [DFHDataManager sharedInstance].loginInfo.codeNumber;
    }
    else  //游客
    {
        controller.type = TouristsIntoType;
        controller.code = nil;
    }
    [self.navigationController pushViewController:controller animated:YES];
}

@end
