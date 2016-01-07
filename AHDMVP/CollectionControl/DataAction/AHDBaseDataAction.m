//
//  AHDBaseDataAction.m
//  AHDMVP
//
//  Created by fmouer on 16/1/3.
//  Copyright © 2016年 fmouer. All rights reserved.
//

#import "AHDBaseDataAction.h"

@implementation AHDBaseDataAction

+ (id)dataActionWithModel:(id<AHDModelProtocol>)model
{
    AHDBaseDataAction * action = [[[self class] alloc] init];
    action.model = model;
    return action;
}

-(void)performOperationWithActionType:(ActionCompletion)actionCompletion
{
    
}

@end
