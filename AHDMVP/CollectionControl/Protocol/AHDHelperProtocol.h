//
//  AHDHelperProtocol.h
//  MVPDemo
//
//  Created by fmouer on 16/1/1.
//  Copyright © 2016年 ihotdo. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol AHDHelperProtocol <NSObject>

@required
/**
 *  通过 object 判断加载某个model 的类
 *
 *  @param object 数据源信息
 *
 *  @return model 类名
 */
- (NSString *)helperGetModelNameWith:(id)object;



@optional

/**
 *  设置UICollectionView cells，可返回多个，列表中可能会出现多种cell。
 *
 *  @return NSArray
 */
- (NSArray<NSString *> *)helperGetItemCell;

/**
 *  设置nib cell， 同helperGetItemCell。
 *
 *  @return NSArray
 */
- (NSArray<NSString *> *)helperGetItemNibCell;

/**
 *  设置UICollectionView cells，可返回多个，（目前只支持一个，需后续完善）。
 *
 *  @return NSArray
 */
- (NSArray<NSString *> *)helperGetItemSectionHeader;

/*
 * 下面方法需后续完善
 - (NSArray *)helperGetItemSectionFooter;
 
 - (NSString *)helperGetCollectionHeader;
 */


@end
