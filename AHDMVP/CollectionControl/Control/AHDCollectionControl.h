//
//  AHDCollectionControl.h
//  MVPDemo
//
//  Created by ihotdo on 15/12/28.
//  Copyright © 2015年 ihotdo. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *刷新方式
 */
typedef enum {
    ///不需要下拉刷新和上拉加载更多
    AHDRefreshTypeNone = 0,
    ///下拉刷新
    AHDRefreshTypeRefresh ,
    ///上拉加载
    AHDRefreshTypeLoading,
    ///上拉加载和下拉刷新
    AHDRefreshTypeRefreshAndLoading,
}AHDRefreshType;

@protocol AHDHelperProtocol;
@protocol AHDModelProtocol;
@protocol AHDCollectionControlDelegate;
@class AHDBaseDataAction;

@interface AHDCollectionControl : UIView<UICollectionViewDataSource,UICollectionViewDelegate>
{
    UICollectionView    *   _collectionView;
}

@property (nonatomic, assign)AHDRefreshType  refreshType;

@property (nonatomic, assign)BOOL beginRefreshing;

/**
 *  设置 itemCellSize，确定的Size
 */
@property (nonatomic, assign)CGSize itemSize;

/**
 *  headerSize
 */
@property (nonatomic, assign)CGSize sectionHeaderSize;

///cell 左右最小间距
@property (nonatomic) CGFloat minimumLineSpacing;

///cell 上下最小间距
@property (nonatomic) CGFloat minimumInteritemSpacing;

///collection edgeInserts (cell上下左右 和 collectionView 的最小间隔)
@property (nonatomic, assign)UIEdgeInsets collectionEdgeInsets;

@property (nonatomic, weak)id<AHDCollectionControlDelegate>delegate;

- (instancetype)initWithHelperModel:(id<AHDHelperProtocol> )helperModel;

- (instancetype)initWithFrame:(CGRect)frame
                  helperModel:(id<AHDHelperProtocol>)helperModel;

/**
 *  设置头部model
 *
 *  @param headerModel
 */
- (void)setControlHeaderModel:(id<AHDModelProtocol>)headerModel;

- (void)setControlData:(id)objectInfo page:(NSInteger)page;

@end


@protocol AHDCollectionControlDelegate <NSObject>

@optional

- (void)collectionControl:(AHDCollectionControl *)collectionControl requestPage:(NSInteger)page;

- (BOOL)shouldCollectionControl:(AHDCollectionControl *)collectionControl willDataAction:(AHDBaseDataAction *)dataAction;

- (void)collectionControl:(AHDCollectionControl *)collectionControl didDataAction:(AHDBaseDataAction*)dataAction;

@end