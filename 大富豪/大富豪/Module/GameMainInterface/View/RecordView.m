//
//  RecordView.m
//  大富豪
//
//  Created by Louis on 2016/11/2.
//  Copyright © 2016年 Louis. All rights reserved.
//

#import "RecordView.h"
#import "DFHRecordCollectionViewCell.h"

static NSString *collectionCellID = @"collectionCellID";
static NSString *headerViewID = @"headerViewID";
@interface RecordView()<UICollectionViewDelegate,UICollectionViewDataSource,UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>

@property(nonatomic,retain)UIImageView *bgImageView;
@property(nonatomic,retain)UICollectionView *mCollectionView;
@property(nonatomic,retain)NSMutableArray *dataArray;
@property(nonatomic,retain)UITableView *mTableView;
@property(nonatomic,retain)UILabel   *minimumBetPointsLabel; //最小押分
@property(nonatomic,retain)UILabel *betPointsLabel;                   //押分

@end

@implementation RecordView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self prepareData];
        [self configUI];
    }
    return self;
}

- (void)prepareData
{
    _dataArray = [[NSMutableArray alloc]init];
}
- (void)configUI
{
    _bgImageView = [[UIImageView alloc]initWithFrame:self.bounds];
    _bgImageView.image = [UIImage imageNamed:@"RecordBg.png" bundle:DFHImageResourceBundle_Main];
    _bgImageView.userInteractionEnabled = YES;
    [self addSubview:_bgImageView];
    
    CGFloat bgW = self.frame.size.width;
    CGFloat cellW = 16 *DFHSizeWidthRatio;
    CGFloat cellH = 28 *DFHSizeHeightRatio;
    CGFloat xSpace = 5 *DFHSizeWidthRatio;
    CGFloat yAxis = xSpace;
    
    CGFloat collectionW = cellW * 10;
    CGFloat collectionH = cellH *5;
    CGFloat xAxis = bgW - collectionW - xSpace;
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.minimumLineSpacing =  0;
    layout.minimumInteritemSpacing = 0;
    layout.itemSize = CGSizeMake(cellW, cellH);
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    _mCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(xAxis, yAxis,collectionW,collectionH) collectionViewLayout:layout];
    _mCollectionView.delegate = self;
    _mCollectionView.dataSource = self;
    _mCollectionView.backgroundColor = [UIColor clearColor];
    _mCollectionView.bounces = NO;
    _mCollectionView.showsVerticalScrollIndicator = NO;
    [_bgImageView addSubview:_mCollectionView];
    [_mCollectionView registerClass:[DFHRecordCollectionViewCell class] forCellWithReuseIdentifier:collectionCellID];
    //注册头视图
    [_mCollectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerViewID];
    _mTableView =[[UITableView alloc]initWithFrame:CGRectMake(xSpace, yAxis,xAxis, collectionH) style:UITableViewStylePlain];
    _mTableView.delegate = self;
    _mTableView.dataSource = self;
    _mTableView.allowsSelection = NO;
    _mTableView.showsVerticalScrollIndicator = NO;
    _mTableView.backgroundColor = [UIColor clearColor];
    _mTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_bgImageView addSubview:_mTableView];
    
    CGFloat ySpace = 5;
    yAxis += collectionH + ySpace;
    xAxis = (self.frame.size.width - 24 - 70 - 24 - 52- xSpace*3)/2;
    UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    cancelBtn.frame = CGRectMake(xAxis, yAxis, 24, 24);
    [cancelBtn setBackgroundImage:[UIImage imageNamed:@"Main_ChargePoints_NormalCancel.png" bundle:DFHImageResourceBundle_Main_ChargePoints] forState:UIControlStateNormal];
    [cancelBtn setBackgroundImage:[UIImage imageNamed:@"Main_ChargePoints_SelectedCancel.png" bundle:DFHImageResourceBundle_Main_ChargePoints] forState:UIControlStateSelected];
    cancelBtn.tag = 100;
    [cancelBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    [_bgImageView addSubview:cancelBtn];
    
    xAxis += 24 + xSpace;
    UIImageView *labelBgView = [[UIImageView alloc]initWithFrame:CGRectMake(xAxis, yAxis,72, 24)];
    labelBgView.image = [UIImage imageNamed:@"Main_ChargePoints_MinBg.png" bundle:DFHImageResourceBundle_Main_ChargePoints];
    labelBgView.userInteractionEnabled = YES;
    [_bgImageView addSubview:labelBgView];
    _minimumBetPointsLabel = [[UILabel alloc]initWithFrame:CGRectMake(xAxis+1, yAxis,70, 24)];
    _minimumBetPointsLabel.text = @"最小押分: 100";
    _minimumBetPointsLabel.adjustsFontSizeToFitWidth = YES;
    _minimumBetPointsLabel.textAlignment = NSTextAlignmentCenter;
    _minimumBetPointsLabel.textColor = [UIColor redColor];
    _minimumBetPointsLabel.font = [UIFont boldSystemFontOfSize:13];
    [_bgImageView addSubview:_minimumBetPointsLabel];
    
    xAxis += 70 + xSpace;
    UIButton *changeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    changeBtn.frame = CGRectMake(xAxis, yAxis, 24, 24);
    [changeBtn setBackgroundImage:[UIImage imageNamed:@"Main_ChargePoints_NormalChange.png" bundle:DFHImageResourceBundle_Main_ChargePoints] forState:UIControlStateNormal];
    [changeBtn setBackgroundImage:[UIImage imageNamed:@"Main_ChargePoints_SelectedChange.png" bundle:DFHImageResourceBundle_Main_ChargePoints] forState:UIControlStateSelected];
    changeBtn.tag = 101;
    [changeBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    [_bgImageView addSubview:changeBtn];
    
    xAxis += 24 + xSpace;
    UIImageView *labelBgView2 = [[UIImageView alloc]initWithFrame:CGRectMake(xAxis, yAxis+2,52, 20)];
    labelBgView2.image = [UIImage imageNamed:@"Main_ChargePoints_Bg.png" bundle:DFHImageResourceBundle_Main_ChargePoints];
    labelBgView2.userInteractionEnabled = YES;
    [_bgImageView addSubview:labelBgView2];
    _betPointsLabel = [[UILabel alloc]initWithFrame:CGRectMake(xAxis+1, yAxis+2,50, 20)];
    _betPointsLabel.text = @"0 0 0 0";
    _betPointsLabel.textAlignment = NSTextAlignmentCenter;
    _betPointsLabel.textColor = [UIColor redColor];
    _betPointsLabel.font = [UIFont boldSystemFontOfSize:13];
    [_bgImageView addSubview:_betPointsLabel];
    
}

- (void)btnAction:(UIButton *)btn
{
    if (btn.tag == 100) { //取消
        
    }
    else if (btn.tag == 101)//切换
    {
        NSInteger n = rand()%1000;
        [self assignmentBetPoints:n];
    }
}

- (void)assignmentBetPoints:(NSInteger )num
{
    NSString *str = [NSString stringWithFormat:@"%04ld",(long)num];
    if (str.length == 4) {
        NSMutableString *text =[NSMutableString string];
        for (int i = 0; i<4; i++) {
            [text appendString:[str substringWithRange:NSMakeRange(i, 1)]];
            if (i<3) {
            [text appendString:@" "];
            }
        }
        _betPointsLabel.text = text;
    }
}

- (void)refreshRecordData:(NSArray *)dataArray
{
    [self.dataArray removeAllObjects];
    [self.dataArray addObjectsFromArray:dataArray];
    [self.mCollectionView reloadData];
}
#pragma mark -- UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 10;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 10;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    DFHRecordCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:collectionCellID forIndexPath:indexPath];
    [cell clearColorImage];
    NSInteger n = indexPath.section * 10;
    if (n + indexPath.row < self.dataArray.count) {
        NSDictionary *dataDic = self.dataArray[n + indexPath.row];
        [cell assignmentColour:[JSONFormatFunc strValueForKey:@"color" ofDict:dataDic] number:[JSONFormatFunc strValueForKey:@"num" ofDict:dataDic]];
    }
    return cell;
}

#pragma UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID=@"cellID";
    RecordViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil)
    {
        cell = [[RecordViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.backgroundColor = [UIColor clearColor];
    }
    cell.titleLabel.text = [NSString stringWithFormat:@"%ld1",(long)indexPath.row];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 28 *DFHSizeHeightRatio;
}
#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView == _mCollectionView) {
        _mTableView.contentOffset = _mCollectionView.contentOffset;
    }
    else if (scrollView == _mTableView)
    {
        _mCollectionView.contentOffset = _mTableView.contentOffset;
    }
}
@end

@interface RecordViewCell ()

@end

@implementation RecordViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 14, 24,14)];
        _titleLabel.textColor  = [UIColor redColor];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.font = [UIFont boldSystemFontOfSize:13];
        _titleLabel.adjustsFontSizeToFitWidth = YES;
        [self.contentView addSubview:_titleLabel];
    }
    return self;
}

@end
