//
//  AHDActivityModel.m
//  AHDMVP
//
//  Created by ihotdo on 16/1/5.
//  Copyright © 2016年 fmouer. All rights reserved.
//

#import "AHDActivityModel.h"
#import "MJExtension.h"

@implementation AHDActivityModel


+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"peopleNumber":@"count"};
}

// itemList 数组中 为 TemplateCategoryItemModel
+ (NSDictionary *)mj_objectClassInArray
{
    return @{
             @"itemList" : @"TemplateCategoryItemModel"
             };
}

- (instancetype)init
{
    self = [super init];
    if (self) {
    }
    return self;
}

-(void)loadModelInfo:(NSDictionary *)modelInfo
{
    
}

-(NSString *)cellIdentifier
{
    return @"AHDActivityCell";
}

@end
