//
//  AHDShowAction.m
//  MVPDemo
//
//  Created by ihotdo on 15/12/30.
//  Copyright © 2015年 ihotdo. All rights reserved.
//

#import "AHDShowAction.h"
#import "AHDShowModel.h"
#import "AHDTransferModel.h"
#import "AHDShowHeader.h"
#import "NSObject+UniqueCode.h"

@implementation AHDShowAction

-(void)performOperationWithActionType:(ActionCompletion)actionCompletion
{
    if ([self.actionType isEqualToString:ShowUpdateActionType]) {
        //晒晒操作
        [self updateCell];
    }else if ([self.actionType isEqualToString:ShowInsertActionType]){
        [self insertCell];
    }else{
        [self deleteCell];
    }
    
}

- (void)updateCell
{
    AHDTransferModel * transferModel = [[AHDTransferModel alloc] init];
    
    transferModel.model = self.model;
    NSLog(@"hash is %@",[(AHDShowModel *)transferModel.model uniqueCode]);
    
    [(AHDShowModel *)transferModel.model setUpdate:YES];
    NSLog(@"update hash is %@",[(AHDShowModel *)transferModel.model uniqueCode]);

    transferModel.transerType = TranserTypeUpdate;
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"collectionControlNotification" object:transferModel];
    
}

- (void)insertCell
{
    AHDTransferModel * transferModel = [[AHDTransferModel alloc] init];
    
    transferModel.model = [[AHDShowModel alloc] init];
    NSLog(@"hash is %@",[(AHDShowModel *)transferModel.model uniqueCode]);
    
//    [(AHDShowModel *)transferModel.model setUpdate:YES];
    NSLog(@"update hash is %@",[(AHDShowModel *)transferModel.model uniqueCode]);
    
    transferModel.transerType = TranserTypeInsert;
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"collectionControlNotification" object:transferModel];
    
}

- (void)deleteCell
{
    AHDTransferModel * transferModel = [[AHDTransferModel alloc] init];
    
    transferModel.model = self.model;
    NSLog(@"hash is %@",[(AHDShowModel *)transferModel.model uniqueCode]);
    
    [(AHDShowModel *)transferModel.model setUpdate:YES];
    NSLog(@"update hash is %@",[(AHDShowModel *)transferModel.model uniqueCode]);
    
    transferModel.transerType = TranserTypeDelete;
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"collectionControlNotification" object:transferModel];
    
}

@end
