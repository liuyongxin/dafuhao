//
//  MNDataDefine.m
//  大富豪
//
//  Created by Louis on 16/6/23.
//  Copyright © 2016年 大富豪. All rights reserved.
//

#import "MNDataDefine.h"

@implementation MNAccountInfo

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

@implementation MNLoginInfo

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
    
    if (dic[@"Cno"]) {
        self.cNO = dic[@"Cno"];
    }
    
    self.cName = dic[@"Cname"];
    self.cNickName = dic[@"CNickName"];
    self.cSex = dic[@"Csex"];
    self.cBirthday = dic[@"CBirthday"];
    self.cMobile = dic[@"CMobile"];
    self.cEmail = dic[@"CEmail"];
    self.education = dic[@"Education"];
    self.profession = dic[@"Profession"];
    self.monthlyIncome = dic[@"MonthlyIncome"];
    self.married = dic[@"Married"];
    self.cGrade = dic[@"CGrade"];
    self.TotalAmount = dic[@"TotalAmount"];
    self.TotalPoints = dic[@"TotalPoints"];
    self.ThumbnailPic = dic[@"ThumbnailPic"];
    self.NormalPic = dic[@"NormalPic"];
    
    if (! [dic[@"token"] isValidString] ) {
        
        self.token = [[NSUserDefaults standardUserDefaults] valueForKey:@"MN_Token"];
        
    }else {
        self.token = dic[@"token"];
    }
}

@end















