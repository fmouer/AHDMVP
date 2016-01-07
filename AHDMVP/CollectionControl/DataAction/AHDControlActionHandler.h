//
//  AHDControlActionHandler.h
//  MVPDemo
//
//  Created by ihotdo on 15/12/30.
//  Copyright © 2015年 ihotdo. All rights reserved.
//

#import <Foundation/Foundation.h>
@class AHDBaseDataAction;
@protocol AHDActionHandlerDelegate;

@interface AHDControlActionHandler : NSObject

@property (nonatomic, weak)id<AHDActionHandlerDelegate>delegate;

/**
 *  执行action
 *
 *  @param dataAction AHDBaseDataAction
 */
- (void)performAction:(AHDBaseDataAction *)dataAction;

@end

@protocol AHDActionHandlerDelegate <NSObject>

@optional

- (BOOL)shouldActionHandler:(AHDControlActionHandler *)actionHandler
             willDataAction:(AHDBaseDataAction *)dataAction;


/**
 *  AHDBaseDataAction 之后的调用
 *
 *  @param actionHandler AHDControlActionHandler
 *  @param actionModel   AHDBaseDataAction
 *  @param result        NSDictionary 附带信息
 */
- (void)actionHandler:(AHDControlActionHandler *)actionHandler
     actionCompletion:(AHDBaseDataAction *)dataAction
               result:(NSDictionary *)result;


/*
 - (void)actionHandler:(AHDControlActionHandler *)actionHandler
        didDataAction:(AHDBaseDataAction *)dataAction;
 */
@end