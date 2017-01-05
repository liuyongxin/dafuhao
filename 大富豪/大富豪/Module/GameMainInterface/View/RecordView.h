//
//  RecordView.h
//  大富豪
//
//  Created by Louis on 2016/11/2.
//  Copyright © 2016年 Louis. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RecordView : UIView

@property(nonatomic,copy)void(^cancelBetPointsAction)(UIButton *);  //取消押分
@property(nonatomic,copy)void(^switchBetPointsAction)(UIButton *);  //切换最低押分

- (void)assignmentBetPoints:(NSInteger )num;
- (void)refreshRecordData:(NSArray *)dataArray;

@end

@interface RecordViewCell : UITableViewCell

@property(nonatomic,retain)UILabel *titleLabel;

@end
