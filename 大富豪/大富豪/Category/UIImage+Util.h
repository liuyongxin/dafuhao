//
//  UIImage+Util.h
//  大富豪
//
//  Created by Louis on 16/6/29.
//  Copyright © 2016年 大富豪. All rights reserved.
//

#import <UIKit/UIKit.h>

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
