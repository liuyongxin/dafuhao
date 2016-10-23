//
//  MNDataDefine.h
//  大富豪
//
//  Created by Louis on 16/6/23.
//  Copyright © 2016年 大富豪. All rights reserved.
//

#import <Foundation/Foundation.h>

#pragma mark -- 登陆账号信息
@interface MNAccountInfo : NSObject<NSCoding>

@property(nonatomic,copy)NSString  *userid; //用户名
@property(nonatomic,copy)NSString  *passkey; //用户登录密钥（md5加密）

@end

#pragma mark -- 登陆返回信息
@interface MNLoginInfo : NSObject<NSCoding>
//Cno	String	是	客户编号
//Cname	String	否	客户姓名
//CNickName	String	是	客户昵称
//Csex	String	否	性别
//CBirthday	String	否	出生日期
//CMobile	String	是	手机号码
//CEmail	String	否	邮件地址
//Education	String	否	教育程度
//Profession	String	否	职业
//MonthlyIncome	Number	是	默认为0
//Married	Int	是	0-未婚，1-已婚，2-保密
//CGrade	int	是	用户等级，0-初级
//TotalAmount	Number	是	用户账户余额，0即无
//TotalPoints	Int	是	用户可用积分点数
//ThumbnailPic	String	否	用户头像缩略图URL
//NormalPic	String	否	用户头像正常图URL
//token	String	是	登录成功返回身份认证token

@property(nonatomic,copy)NSString *cNO;
@property(nonatomic,copy)NSString *cName;
@property(nonatomic,copy)NSString *cNickName;
@property(nonatomic,copy)NSString *cSex;
@property(nonatomic,copy)NSString *cBirthday;
@property(nonatomic,copy)NSString *cMobile;
@property(nonatomic,copy)NSString *cEmail;
@property(nonatomic,copy)NSString *education;
@property(nonatomic,copy)NSString *profession;
@property(nonatomic,copy)NSString *monthlyIncome;  //月收入
@property(nonatomic,copy)NSString *married;
@property(nonatomic,copy)NSString *cGrade;
@property(nonatomic,copy)NSString *TotalAmount;
@property(nonatomic,copy)NSString *TotalPoints;
@property(nonatomic,copy)NSString *ThumbnailPic;
@property(nonatomic,copy)NSString *NormalPic;
@property(nonatomic,copy)NSString *token;

- (void)analyticalDataWithDictionary:(NSDictionary *)dic;

@end















