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

@end

@implementation DFHMachineSelectionController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    __weak typeof(self) weakSelf = self;
    [_httpRequest postWithURLString:[DFHRequestDataInterface makeRequestMemberMachineList:@"731M"] parameters:nil success:^(id responseObject) {
        NSDictionary *dataDic = [JSONFormatFunc convertDictionary:responseObject];
        if ([dataDic isValidDictionary]) {
            NSString *code = [JSONFormatFunc strValueForKey:@"code" ofDict:dataDic];
            if ([code isEqualToString:@"0"]) {
                NSArray*result = [JSONFormatFunc arrayValueForKey:@"result" ofDict:dataDic];
                if ([result isValidArray]) {
                   [weakSelf.dataArray removeAllObjects];
                    [weakSelf.dataArray addObjectsFromArray:result];
                    [weakSelf.dataArray addObjectsFromArray:result];
                    [weakSelf.collectionView reloadData];
                    [weakSelf resetCollectViewFrame];
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
    [self preperaData];
    [self configUI];
}

- (void)preperaData
{
    _httpRequest = [[DFHHttpRequest alloc]init];
    _dataArray = [[NSMutableArray alloc]init];
}

-(void)configUI
{
    CGFloat bgW = 400 * DFHSizeMinRatio;
    CGFloat bgH = 208 * DFHSizeMinRatio;
    CGFloat btnW = 100;
    _bgImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, bgW, bgH)];
    _bgImageView.userInteractionEnabled = YES;
    _bgImageView.center = self.view.center;
    _bgImageView.image = [UIImage imageNamed:@"login_bg.png" bundle:DFHImageResourceBundle_Login];
    [self.view addSubview:_bgImageView];
    
    CGFloat space = 15;
    CGFloat yAxis = space;
    _playerTypeLabel = [[UILabel alloc]initWithFrame:CGRectMake(space, yAxis, bgW/2 - 2*space, 30)];
    _playerTypeLabel.text = @"体验玩家";
    _playerTypeLabel.textAlignment = NSTextAlignmentCenter;
    _playerTypeLabel.textColor = [UIColor redColor];
    [_bgImageView addSubview:_playerTypeLabel];
    
    UILabel *tipLabel = [[UILabel alloc]initWithFrame:CGRectMake(space + bgW/2, yAxis, bgW/2 - 2*space, 30)];
    tipLabel.text = @"请选择机台";
    tipLabel.textAlignment = NSTextAlignmentCenter;
    tipLabel.textColor = [UIColor redColor];
    [_bgImageView addSubview:tipLabel];
    yAxis += (30 + space);
    
    CGFloat xSpace = 30;
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.minimumLineSpacing =  (bgW - btnW*3 - xSpace*2)/2;
    layout.itemSize = CGSizeMake(btnW   , btnW);
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(xSpace, yAxis, bgW - 2*xSpace,btnW) collectionViewLayout:layout];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.backgroundColor = [UIColor clearColor];
    [_bgImageView addSubview:_collectionView];
    [_collectionView registerClass:[DFHMachineSelectionCollectionCell class] forCellWithReuseIdentifier:collectionCellID];
    yAxis += (btnW + space);
    UIButton *backHomeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backHomeBtn.frame = CGRectMake((bgW - 158.5)/2, yAxis,158.5, 42);
    [backHomeBtn setImage:[UIImage imageNamed:@"login_backNormal.png" bundle:DFHImageResourceBundle_Login] forState:UIControlStateNormal];
        [backHomeBtn setImage:[UIImage imageNamed:@"login_backSelected.png" bundle:DFHImageResourceBundle_Login] forState:UIControlStateSelected];
    [backHomeBtn addTarget:self action:@selector(backHomeAction:) forControlEvents:UIControlEventTouchUpInside];
    [_bgImageView addSubview:backHomeBtn];
    
}

 - (void)resetCollectViewFrame
{
    if ([_dataArray isValidArray]) {
        CGFloat bgW = 400 * DFHSizeMinRatio;
        CGFloat btnW = 100;
        CGFloat xSpace = 30;
        CGRect rect = _collectionView.frame;
        if (_dataArray.count < 3) {
           UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout *)_collectionView.collectionViewLayout;
            rect.size.width = layout.minimumLineSpacing*(_dataArray.count - 1) + btnW*_dataArray.count;
            rect.origin.x = (bgW - rect.size.width)/2;
        }
        else
        {
          rect.origin.x = xSpace;
           rect.size.width= bgW - 2*xSpace;
        }
        _collectionView.frame = rect;
    }
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
    DFHGameMainInterFaceController *controller = [[DFHGameMainInterFaceController alloc]init];
    [self presentViewController:controller animated:NO completion:nil];
}

@end
