//
//  AHDCollectionControlDelegate.h
//  AHD_iPhone_3.5
//
//  Created by ihotdo on 16/1/13.
//  Copyright © 2016年 wisdom1998. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AHDCollectionControl.h"
#import "AHDBaseDataAction.h"
#import "AHDTransferModel.h"

@protocol AHDCollectionControlDelegate <NSObject>

@optional

- (void)collectionControl:(AHDCollectionControl *)collectionControl requestPage:(NSInteger)page;

- (BOOL)shouldCollectionControl:(AHDCollectionControl *)collectionControl willDataAction:(AHDBaseDataAction *)dataAction;

- (void)collectionControl:(AHDCollectionControl *)collectionControl didDataAction:(AHDBaseDataAction*)dataAction;


- (void)collectionControlBeforeRefresh:(AHDCollectionControl *)collectionControl
                            indexPaths:(NSArray<NSIndexPath*> *)indexPaths
                         transferModel:(AHDTransferModel *)transferModel;


- (void)collectionControlDidRefresh:(AHDCollectionControl *)collectionControl
                         indexPaths:(NSArray<NSIndexPath*> *)indexPaths
                      transferModel:(AHDTransferModel *)transferModel;

@end
