//
//  AHDActionProtocol.h
//  MVPDemo
//
//  Created by ihotdo on 15/12/30.
//  Copyright © 2015年 ihotdo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AHDBaseDataAction.h"

@protocol AHDActionProtocol <NSObject>

@optional
/**
 *  通过 actionInfo 实例相应的 dataAction
 *
 *  @param actionInfo
 *
 *  @return AHDBaseDataAction
 */
- (AHDBaseDataAction *)jumpActionModel:(id)actionInfo;

@end
