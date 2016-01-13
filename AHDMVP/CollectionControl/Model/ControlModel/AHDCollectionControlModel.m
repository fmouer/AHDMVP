//
//  AHDCollectionControlModel.m
//  MVPDemo
//
//  Created by ihotdo on 15/12/29.
//  Copyright © 2015年 ihotdo. All rights reserved.
//

#import "AHDCollectionControlModel.h"
#import <UIKit/UIKit.h>
#import "AHDBaseControlModel.h"
#import "NSObject+UniqueCode.h"
#import "MJExtension.h"

@interface AHDCollectionControlModel ()

@property (nonatomic, strong)NSCache * cellHeightsCache;

@property (nonatomic, strong)NSMutableArray * modelArrays;

@property (nonatomic, strong)NSMutableDictionary * classInfo;

@end

@implementation AHDCollectionControlModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        _classInfo = [[NSMutableDictionary alloc] initWithCapacity:0];
        _cellHeightsCache = [[NSCache alloc] init];
        _modelArrays = [[NSMutableArray alloc] initWithCapacity:0];
    }
    return self;
}

-(NSUInteger)sectionCount
{
    return 1;
}

-(NSUInteger)rowModelCount:(NSUInteger)section
{
    return self.modelArrays.count;
}

-(void)setCellSizeWith:(id<AHDModelProtocol>)model size:(CGSize)size
{
    NSString * uniqueCode = [(NSObject *)model uniqueCode];

    [_cellHeightsCache setObject:[NSValue valueWithCGSize:size] forKey:uniqueCode];
}

-(CGSize)getCellSizeWith:(id<AHDModelProtocol>)model
{
    NSString * uniqueCode = [(NSObject *)model uniqueCode];
    
    NSValue * value = [_cellHeightsCache objectForKey:uniqueCode];
    if (value) {
        return [value CGSizeValue];
    }
    return CGSizeZero;
}

-(id<AHDModelProtocol>)rowModelAtIndexPath:(NSIndexPath *)indexPath
{
    id <AHDModelProtocol>model = [_modelArrays objectAtIndex:indexPath.row];
    return model;
}

-(NSUInteger )indexOfModel:(id<AHDModelProtocol>)model
{
    NSUInteger index = [_modelArrays indexOfObject:model];
    return index;
}

-(BOOL)replaceModel:( id<AHDModelProtocol>)model atIndex:(NSUInteger)index
{
    if (index < _modelArrays.count && model) {
        [_modelArrays replaceObjectAtIndex:index withObject:model];
        return YES;
    }
    return NO;
}

-(BOOL)hasSubCellModelClass:(Class)modelClass
{
    BOOL hasSub = [[self.classInfo allKeys] containsObject:NSStringFromClass(modelClass)];
    return hasSub;
}

-(void)tableViewControlLoadDatas:(NSArray *)data
                           pages:(NSUInteger)page
                insertCompletion:(void (^)(NSArray<NSIndexPath *> *))completion
                reloadCompletion:(void (^)())reloadCompletion
                 message:(void (^)(NSString *))messageCompletion
{
    NSMutableArray * insertIndexPaths = [[NSMutableArray alloc] initWithCapacity:data.count];
    
    if (page == 0) {
        [_modelArrays removeAllObjects];
    }
    _currentPage = page;
    
    for (NSDictionary * dict in data) {
        NSString * className = [self getModelClassNameWith:dict];
        if (className)
        {
            Class aclass = NSClassFromString(className);
            if (className){
                [self.classInfo setObject:aclass forKey:className];
                                
                [insertIndexPaths addObject:[NSIndexPath indexPathForItem:_modelArrays.count inSection:0]];
                
                AHDBaseControlModel * baseModel = [aclass mj_objectWithKeyValues:dict];
                                
                if ([baseModel respondsToSelector:@selector(loadModelInfo:)]) {
                    [baseModel loadModelInfo:dict];
                }
                baseModel.controlModel = self;
                [_modelArrays addObject:baseModel];
            }
        }
    }
    
    if (page == 0) {
        reloadCompletion();
        messageCompletion(@"");
    }else{
        completion(insertIndexPaths);
    }
    
}

- (NSString *)getModelClassNameWith:(NSDictionary *)singleModel
{
    return [_helperModel helperGetModelNameWith:singleModel];
}

#pragma mark - model操作
#pragma mark 更新model
- (void)updateModel:(id<AHDModelProtocol>)model
         completion:(void (^)(NSIndexPath * updateIndexPath))completion;
{
    NSInteger index = [self indexOfModel:model];
    if (index != NSNotFound) {
        completion([NSIndexPath indexPathForRow:index inSection:0]);
    }else{
        NSLog(@"modelArrays中找不到要更新的model");
    }
}

-(void)updateModel:(id<AHDModelProtocol>)model
              keys:(NSArray *)keys
        completion:(void (^)(NSArray * updateIndexPaths))completion
{
    //获取筛选的key path
    NSString * filterProperty = [model updateFilterKeyPath];
    
    id value = [(NSObject *)model valueForKey:filterProperty];
    
    NSString * predicateStr = nil;
    if ([value isKindOfClass:[NSNumber class]]) {
        predicateStr = [NSString stringWithFormat:@"%@ == %@",filterProperty,value];
    }else{
        predicateStr = [NSString stringWithFormat:@"%@ LIKE[cd] '%@'",filterProperty,value];
    }
    //这个方法已测试，number 类型 predicateStr 直接 == ，字符串类型 用like，
    NSPredicate * predicate = [NSPredicate predicateWithFormat:predicateStr];
    NSArray * results = [self.modelArrays filteredArrayUsingPredicate:predicate];
    if (results.count) {
        //获取到筛选结果
        NSMutableArray * updateIndexPaths = [[NSMutableArray alloc] initWithCapacity:results.count];
        for (id<AHDModelProtocol>subModel in results) {
            NSInteger updateIndex = [self indexOfModel:subModel];
            for (NSString * key in keys) {
                //更新keys 中的属性
                id updateValue = [(NSObject *)model valueForKey:key];
                [(NSObject *)subModel setValue:updateValue forKey:key];
            }
            [self replaceModel:subModel atIndex:updateIndex];
            [updateIndexPaths addObject:[NSIndexPath indexPathForRow:updateIndex inSection:0]];
        }
        //更新
        completion(updateIndexPaths);
    }else{
        NSLog(@"modelArrays中找不到要更新的model");
    }
    
}

#pragma mark 插入model
- (void)insertModel:(id<AHDModelProtocol>)model
            atIndex:(NSUInteger)index
         completion:(void (^)(NSIndexPath * insertIdexPath))completion
{
    [self.modelArrays insertObject:model atIndex:index];
    completion([NSIndexPath indexPathForRow:index inSection:0]);
}

#pragma mark 删除model
- (void)deleteModel:(id<AHDModelProtocol>)model
         completion:(void (^)(NSArray * deleteIndexPaths))completion
{
    NSInteger index = [self indexOfModel:model];
    if (index != NSNotFound) {
        [self.modelArrays removeObjectAtIndex:index];

        completion(@[[NSIndexPath indexPathForRow:index inSection:0]]);
        
    }else{
        NSLog(@"modelArrays中找不到要删除的model");
    }
}
@end
