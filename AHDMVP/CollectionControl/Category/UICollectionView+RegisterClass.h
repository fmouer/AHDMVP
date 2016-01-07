//
//  UICollectionView+RegisterClass.h
//  MVPDemo
//
//  Created by fmouer on 16/1/1.
//  Copyright © 2016年 ihotdo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UICollectionView (RegisterClass)

- (NSMutableDictionary *)registerModelClass:(NSArray *)viewClasses;

- (NSMutableDictionary *)registerModelNib:(NSArray *)nibes;

-(void)registerModelClass:(NSArray *)viewClasses forSupplementaryViewOfKind:(NSString *)elementKind;

- (void)registerModelNib:(NSArray *)nibes forSupplementaryViewOfKind:(NSString *)kind;

@end
