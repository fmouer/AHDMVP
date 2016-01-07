//
//  UICollectionView+RegisterClass.m
//  MVPDemo
//
//  Created by fmouer on 16/1/1.
//  Copyright © 2016年 ihotdo. All rights reserved.
//

#import "UICollectionView+RegisterClass.h"

@implementation UICollectionView (RegisterClass)

- (NSMutableDictionary *)registerModelClass:(NSArray *)viewClasses
{
    NSMutableDictionary * classesCaches = [[NSMutableDictionary alloc] initWithCapacity:viewClasses.count];
    [viewClasses enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSLog(@"will reigster %@",obj);
        [classesCaches setObject:@"" forKey:obj];
        [self registerClass:NSClassFromString(obj) forCellWithReuseIdentifier:obj];
    }];
    NSLog(@"finsh register");
    return [classesCaches mutableCopy];
}

- (NSMutableDictionary *)registerModelNib:(NSArray *)nibes
{
    NSMutableDictionary * classesCaches = [[NSMutableDictionary alloc] initWithCapacity:nibes.count];

    [nibes enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [classesCaches setObject:@"Nib" forKey:obj];

        UINib * nib = [UINib nibWithNibName:obj bundle:nil];
        [self registerNib:nib forCellWithReuseIdentifier:obj];
    }];
    return classesCaches;
}

-(void)registerModelClass:(NSArray *)viewClasses forSupplementaryViewOfKind:(NSString *)elementKind
{
    [viewClasses enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [self registerClass:NSClassFromString(obj) forSupplementaryViewOfKind:elementKind withReuseIdentifier:obj];
    }];
}
- (void)registerModelNib:(NSArray *)nibes forSupplementaryViewOfKind:(NSString *)kind
{
    [nibes enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UINib * nib = [UINib nibWithNibName:obj bundle:nil];
        [self registerNib:nib forSupplementaryViewOfKind:kind withReuseIdentifier:obj];
    }];
}
@end
