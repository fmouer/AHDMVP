//
//  AHDCollectionControlLayout.m
//  AHDMVP
//
//  Created by fmouer on 16/1/3.
//  Copyright © 2016年 fmouer. All rights reserved.
//

#import "AHDCollectionControlLayout.h"

@implementation AHDCollectionControlLayout
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.minimumInteritemSpacing = 0;
        self.minimumLineSpacing = 0;
//        self.scrollDirection = UICollectionViewScrollDirectionHorizontal;

    }
    return self;
}
//-(NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect
//{
//    NSArray * arrays = [super layoutAttributesForElementsInRect:rect];
//        float y = 0;
//        for (UICollectionViewLayoutAttributes * layoutAttributes in arrays) {
//            NSLog(@"layoutAttributes size is %@",NSStringFromCGSize(layoutAttributes.size));
//            if (layoutAttributes.representedElementKind) {
//                continue;
//            }
//
//            layoutAttributes.size = CGSizeMake(layoutAttributes.size.width, 500);
//            CGRect rect = layoutAttributes.frame;
//            
//            
//            if (rect.origin.y < 250) {
//                NSLog(@"错误！");
//            }
//        if (_changeCollectionLayout || rect.origin.y < self.headerReferenceSize.height) {
//
//            if (y > 0 || rect.origin.y < 0) {
//                rect.origin.y = y;
//            }else{
//                rect.origin.y = MAX(self.headerReferenceSize.height, rect.origin.y);
//            }
//            layoutAttributes.frame = rect;
//
//            y = CGRectGetMaxY(rect);
//            
//        }
//        _changeCollectionLayout = NO;
//    }
//
//    return arrays;
//}
//
//-(BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
//{
//    return YES;
//}
//- (UICollectionViewLayoutInvalidationContext *)invalidationContextForPreferredLayoutAttributes:(UICollectionViewLayoutAttributes *)preferredAttributes withOriginalAttributes:(UICollectionViewLayoutAttributes *)originalAttributes
//{
//    
//}
//-(CGSize)collectionViewContentSize
//{
//   CGSize size = [super collectionViewContentSize];
//    NSLog(@"layout content size is %@",NSStringFromCGSize(size));
//    return size;
//}

@end
