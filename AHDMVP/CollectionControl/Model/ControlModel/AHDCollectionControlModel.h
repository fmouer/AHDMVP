//
//  AHDCollectionControlModel.h
//  MVPDemo
//
//  Created by ihotdo on 15/12/29.
//  Copyright © 2015年 ihotdo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AHDModelProtocol.h"
#import "AHDCellProtocol.h"
#import "AHDHelperProtocol.h"

@interface AHDCollectionControlModel : NSObject

@property (nonatomic, assign)NSInteger currentPage;

@property (nonatomic, weak)id<AHDHelperProtocol>helperModel;

@property (nonatomic, strong)id<AHDModelProtocol>headerModel;

///是否存在该类型的model
-(BOOL)hasSubCellModelClass:(Class)modelClass;

- (id <AHDModelProtocol>)rowModelAtIndexPath:(NSIndexPath *)indexPath;

- (NSUInteger)sectionCount;

- (NSUInteger)rowModelCount:(NSUInteger)section;

- (NSUInteger)indexOfModel:(id<AHDModelProtocol>)model;

- (BOOL)replaceModel:(id<AHDModelProtocol>)model atIndex:(NSUInteger)index;

/**
 *  设置缓存信息，通过model获取唯一键值 来缓存size到caches
 *
 *  @param model Cell model
 *  @param size  Cell size
 */
- (void)setCellSizeWith:(id<AHDModelProtocol>)model size:(CGSize)size;

/**
 *  通过model获取size
 *
 *  @param model Cell model
 *
 *  @return CGSize
 */
- (CGSize)getCellSizeWith:(id<AHDModelProtocol>)model;


- (void)tableViewControlLoadDatas:(NSArray *)data
                            pages:(NSUInteger)page
                 insertCompletion:(void(^)(NSArray<NSIndexPath *> * insertIndexPaths))completion
                 reloadCompletion:(void(^)())reloadCompletion
                  message:(void(^)(NSString * message))messageCompletion;

/**
 *  刷新某个Cell，通过model定位到某个Cell indexPath
 *
 *  @param model      Cell model
 *  @param completion 需要刷新的某个 NSIndexPath
 */
- (void)updateModel:(id<AHDModelProtocol>)model
         completion:(void (^)(NSIndexPath * updateIndexPath))completion;

/**
 *  刷新Cell，通过model为模板，更新所有列表中和model含有相同filterValue的其它model
 *（用于晒晒中转发的晒晒更新点赞，评论等信息）
 *  @param model      model
 *  @param keys       需要同步的keys
 *  @param completion 所有同步的IndexPaths
 */
- (void)updateModel:(id<AHDModelProtocol>)model
               keys:(NSArray *)keys
         completion:(void (^)(NSArray * updateIndexPaths))completion;

/**
 *  插入新的model
 *
 *  @param model      新model
 *  @param index      插入到某个位置
 *  @param completion 插入的NSIndexPath
 */
- (void)insertModel:(id<AHDModelProtocol>)model
            atIndex:(NSUInteger)index
         completion:(void (^)(NSIndexPath * insertIdexPath))completion;

/**
 *  删除model
 *
 *  @param model      model
 *  @param completion 需要删除的NSIndexPath
 */
- (void)deleteModel:(id<AHDModelProtocol>)model
         completion:(void (^)(NSArray * deleteIndexPaths))completion;

@end
