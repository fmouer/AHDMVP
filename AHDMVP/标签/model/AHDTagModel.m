//
//  AHDTagModel.m
//  AHDMVP
//
//  Created by ihotdo on 16/1/7.
//  Copyright © 2016年 fmouer. All rights reserved.
//

#import "AHDTagModel.h"
#import "AHDTagAction.h"

@implementation AHDTagModel

-(NSString *)cellIdentifier
{
    return @"AHDTagCell";
}

- (void)loadModelInfo:(NSDictionary *)modelInfo
{
    self.tagName = [modelInfo objectForKey:@"tagName"];
}

-(AHDBaseDataAction *)jumpActionModel:(id)actionInfo
{
    AHDTagAction * action = [AHDTagAction dataActionWithModel:self];
    action.actionType = actionInfo;
    return action;
}

@end
