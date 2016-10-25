//
//  DFHSmartUtility.h
//  大富豪
//
//  Created by Louis on 2016/10/24.
//  Copyright © 2016年 Louis. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSObject (Trace)

//转成安全的数据
-(NSString*)toValidString;
//有效的字符串定义为类型是字符串并且长度>1
-(BOOL)isValidString;
//有效的数据定义为类型是数据并且长度>1
-(BOOL)isValidArray;
//有效的数据定义为字典而且长度>1
-(BOOL)isValidDictionary;

@end

@interface UIView (Util)

@property(nonatomic,assign) CGFloat originX;
@property(nonatomic,assign) CGFloat originY;
@property(nonatomic,assign) CGPoint originPoint;
@property(nonatomic,assign) CGFloat centerX;
@property(nonatomic,assign) CGFloat centerY;
@property(nonatomic,assign) CGFloat sizeWidth;
@property(nonatomic,assign) CGFloat sizeHeight;
@property(nonatomic,assign) CGSize  sizeWH;
@property(nonatomic,assign) CGFloat cornerRadius;
@property(nonatomic,assign) UIColor *borderColor;
@property(nonatomic,assign) CGFloat borderWidth;

@property(nonatomic,assign,readonly) CGPoint rightBottomCorner;

-(UIImage *)shortCutImage;
-(void)traceString:(NSString*)str;
-(UIColor*)deepColor;

-(void)placeAt:(UIView*)view;
-(void)dumpView;
-(NSString *)dumpString;
-(void)highlightSubviewsWithColor:(UIColor*)color;
-(void)highlightSubviews;
-(void)highlightViewLayers;
+(UIView*)viewWithFrame:(CGRect)frame;
//获取屏幕的尺寸，在ios7中[UIScreen mainScreen].bounds是固定不变的值，在ios8中是随横竖屏改变的
- (CGSize)screenSize;

@end


@interface UIWebView (Utility)

-(NSString*)currentUrl;
-(NSString*)currentTitle;

@end

@interface UILabel (Util)

+(UILabel*)labelWithText:(NSString*)text fontSize:(int)size color:(UIColor*)color;
-(void)setFitText:(NSString*)text baseFont:(CGFloat)font;
-(void)setFitSuperView:(NSString *)text baseFont:(CGFloat)font;

@end

@interface UIColor (Util)

+(UIColor *)randomColor;
+(UIColor *)color255WithRed:(int)red green:(int)green blue:(int)blue;
+(UIColor *)getColor:(NSString *)hexColor;

@end

@interface UIImage (Util)

+(UIImage*)imageWithColor:(UIColor *)color;
+(UIImage*)imageWithColor:(UIColor *)color size:(CGSize)size alpha:(CGFloat)alpha;
//NonCachable image getter from bundle
+ (UIImage *)imageNamed:(NSString *)name bundle:(NSBundle *)bundle;
//NonCachable image getter from main bundle
+ (UIImage *)bundleImageNamed:(NSString *)name;
-(UIImage*)scaledImageToSize:(CGSize)newSize;
-(UIImage*)retinaImage;
-(UIImage*)resizedImageWithLeftCap:(float)x topCap:(float)y;
-(UIImage*)centerResizeImage;
+(UIImage*)imageForCurrentScreen;
-(UIImage*)fillImageWithColor:(UIColor*)color;

@end
@interface NSString (Util)

-(NSString*)cnNumber;
- (NSDictionary *)queryStringToDic;
- (NSDictionary *)queryParamToDic;

-(NSString*)md5String;

-(BOOL)isValidPhoneNumber;

//替换系统的string，防止用他出错
- (BOOL)hasString:(NSString *)subString;
@end
