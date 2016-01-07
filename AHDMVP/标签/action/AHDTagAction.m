//
//  AHDTagAction.m
//  AHDMVP
//
//  Created by ihotdo on 16/1/7.
//  Copyright © 2016年 fmouer. All rights reserved.
//

#import "AHDTagAction.h"
#import "AHDTagModel.h"

@implementation AHDTagAction

-(void)performOperationWithActionType:(ActionCompletion)actionCompletion
{
    AHDTagModel * model = (AHDTagModel *)self.model;
    model.isSelected = !model.isSelected;
    actionCompletion(nil);
    
}
@end
