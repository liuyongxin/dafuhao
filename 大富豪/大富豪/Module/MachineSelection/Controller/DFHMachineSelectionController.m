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

@interface DFHMachineSelectionController ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property(nonatomic,retain)UILabel *playerTypeLabel;
@property(nonatomic,retain)UIImageView *bgImageView;
@property(nonatomic,retain)UICollectionView *collectionView;
@property(nonatomic,retain)NSMutableArray *dataArray;

@end

@implementation DFHMachineSelectionController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    [self preperaData];
    [self configUI];
}

- (void)preperaData
{
    _dataArray = [[NSMutableArray alloc]init];
    for (int i=0; i<10; i++) {
        NSDictionary *dic = @{@"num":@(i*1000),@"name":[NSString stringWithFormat:@"机台%d",i],@"scale":@(i)};
        [_dataArray addObject:dic];
    }
}

-(void)configUI
{
    CGFloat bgW = 428;
    CGFloat bgH = 254;
    CGFloat btnW = 121;
    _bgImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, bgW, bgH)];
    _bgImageView.userInteractionEnabled = YES;
    _bgImageView.center = self.view.center;
    _bgImageView.image = [UIImage imageNamed:@"login_bg.png" bundle:DFHImageResourceBundle_Login];
    [self.view addSubview:_bgImageView];
    
    CGFloat space = 15;
    CGFloat yAxis = space;
    _playerTypeLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, yAxis, bgW/2, 30)];
    _playerTypeLabel.text = @"体验玩家";
    _playerTypeLabel.textAlignment = NSTextAlignmentCenter;
    _playerTypeLabel.textColor = [UIColor redColor];
    [_bgImageView addSubview:_playerTypeLabel];
    
    UILabel *tipLabel = [[UILabel alloc]initWithFrame:CGRectMake(bgW/2, yAxis, bgW/2, 30)];
    tipLabel.text = @"请选择机台";
    tipLabel.textAlignment = NSTextAlignmentCenter;
    tipLabel.textColor = [UIColor redColor];
    [_bgImageView addSubview:tipLabel];
    yAxis += (30 + space);
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.minimumLineSpacing =  (bgW - btnW*3 - space*2)/2;
    layout.itemSize = CGSizeMake(btnW   , btnW);
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(space, yAxis, bgW - 2*space,btnW) collectionViewLayout:layout];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.backgroundColor = [UIColor clearColor];
    [_bgImageView addSubview:_collectionView];
    [_collectionView registerClass:[DFHMachineSelectionCollectionCell class] forCellWithReuseIdentifier:collectionCellID];
    yAxis += (btnW + space);
    UIButton *backHomeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backHomeBtn.frame = CGRectMake((bgW - 158.5)/2, yAxis,158.5, 42);
    [backHomeBtn setImage:[UIImage imageNamed:@"login_back.png" bundle:DFHImageResourceBundle_Login] forState:UIControlStateNormal];
    [backHomeBtn addTarget:self action:@selector(backHomeAction:) forControlEvents:UIControlEventTouchUpInside];
    [_bgImageView addSubview:backHomeBtn];
    
}

- (void)backHomeAction:(UIButton *)btn
{
    [self dismissViewControllerAnimated:NO completion:nil];
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

}

@end
