//
//  DFHSmartUtility.m
//  大富豪
//
//  Created by Louis on 2016/10/24.
//  Copyright © 2016年 Louis. All rights reserved.
//

#import "DFHSmartUtility.h"
#import <QuartzCore/QuartzCore.h>
//#import <objc/runtime.h>
#import <CommonCrypto/CommonDigest.h>

@implementation NSObject (Trace)

-(NSString*)toValidString
{
    if ([self isValidString]) {
        return (NSString*)self;
    }else{
        return @"";
    }
}

-(BOOL)isValidString
{
    if (self) {
        if ([self isKindOfClass:[NSString class]]) {
            return [(NSString*) self length]>0;
        }
    }
    return NO;
}

-(BOOL)isValidArray
{
    if (self) {
        if ([self isKindOfClass:[NSArray class]]) {
            return [(NSArray*) self count]>0;
        }
    }
    return NO;
}

-(BOOL)isValidDictionary
{
    if (self) {
        if ([self isKindOfClass:[NSDictionary class]]) {
            return [(NSDictionary*) self count]>0;
        }
    }
    return NO;
}

@end

@implementation UIView (Util)

-(void)traceString:(NSString*)str
{
    UITextView *tv= [[UITextView alloc]initWithFrame:self.bounds];
    tv.backgroundColor = [UIColor blackColor];
    tv.textColor = [UIColor whiteColor];
    tv.font = [UIFont systemFontOfSize:12];
    [self addSubview:tv];
    [tv setText:str];
}

-(UIColor*)deepColor
{
    if (![self.superview.backgroundColor isEqual:[UIColor clearColor]]) {
        return self.superview.backgroundColor;
    }else{
        return [self.superview deepColor];
    }
}

-(UIImage *)shortCutImage
{
    UIGraphicsBeginImageContext(self.sizeWH);
    UIGraphicsBeginImageContextWithOptions(self.sizeWH, YES,[UIScreen mainScreen].scale);
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return viewImage;
}

-(void)placeAt:(UIView*)view
{
    self.frame = view.bounds;
    [view addSubview:self];
}
-(void)setCenterX:(CGFloat)x
{
    CGPoint center = self.center;
    center.x = x;
    self.center = center;
}
-(void)setCenterY:(CGFloat)y
{
    CGPoint center = self.center;
    center.y = y;
    self.center = center;
}
-(CGFloat)centerX
{
    return self.center.x;
}
-(CGFloat)centerY
{
    return self.center.y;
}
-(void)setSizeWidth:(CGFloat)sizeWidth
{
    CGRect r = self.frame;
    r.size.width = sizeWidth;
    self.frame = r;
}
-(CGFloat)sizeWidth
{
    return self.frame.size.width;
}
-(void)setSizeHeight:(CGFloat)sizeHeight
{
    CGRect r = self.frame;
    r.size.height = sizeHeight;
    self.frame = r;
}
-(CGFloat)sizeHeight
{
    return self.frame.size.height;
}
-(void)setOriginX:(CGFloat)originX
{
    CGRect r = self.frame;
    r.origin.x = originX;
    self.frame = r;
}
-(CGFloat)originX
{
    return self.frame.origin.x;
}
-(void)setOriginY:(CGFloat)originY
{
    CGRect r = self.frame;
    r.origin.y = originY;
    self.frame = r;
}
-(CGFloat)originY
{
    return self.frame.origin.y;
}
-(void)dumpView
{
    printf("%s\n",[[self tx_recursiveLayoutDescription] UTF8String]);
}
-(NSString *)dumpString
{
    return [self tx_recursiveDescription];
}
- (NSString *)tx_recursiveDescription
{
    NSMutableString *s = [NSMutableString string];
    
    typedef void (^block_t)(UIView *view, int depth);
    
    __block block_t recurse;
    block_t block;
    recurse = block = ^(UIView *view, int depth)
    {
        NSString *theIndent = [@"" stringByPaddingToLength:depth * 4 withString:@"   |" startingAtIndex:0];
        [s appendFormat:@"%@%@\n", theIndent, [view description]];
        for (UIView *theSubview in view.subviews)
        {
            recurse(theSubview, depth + 1);
        }
    };
    block(self, 0);
    
    return(s);
}
- (NSString *)tx_recursiveLayoutDescription
{
    NSMutableString *s = [NSMutableString string];
    
    typedef void (^block_t)(UIView *view, int depth);
    
    __block block_t recurse;
    block_t block;
    recurse = block = ^(UIView *view, int depth)
    {
        NSString *theIndent = [@"" stringByPaddingToLength:depth * 4 withString:@"   |" startingAtIndex:0];
        [s appendFormat:@"%@%@\n", theIndent, [view description]];
        for (NSLayoutConstraint *theConstraint in view.constraints)
        {
            [s appendFormat:@"%@   * %@\n", theIndent, [theConstraint description]];
        }
        for (UIView *theSubview in view.subviews)
        {
            recurse(theSubview, depth + 1);
        }
    };
    block(self, 0);
    
    return(s);
}

-(void)highlightSubLayers:(CALayer*)layer
{
    layer.borderWidth = 1.0;
    layer.borderColor = [[UIColor randomColor] CGColor];
    for (CALayer *ll in layer.sublayers) {
        if (layer.sublayers.count > 0) {
            [self highlightSubLayers:ll];
        }
    }
}

-(void)highlightViewLayers
{
    [self highlightSubLayers:self.layer];
}

-(void)highlightSubviewsWithColor:(UIColor*)color
{
    //use boder wrappered
    self.layer.borderWidth = 1.0;
    self.layer.borderColor = [color CGColor];
    for (UIView *view in self.subviews) {
        if (self.subviews.count>0) {
            [view highlightSubviewsWithColor:color];
        }
    }
}
-(void)highlightSubviews
{
    //use boder wrappered
    self.layer.borderWidth = 1.0;
    self.layer.borderColor = [[UIColor randomColor]CGColor];
    //        view.alpha = .5;
    for (UIView *view in self.subviews) {
        if (self.subviews.count>0) {
            [view highlightSubviews];
        }
    }}

-(CGSize)sizeWH
{
    return self.frame.size;
}
-(void)setSizeWH:(CGSize)sizeWH
{
    CGRect r = self.frame;
    r.size = sizeWH;
    self.frame = r;
}
-(CGPoint)originPoint
{
    return self.frame.origin;
}
-(void)setOriginPoint:(CGPoint)originPoint
{
    CGRect r = self.frame;
    r.origin = originPoint;
    self.frame = r;
}
-(CGPoint)rightBottomCorner
{
    return CGPointMake(self.originX + self.sizeWidth, self.originY + self.sizeHeight);
}
+(instancetype)viewWithFrame:(CGRect)frame
{
    return [[self alloc] initWithFrame:frame];
}
-(void)setCornerRadius:(CGFloat)cornerRadius
{
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = cornerRadius;
}
-(CGFloat)cornerRadius
{
    return self.layer.cornerRadius;
}
-(UIColor*)borderColor
{
    return [UIColor colorWithCGColor:self.layer.borderColor];
}
-(void)setBorderColor:(UIColor*)borderColor
{
    self.layer.borderColor = borderColor.CGColor;
}

-(CGFloat)borderWidth
{
    return self.layer.borderWidth;
}
-(void)setBorderWidth:(CGFloat)borderWidth
{
    self.layer.borderWidth = borderWidth;
}

- (CGSize)screenSize
{
    CGSize screenSize               = [UIScreen mainScreen].bounds.size;
    return CGSizeMake(MIN(screenSize.width, screenSize.height), MAX(screenSize.width, screenSize.height));
}

@end

@implementation UIWebView (Utility)

-(NSString *)currentUrl
{
    return [self stringByEvaluatingJavaScriptFromString:@"location.href"];
}
-(NSString*)currentTitle
{
    NSString *tt = [self stringByEvaluatingJavaScriptFromString:@"document.title"];
    return tt;
}

@end

@implementation UILabel (Util)

+(UILabel*)labelWithText:(NSString*)text fontSize:(int)size color:(UIColor*)color
{
    UILabel *label = [[UILabel alloc] init];
    label.text = text;
    label.font = [UIFont systemFontOfSize:size];
    label.textColor = color;
    label.backgroundColor = [UIColor clearColor];
    [label sizeToFit];
    return label;
}
-(void)setFitText:(NSString *)text baseFont:(CGFloat)font
{
    CGFloat f = [self fontForText:text baseFont:font width:self.sizeWidth-5];
    self.font = [UIFont systemFontOfSize:f];
    self.text = text;
}
-(void)setFitSuperView:(NSString *)text baseFont:(CGFloat)font
{
    CGFloat f = [self fontForText:text baseFont:font width:self.superview.sizeWidth - self.originX];
    self.font = [UIFont systemFontOfSize:f];
    self.text = text;
}

-(CGFloat)fontForText:(NSString*)text baseFont:(CGFloat)font width:(CGFloat)width
{
    CGSize size = [text sizeWithFont:[UIFont systemFontOfSize:font]];
    if (size.width > width) {
        font = font - 1;
        if (font <= 12) {
            return font;
        }else{
            return [self fontForText:text baseFont:font width:width];
        }
    }else{
        return font;
    }
}

@end
@implementation UIColor (Util)
+(UIColor *)color255WithRed:(int)red green:(int)green blue:(int)blue
{
    return [UIColor colorWithRed:red/255.0 green:green/255.0 blue:blue/255.0 alpha:1];
}
+(UIColor *)randomColor
{
    static BOOL seeded = NO;
    if (!seeded) {
        seeded = YES;
        srandom(time(NULL));
    }
    CGFloat red =  (CGFloat)random()/(CGFloat)RAND_MAX;
    CGFloat blue = (CGFloat)random()/(CGFloat)RAND_MAX;
    CGFloat green = (CGFloat)random()/(CGFloat)RAND_MAX;
    return [UIColor colorWithRed:red green:green blue:blue alpha:1.0f];
}

+(UIColor *)getColor:(NSString *)hexColor
{
    if (hexColor.length<6) {
        return [UIColor blackColor];
    }
    unsigned int red,green,blue;
    NSRange range;
    range.length = 2;
    
    range.location = 0;
    [[NSScanner scannerWithString:[hexColor substringWithRange:range]] scanHexInt:&red];
    
    range.location = 2;
    [[NSScanner scannerWithString:[hexColor substringWithRange:range]] scanHexInt:&green];
    
    range.location = 4;
    [[NSScanner scannerWithString:[hexColor substringWithRange:range]] scanHexInt:&blue];
    
    return [UIColor colorWithRed:(float)(red/255.0f) green:(float)(green / 255.0f) blue:(float)(blue / 255.0f) alpha:1.0f];
}
@end

@implementation UIImage (Util)

// get a template image, ignoring its color information
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
    
    /**
     CGRect rect = CGRectMake(0, 0, self.size.width, self.size.height);
     // begin a new image context, to draw our colored image onto
     //    UIGraphicsBeginImageContext(self.size);
     UIGraphicsBeginImageContextWithOptions(self.size, NO,[UIScreen mainScreen].scale);
     
     // get a reference to that context we created
     CGContextRef context = UIGraphicsGetCurrentContext();
     
     //    CGContextSetAllowsAntialiasing(context, true);
     //    CGContextSetShouldAntialias(context, true);
     
     // set the fill color
     [color setFill];
     
     // translate/flip the graphics context (for transforming from CG* coords to UI* coords
     CGContextTranslateCTM(context, 0, self.size.height);
     CGContextScaleCTM(context, 1.0, -1.0);
     
     // set the blend mode to color burn, and the original image
     //CGContextSetBlendMode(context, kCGBlendModeColorBurn);
     CGContextDrawImage(context, rect, self.CGImage);
     
     // set a mask that matches the shape of the image, then draw (color burn) a colored rectangle
     CGContextClipToMask(context, rect, self.CGImage);
     CGContextAddRect(context, rect);
     CGContextDrawPath(context,kCGPathFill);
     
     // generate a new UIImage from the graphics context we drew onto
     UIImage *coloredImg = UIGraphicsGetImageFromCurrentImageContext();
     UIGraphicsEndImageContext();
     
     //return the color-burned image
     return coloredImg;
     **/
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
    UIGraphicsBeginImageContextWithOptions(screenWindow.sizeWH, YES,[UIScreen mainScreen].scale);
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
    //path for resource 不会去自动加@2x，所以换做stringWithFormat
    //    NSString *imgpath = [bundle pathForResource:name ofType:nil];
    //    return [UIImage imageWithContentsOfFile:imgpath];
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

@implementation NSString (Util)

-(NSString *)md5String
{
    if(self == nil || [self length] == 0)
    return nil;
    const char *value = [self UTF8String];
    unsigned char outputBuffer[CC_MD5_DIGEST_LENGTH];
    CC_MD5(value, strlen(value), outputBuffer);
    NSMutableString *outputString = [[NSMutableString alloc] initWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for(NSInteger count = 0; count < CC_MD5_DIGEST_LENGTH; count++)
    [outputString appendFormat:@"%02x",outputBuffer[count]];
    
    return outputString;
}

-(BOOL)isValidPhoneNumber
{
    //    NSString *Regex =@"(13[0-9]|14[57]|15[012356789]|18[02356789])\\d{8}";
    NSString *Regex =@"1\\d{10}";
    NSPredicate *mobileTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", Regex];
    return [mobileTest evaluateWithObject:self];
}

- (BOOL)hasString:(NSString *)subString
{
    if([self isValidString] && [subString isValidString]){
        if ([self rangeOfString:subString].location != NSNotFound) {
            return YES;
        }
    }
    return NO;
}

- (NSDictionary *)queryStringToDic
{
    int loc = [self rangeOfString:@"?"].location;
    NSString *param = loc+1 <= self.length? [self substringFromIndex:loc+1]: self;
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    
    for (NSString *pair in [param componentsSeparatedByString:@"&"])
    {
        NSArray *elements = [pair componentsSeparatedByString:@"="];
        if ([elements count] > 1)
        {
            NSString *key = [[elements objectAtIndex:0] stringByReplacingPercentEscapesUsingEncoding:NSASCIIStringEncoding];
            NSString *val = [[elements objectAtIndex:1] stringByReplacingPercentEscapesUsingEncoding:NSASCIIStringEncoding];
            
            if(key && val)
            [dict setObject:val forKey:key];
        }
    }
    return dict;
}

- (NSDictionary *)queryParamToDic
{
    NSString *param = self;
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    
    for (NSString *pair in [param componentsSeparatedByString:@"&"])
    {
        NSArray *elements = [pair componentsSeparatedByString:@"="];
        if ([elements count] > 1)
        {
            NSString *key = [elements objectAtIndex:0];
            NSString *val = [elements objectAtIndex:1];
            
            if(key && val)
            [dict setObject:val forKey:key];
        }
    }
    return dict;
}

-(NSString*)cnNumber
{
    long num = [self integerValue];
    NSMutableString *rst = [NSMutableString string];
    if (num/100000000 >= 1) {
        NSString *str = [NSString stringWithFormat:@"%ld亿",num/100000000];
        [rst appendString:str];
        
        num = num % 100000000;
        if (num/10000 >= 1) {
            [rst appendFormat:@"%ld万",num/10000];
        }
    }else{
        num = num % 100000000;
        if (num/10000 >= 1) {
            [rst appendFormat:@"%ld万",num/10000];
        }else{
            return [NSString stringWithFormat:@"%ld元",num];
        }
    }
    return rst;
}
@end


