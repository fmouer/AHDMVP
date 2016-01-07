//
//  AHDControlActionHandler.m
//  MVPDemo
//
//  Created by ihotdo on 15/12/30.
//  Copyright © 2015年 ihotdo. All rights reserved.
//

#import "AHDControlActionHandler.h"
#import "AHDBaseDataAction.h"

@interface AHDControlActionHandler ()

@property (nonatomic, strong)NSCache * modelCache;

@property (nonatomic, strong)AHDBaseDataAction * actionModel;

@end
@implementation AHDControlActionHandler

- (instancetype)init
{
    self = [super init];
    if (self) {
        _modelCache = [[NSCache alloc] init];
        _modelCache.countLimit = 5;
    }
    return self;
}
-(void)performAction:(AHDBaseDataAction *)dataAction
{
    //将action缓存
    [_modelCache setObject:dataAction forKey:dataAction.description] ;
    [self invokeAction:dataAction];
}

- (BOOL)invokeAction:(AHDBaseDataAction *)dataAction
{
    if (dataAction == nil) {
        return NO;
    }
    //action 执行前的判断，判断是否可以执行
    if (_delegate && [_delegate respondsToSelector:@selector(shouldActionHandler:willDataAction:)]) {
       BOOL willAction  = [_delegate shouldActionHandler:self willDataAction:dataAction];
        if (willAction == NO) {
            return NO;
        }
    }
    __weak typeof(NSCache *) wModelCache = _modelCache;
    
    //执行action
    [dataAction performOperationWithActionType:^(NSDictionary *result) {
        if (_delegate && [_delegate respondsToSelector:@selector(actionHandler:actionCompletion:result:)]) {
            [_delegate actionHandler:self actionCompletion:dataAction result:result];
        }
        [wModelCache removeObjectForKey:dataAction.description];

    }];
/*
    if (_delegate && [_delegate respondsToSelector:@selector(actionHandler:didDataAction:)]) {
        [_delegate actionHandler:self didDataAction:dataAction];
    }
*/
    
    return YES;
}
@end
