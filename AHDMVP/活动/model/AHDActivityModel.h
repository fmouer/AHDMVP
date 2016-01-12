//
//  AHDActivityModel.h
//  AHDMVP
//
//  Created by ihotdo on 16/1/5.
//  Copyright © 2016年 fmouer. All rights reserved.
//

#import "AHDBaseControlModel.h"

@interface AHDActivityModel : AHDBaseControlModel

/**
 *  活动Id
 */
@property (nonatomic, strong)NSString * Id;

/**
 *  活动标题
 */
@property (nonatomic, strong)NSString * title;

/**
 *  活动地址
 */
@property (nonatomic, strong)NSString * address;

/**
 *  活动地区（城市）
 */
@property (nonatomic, strong)NSString * location;

/**
 *  活动封面
 */
@property (nonatomic, strong)NSString * posterUrl;

/**
 *  活动开始时间
 */
@property (nonatomic, strong)NSString * stageStartTime;

@property (nonatomic, strong)NSString * stageEndTime;

/**
 *  活动成员数量
 */
@property (nonatomic, assign)NSInteger memberNumber;

/**
 *  活动提示信息
 */
@property (nonatomic, strong)NSString * startMsg;

@end
