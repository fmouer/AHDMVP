//
//  AHDMiniActivityAction.m
//  AHDMVP
//
//  Created by ihotdo on 16/1/5.
//  Copyright © 2016年 fmouer. All rights reserved.
//

#import "AHDMiniActivityAction.h"
#import "AHDMiniActivityHeader.h"

@implementation AHDMiniActivityAction


-(void)performOperationWithActionType:(ActionCompletion)actionCompletion
{
    NSLog(@"action处理type:%@",self.actionType);

    if ([self.actionType isEqualToString:MiniActivityActionTypeClick]) {
        
        actionCompletion(@{@"message":@"按钮点击成功！"});
    }

}

@end
