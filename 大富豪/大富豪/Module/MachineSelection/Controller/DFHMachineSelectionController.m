//
//  DFHMachineSelectionController.m
//  大富豪
//
//  Created by Louis on 2016/10/25.
//  Copyright © 2016年 Louis. All rights reserved.
//

static NSString *collectionCellID = @"collectionCellID";

#import "DFHMachineSelectionController.h"
#import "DFHMachineSelectionCollectionCell.h"
#import "DFHGameMainInterFaceController.h"

@interface DFHMachineSelectionController ()<UICollectionViewDelegate,UICollectionViewDataSource>
{
    DFHHttpRequest *_httpRequest;
}
@property(nonatomic,retain)UILabel *playerTypeLabel;
@property(nonatomic,retain)UIImageView *bgImageView;
@property(nonatomic,retain)UICollectionView *collectionView;
@property(nonatomic,retain)NSMutableArray *dataArray;
@property(nonatomic,retain)NSDictionary *memberInfo;

@end

@implementation DFHMachineSelectionController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    __weak typeof(self) weakSelf = self;
    [_httpRequest postWithURLString:[DFHRequestDataInterface makeRequestMemberMachineList:@"731"] parameters:nil success:^(id responseObject) {
        NSDictionary *dataDic = [JSONFormatFunc convertDictionary:responseObject];
        if ([dataDic isValidDictionary]) {
            NSString *code = [JSONFormatFunc strValueForKey:@"code" ofDict:dataDic];
            if ([code isEqualToString:@"0"]) {
                NSArray*result = [JSONFormatFunc arrayValueForKey:@"result" ofDict:dataDic];
                if ([result isValidArray]) {
                   [weakSelf.dataArray removeAllObjects];
                    [weakSelf.dataArray addObjectsFromArray:result];
                    [weakSelf resetCollectViewFrame];
                    [weakSelf.collectionView reloadData];
                }
            }
            else if([code isEqualToString:@"-1"])
            {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示信息" message:[JSONFormatFunc strValueForKey:@"msg" ofDict:dataDic] delegate:nil cancelButtonTitle:@"确认" otherButtonTitles:nil];
            [alert show];
            }
        }
    } failure:^(NSError *error) {
        
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    self.nickName = @"体验玩家";
    [self prepareData];
    [self configUI];
}

- (void)prepareData
{
    _httpRequest = [[DFHHttpRequest alloc]init];
    _dataArray = [[NSMutableArray alloc]init];
}

-(void)configUI
{
    CGFloat btnW = 90;
    CGFloat labelH = 30;
    CGFloat xSpace = 30;
    CGFloat ySpace = 10;
    CGFloat contentW = btnW*3 + xSpace*2;
    CGFloat lableW = contentW/3;
    CGFloat xStart = (DFHScreenW - contentW)/2;
    CGFloat yStart = (DFHScreenH - btnW)/2 - labelH - ySpace;
    CGFloat yAxis = yStart;
    _bgImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, DFHScreenW, DFHScreenH)];
    _bgImageView.userInteractionEnabled = YES;
    _bgImageView.center = self.view.center;
    _bgImageView.image = [UIImage imageNamed:@"login_bg.png" bundle:DFHImageResourceBundle_Login];
    [self.view addSubview:_bgImageView];

    _playerTypeLabel = [[UILabel alloc]initWithFrame:CGRectMake(xStart, yAxis, lableW, labelH)];
    _playerTypeLabel.text = _nickName;
    _playerTypeLabel.textAlignment = NSTextAlignmentRight;
    _playerTypeLabel.textColor = [UIColor redColor];
    [_bgImageView addSubview:_playerTypeLabel];
    UILabel *tipLabel = [[UILabel alloc]initWithFrame:CGRectMake(xStart + lableW*2, yAxis, lableW, labelH)];
    tipLabel.text = @"请选择机台";
    tipLabel.textAlignment = NSTextAlignmentLeft;
    tipLabel.textColor = [UIColor redColor];
    [_bgImageView addSubview:tipLabel];
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
    [_collectionView registerClass:[DFHMachineSelectionCollectionCell class] forCellWithReuseIdentifier:collectionCellID];
    yAxis += (btnW + 5);
    UIButton *backHomeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backHomeBtn.frame = CGRectMake((DFHScreenW - 150)/2, yAxis,150, 40);
    [backHomeBtn setImage:[UIImage imageNamed:@"login_backNormal.png" bundle:DFHImageResourceBundle_Login] forState:UIControlStateNormal];
        [backHomeBtn setImage:[UIImage imageNamed:@"login_backSelected.png" bundle:DFHImageResourceBundle_Login] forState:UIControlStateSelected];
    [backHomeBtn addTarget:self action:@selector(backHomeAction:) forControlEvents:UIControlEventTouchUpInside];
    [_bgImageView addSubview:backHomeBtn];
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
}

- (void)backHomeAction:(UIButton *)btn
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)requestMemberChoiceMachine:(NSString *)memberId machineId:(NSString *)machineId
{
    __weak typeof(self) weakSelf = self;
    NSString *urlStr = [DFHRequestDataInterface makeRequestMemberChoiceMachine:memberId machineId:machineId];
    [_httpRequest postWithURLString:urlStr parameters:nil success:^(id responseObject) {
    [weakSelf hideHudDefault];
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            NSString *code = [JSONFormatFunc strValueForKey:@"code" ofDict:responseObject];
            if ([code isEqualToString:@"0"]) {
                weakSelf.memberInfo = responseObject;
                [weakSelf requestMachineSeting:machineId];
            }
            else if([code isEqualToString:@"-1"])
            {
                [weakSelf showAlertViewTip:[JSONFormatFunc strValueForKey:@"msg" ofDict:responseObject]];
            }
        }
    } failure:^(NSError *error) {
        [weakSelf hideHudDefault];
    }];
    [self showHudWithAnimation:YES];
}

- (void)requestMachineSeting:(NSString *)machineId
{
    __weak typeof(self) weakSelf = self;
    NSString *urlStr = [DFHRequestDataInterface makeRequestMachineSeting:machineId];
    [_httpRequest postWithURLString:urlStr parameters:nil success:^(id responseObject) {
    [weakSelf hideHudDefault];
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            NSString *code = [JSONFormatFunc strValueForKey:@"code" ofDict:responseObject];
            if ([code isEqualToString:@"0"]) {
                DFHGameMainInterFaceController *controller = [[DFHGameMainInterFaceController alloc]init];
                controller.memberInfo = weakSelf.memberInfo;
                controller.machinesetInfo = responseObject;
                controller.machineId = machineId;
                [weakSelf.navigationController pushViewController:controller animated:YES];
            }
            else if([code isEqualToString:@"-1"])
            {
                [weakSelf showAlertViewTip:[JSONFormatFunc strValueForKey:@"msg" ofDict:responseObject]];
            }
        }
    } failure:^(NSError *error) {
    [weakSelf hideHudDefault];
    }];
    [self showHudWithAnimation:YES];
}

- (void)showAlertViewTip:(NSString *)tipStr
{
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:tipStr delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
    [alert show];
}
#pragma mark -- UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _dataArray.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    DFHMachineSelectionCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:collectionCellID forIndexPath:indexPath];
    [cell fillDataWithDic:_dataArray[indexPath.row]];
    return cell;
}

#pragma mark -- UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dic = [JSONFormatFunc dictionaryValueForKey:@"machineInfo" ofDict:self.dataArray[indexPath.row]];
    [self requestMemberChoiceMachine:[DFHDataManager sharedInstance].loginInfo.id machineId:[JSONFormatFunc strValueForKey:@"id" ofDict:dic]];
}

@end
