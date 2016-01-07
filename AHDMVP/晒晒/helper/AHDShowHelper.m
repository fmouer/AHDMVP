//
//  AHDShowHelper.m
//  AHDMVP
//
//  Created by ihotdo on 16/1/5.
//  Copyright © 2016年 fmouer. All rights reserved.
//

#import "AHDShowHelper.h"

@implementation AHDShowHelper

-(NSString *)helperGetModelNameWith:(id)object
{
    return @"AHDShowModel";
}

//-(NSArray *)helperGetItemCell
//{
//    return @[@"AHDShowCell"];
//}

-(NSArray *)helperGetItemNibCell
{
    return @[@"AHDShowCell"];

}
-(NSArray *)helperGetItemSectionHeader
{
    return @[@"AHDShowHeaderView"];
}

@end
