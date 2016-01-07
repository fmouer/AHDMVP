//
//  AHDHeaderModel.m
//  AHDMVP
//
//  Created by ihotdo on 16/1/5.
//  Copyright © 2016年 fmouer. All rights reserved.
//

#import "AHDHeaderModel.h"

@implementation AHDHeaderModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.content = @"这是header";
    }
    return self;
}

-(void)loadModelInfo:(NSDictionary *)modelInfo
{
    
}

-(NSString *)cellIdentifier
{
    return @"AHDShowHeaderView";
}

@end
