//
//  DFHDataDefine.m
//  大富豪
//
//  Created by Louis on 2016/10/24.
//  Copyright © 2016年 Louis. All rights reserved.
//

#import "DFHDataDefine.h"

@implementation DFHAccountInfo

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:_userid forKey:@"userid"];
    [aCoder encodeObject:_passkey forKey:@"passkey"];
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self)
    {
        self.userid         = [aDecoder decodeObjectForKey:@"userid"];
        self.passkey        = [aDecoder decodeObjectForKey:@"passkey"];
    }
    return self;
}

@end

@implementation DFHLoginInfo

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:_cNO forKey:@"cNO"];
    [aCoder encodeObject:_cName forKey:@"cName"];
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self)
    {
        self.cNO         = [aDecoder decodeObjectForKey:@"cNO"];
        self.cName        = [aDecoder decodeObjectForKey:@"cName"];
    }
    return self;
}

- (void)analyticalDataWithDictionary:(NSDictionary *)dic {
    

}

@end
