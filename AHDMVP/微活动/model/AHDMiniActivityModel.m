//
//  AHDMiniActivityModel.m
//  AHDMVP
//
//  Created by ihotdo on 16/1/5.
//  Copyright © 2016年 fmouer. All rights reserved.
//

#import "AHDMiniActivityModel.h"
#import "AHDMiniActivityAction.h"
#import "AHDMiniActivityHeader.h"
#import "MJExtension.h"

@implementation AHDMiniActivityModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"numberPersonRequest":@"number",@"userModel":@"creator"};
}

+ (NSDictionary *)mj_objectClassInArray
{
    return @{@"member":@"AHDUserModel"};
}

- (instancetype)init
{
    self = [super init];
    if (self) {
    }
    return self;
}

-(NSString *)cellIdentifier
{
    return @"AHDMiniActivityCell";
}

-(void)loadModelInfo:(NSDictionary *)modelInfo
{
    
}

-(void)setTime:(NSString *)time
{
    _time = time;
    _timeString = @"09月03日(星期三)12点30分";
}

-(AHDBaseDataAction *)jumpActionModel:(id)actionInfo
{
    AHDMiniActivityAction * action = [AHDMiniActivityAction dataActionWithModel:self];
    action.actionType = actionInfo;
    return action;
}

-(NSString *)getFeeTypeString
{
    return @"我请客";
}

-(NSString *)distanceString
{
    return @"距我：202m";
}

@end
