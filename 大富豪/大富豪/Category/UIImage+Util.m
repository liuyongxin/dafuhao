//
//  UIImage+Util.m
//  大富豪
//
//  Created by Louis on 16/6/29.
//  Copyright © 2016年 大富豪. All rights reserved.
//

#import "UIImage+Util.h"

@implementation UIImage (Util)
-(UIImage*)fillImageWithColor:(UIColor*)color
{
    CGRect rect = CGRectMake(0, 0, self.size.width, self.size.height);
    UIGraphicsBeginImageContextWithOptions(rect.size, NO,[UIScreen mainScreen].scale);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    
    // translate/flip the graphics context (for transforming from CG* coords to UI* coords
    CGContextTranslateCTM(context, 0, self.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    
    CGContextClipToMask(context, rect, self.CGImage);
    
    CGContextFillRect(context, rect);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return img;
}

-(UIImage*)scaledImageToSize:(CGSize)newSize
{
    UIGraphicsBeginImageContext(newSize);
    [self drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}

+(UIImage *)imageForCurrentScreen
{
    UIWindow *screenWindow = [[UIApplication sharedApplication] keyWindow];
    UIGraphicsBeginImageContextWithOptions(screenWindow.frame.size, YES,[UIScreen mainScreen].scale);
    UIGraphicsBeginImageContext(screenWindow.frame.size);//全屏截图，包括window
    [screenWindow.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return viewImage;
}

+(UIImage*)imageWithColor:(UIColor *)color
{
    CGSize size = CGSizeMake(1, 1);
    UIGraphicsBeginImageContextWithOptions(size, NO, 1);
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    CGContextSetAlpha(ctx, 1);
    
    CGContextSetFillColorWithColor(ctx, [color CGColor]);
    
    CGContextAddRect(ctx, CGRectMake(0, 0, size.width, size.height));
    
    CGContextDrawPath(ctx, kCGPathFill);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return image;
}

+(UIImage*)imageWithColor:(UIColor *)color size:(CGSize)size alpha:(CGFloat)alpha
{
    UIGraphicsBeginImageContextWithOptions(size, NO, 1);
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    CGContextSetAlpha(ctx, alpha);
    
    CGContextSetFillColorWithColor(ctx, [color CGColor]);
    
    CGContextAddRect(ctx, CGRectMake(0, 0, size.width, size.height));
    
    CGContextDrawPath(ctx, kCGPathFill);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return image;
}

+ (UIImage *)imageNamed:(NSString *)name bundle:(NSBundle *)bundle
{
    NSString *p = [NSString stringWithFormat:@"%@/%@",[bundle bundlePath], name];
    return [UIImage imageWithContentsOfFile:p];
}
+ (UIImage *)bundleImageNamed:(NSString *)name
{
    return [self imageNamed:name bundle:[NSBundle mainBundle]];
}

-(UIImage*)retinaImage
{
    CGImageRef cgimage  = self.CGImage;
    return [UIImage imageWithCGImage:cgimage scale:2.0 orientation:UIImageOrientationUp];
}
-(UIImage*)resizedImageWithLeftCap:(float)x topCap:(float)y
{
    if([self respondsToSelector:@selector(resizableImageWithCapInsets:)]){
        return [self resizableImageWithCapInsets:UIEdgeInsetsMake(y, x, y+1, x+1)];
    }
    else{
        return [self stretchableImageWithLeftCapWidth:x topCapHeight:y];
    }
}
-(UIImage*)centerResizeImage
{
    CGSize size = self.size;
    return [self resizedImageWithLeftCap:ceilf(size.width*.5) topCap:ceilf(size.height*.5)];
}
@end
