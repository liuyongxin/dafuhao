#import <UIKit/UIKit.h>
//自定义日历控件

@protocol CKCalendarDelegate;

@interface CKCalendarView : UIView

enum {
    startSunday = 1,
    startMonday = 2,
};
typedef int startDay;  //每个星期开始时间

@property (nonatomic, strong) NSDate *selectedDate;
@property (nonatomic, weak) id<CKCalendarDelegate> delegate;

- (id)initWithStartDay:(startDay)firstDay;
- (id)initWithStartDay:(startDay)firstDay frame:(CGRect)frame;

// Theming
- (void)setTitleFont:(UIFont *)font;
- (UIFont *)titleFont;

- (void)setTitleColor:(UIColor *)color;
- (UIColor *)titleColor;

- (void)setButtonColor:(UIColor *)color;

- (void)setInnerBorderColor:(UIColor *)color;

- (void)setDayOfWeekFont:(UIFont *)font;
- (UIFont *)dayOfWeekFont;

- (void)setDayOfWeekTextColor:(UIColor *)color;
- (UIColor *)dayOfWeekTextColor;

- (void)setDayOfWeekBottomColor:(UIColor *)bottomColor topColor:(UIColor *)topColor;

- (void)setDateFont:(UIFont *)font;
- (UIFont *)dateFont;

- (void)setDateTextColor:(UIColor *)color;
- (UIColor *)dateTextColor;

- (void)setDateBackgroundColor:(UIColor *)color;
- (UIColor *)dateBackgroundColor;

- (void)setDateBorderColor:(UIColor *)color;
- (UIColor *)dateBorderColor;

@property (nonatomic, strong) UIColor *selectedDateTextColor;
@property (nonatomic, strong) UIColor *selectedDateBackgroundColor;
@property (nonatomic, strong) UIColor *currentDateTextColor;
@property (nonatomic, strong) UIColor *currentDateBackgroundColor;
@property(nonatomic,  assign)BOOL isShow;
- (void)show:(BOOL )animated;
- (void)showInView:(UIView *)targetView animated:(BOOL )animated;
- (void)dismiss:(BOOL )animated;

@end

@protocol CKCalendarDelegate <NSObject>

- (void)calendar:(CKCalendarView *)calendar didSelectDate:(NSDate *)date;

@end
