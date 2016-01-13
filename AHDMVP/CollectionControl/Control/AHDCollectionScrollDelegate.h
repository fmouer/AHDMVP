//
//  AHDCollectionScrollDelegate.h
//  AHD_iPhone_3.5
//
//  Created by ihotdo on 16/1/13.
//  Copyright © 2016年 wisdom1998. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AHDCollectionControl.h"

@protocol AHDCollectionScrollDelegate <NSObject>

@optional
- (void)collectionControl:(AHDCollectionControl *)collectionControl scrollViewDidEndDecelerating:(UIScrollView *)scrollView;

- (void)collectionControl:(AHDCollectionControl *)collectionControl scrollViewWillBeginDragging:(UIScrollView *)scrollView;

- (void)collectionControl:(AHDCollectionControl *)collectionControl scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset;

- (void)collectionControl:(AHDCollectionControl *)collectionControl scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView;

- (void)collectionControl:(AHDCollectionControl *)collectionControl scrollViewDidScroll:(UIScrollView *)scrollView;

- (void)collectionControl:(AHDCollectionControl *)collectionControl scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate;


@end
