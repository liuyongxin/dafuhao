//
//  RecordView.h
//  大富豪
//
//  Created by Louis on 2016/11/2.
//  Copyright © 2016年 Louis. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RecordView : UIView

- (void)assignmentBetPoints:(NSInteger )num;
- (void)refreshRecordData:(NSArray *)dataArray;

@end

@interface RecordViewCell : UITableViewCell

@property(nonatomic,retain)UILabel *titleLabel;

@end
