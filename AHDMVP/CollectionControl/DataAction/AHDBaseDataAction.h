//
//  AHDBaseDataAction.h
//  AHDMVP
//
//  Created by fmouer on 16/1/3.
//  Copyright © 2016年 fmouer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AHDModelProtocol.h"
#import "AHDCollectionTypes.h"

typedef void (^ ActionCompletion)(NSDictionary * result);

@interface AHDBaseDataAction : NSObject

@property (nonatomic, strong) NSString * actionType;

@property (nonatomic, strong)NSString * actionId;

@property (nonatomic, weak)id<AHDModelProtocol>model;

@property (nonatomic, assign)TranserType transerType;

+ (id)dataActionWithModel:(id<AHDModelProtocol>)model;

- (void)performOperationWithActionType:(ActionCompletion) actionCompletion;


@end
