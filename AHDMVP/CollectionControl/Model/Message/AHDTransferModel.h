//
//  AHDTransferModel.h
//  MVPDemo
//
//  Created by fmouer on 16/1/2.
//  Copyright © 2016年 ihotdo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AHDModelProtocol.h"

typedef NS_ENUM(NSInteger, TranserType) {
    TranserTypeUpdate   ,
    TranserTypeInsert   ,
    TranserTypeDelete   ,
};

@interface AHDTransferModel : NSObject

/*
 * 操作类型：刷新 / 插入 / 删除
 */
@property (nonatomic, assign)TranserType transerType;

@property (nonatomic, strong)id<AHDModelProtocol>model;

/*
 * 需要刷新的key
 */
@property (nonatomic, strong)NSArray * updateKeys;

@property (nonatomic, strong)NSDictionary * info;

@end
