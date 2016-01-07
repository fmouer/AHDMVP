//
//  AHDActivityModel.m
//  AHDMVP
//
//  Created by ihotdo on 16/1/5.
//  Copyright © 2016年 fmouer. All rights reserved.
//

#import "AHDActivityModel.h"

@implementation AHDActivityModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.content = @"活动";
    }
    return self;
}

-(NSString *)cellIdentifier
{
    return @"AHDActivityCell";
}

@end
