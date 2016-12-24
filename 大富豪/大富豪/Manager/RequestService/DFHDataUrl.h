//
//  DFHDataUrl.h
//  大富豪
//
//  Created by Louis on 2016/10/24.
//  Copyright © 2016年 Louis. All rights reserved.
//

#ifndef DFHDataUrl_h
#define DFHDataUrl_h

#define Decryption_AESSecretKey @"f695cbaa22634ed6"    //aes解密秘钥@"28d897af4fd64a3d987ffa1d8b8fcc15"//
//----------------------------接口-------------------------------------//
#define DFH_BaseURL @"http://114.55.253.199:81/game/"  //基础接口
#define DFH_MemberRegister @"http://114.55.253.199:81/game/member/register"  //会员注册
#define DFH_MemberLogin @"http://114.55.253.199:81/game/member/login"  //会员登录
#define DFH_MachineSelectBycode @"http://114.55.253.199:81/game/machine/selectBycode"  //根据邀请码获取机台列表
#define DFH_MemberChoiceMachine @"http://114.55.253.199:81/game/member/choiceMachine"  //会员选择机台接口
#define DFH_MachinesetGetById @"http://114.55.253.199:81/game/machineset/getById"  //根据机器 id 获取机器设置

#define DFH_MachineUpdateStake @"http://114.55.253.199:81/game/machine/updateStake"  //修改押分
#define DFH_MachineUpdateProfit @"http://114.55.253.199:81/game/machine/updateProfit"  //修改盈利

#define DFH_PokerGetPoker @"http://114.55.253.199:81/game/poker/getPoker"                 //获取单个牌路
#define DFH_PokerUpdateStatus  @"http://114.55.253.199:81/game/poker/updateStatus" //修改某局状态
#define DFH_PokerGetHistory        @"http://114.55.253.199:81/game/poker/getHistory"      //获取历史牌路
#define DFH_PokerGenerate         @"http://114.55.253.199:81/game/poker/generate"         //生成牌路


//----------------------------接口-------------------------------------//


#endif /* DFHDataUrl_h */
