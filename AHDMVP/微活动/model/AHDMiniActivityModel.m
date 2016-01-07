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

@implementation AHDMiniActivityModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.content = @"微活动";
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
-(AHDBaseDataAction *)jumpActionModel:(id)actionInfo
{
    AHDMiniActivityAction * action = [AHDMiniActivityAction dataActionWithModel:self];
    action.actionType = actionInfo;
    return action;
}

@end
