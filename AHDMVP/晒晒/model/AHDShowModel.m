//
//  AHDShowModel.m
//  MVPDemo
//
//  Created by ihotdo on 15/12/28.
//  Copyright © 2015年 ihotdo. All rights reserved.
//

#import "AHDShowModel.h"
#import "AHDShowAction.h"

@implementation AHDShowModel
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.content = @"晒晒";
    }
    return self;
}

- (NSString *)cellIdentifier
{
    return @"AHDShowCell";
}


/****
 *根据该字段属性获取列表中所有相同value的 model。
 *晒晒转发时有可能存在多个相同id的model，需通过这个方法筛选
 ****/
- (NSString *)updateFilterProperty
{
    return @"filterId";
}

-(id)filterValue
{
    return @"";
}

-(NSInteger)height
{
    if (_height == 0) {
        _height = 500;
    }
    return _height;
}

-(AHDBaseDataAction *)jumpActionModel:(id)actionInfo
{
    AHDShowAction * showAction = [[AHDShowAction alloc] init];
    showAction.model = self;
    showAction.actionType = actionInfo;
    return showAction;
}

@end
