//
//  AHDCellProtocol.h
//  MVPDemo
//
//  Created by ihotdo on 15/12/28.
//  Copyright © 2015年 ihotdo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AHDModelProtocol.h"
#import "AHDBaseDataAction.h"
#import <UIKit/UIKit.h>

typedef void (^ CellOperationBlock)(id actionInfo);

typedef void (^ CellSizeBlock)(CGSize size);

@protocol AHDCellProtocol <NSObject>

/**
 *  设置cell 的 model数据
 *
 *  @param 实现了 AHDModelProtocol 协议的model
 */
- (void)setCellModel:(id<AHDModelProtocol>)model;


@optional

/**
 *  cell 操作通过 operationBlock，给model传值交互。
 *  dataAction 处理完之后 通过-updatePartOfCell:result: 方法更新局部信息
 *
 *  @param operationBlock <#operationBlock description#>
 */
- (void)setCellOpeationBlock:(CellOperationBlock)operationBlock;

/**
 *  刷新cell的局部信息
 *
 *  @param actionModel AHDBaseDataAction
 *  @param result      action 携带的信息
 */
- (void)updatePartOfCell:(AHDBaseDataAction *) actionModel
                  result:(NSDictionary * )result;

/**
 *  返回cell size
 *
 *  @return size
 */
- (CGSize)getCellSize;

/**
 *  通过model计算size高度
 *
 *  @return CGSize
 */
+ (CGSize)getCellSizeWith:(id<AHDModelProtocol>)model cellWidth:(float)width;

///此方法先不管，后续优化可能用到
- (void)setCellSize:(CGSize)size getActualSize:(CellSizeBlock)sizeBlock;

@end
