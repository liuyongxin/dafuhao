//
//  MNDesManager.h
//  大富豪
//
//  Created by Devoson on 16/6/20.
//  Copyright © 2016年 大富豪. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MNDesManager : NSObject

+ (NSString *) encryptUseDES:(NSString *)plainText;
+ (NSString *) decryptUseDES:(NSString*)cipherText;

@end
