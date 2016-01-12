//
//  AHDUserModel.m
//  AHDMVP
//
//  Created by ihotdo on 16/1/11.
//  Copyright © 2016年 fmouer. All rights reserved.
//

#import "AHDUserModel.h"
#import "MJExtension.h"

@implementation AHDUserModel
+(NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"sexId":@"sex",@"headImagePath":@"imgUrl"};
}

@end
