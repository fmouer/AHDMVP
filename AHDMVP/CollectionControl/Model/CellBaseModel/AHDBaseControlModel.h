//
//  AHDBaseControlModel.h
//  MVPDemo
//
//  Created by ihotdo on 15/12/29.
//  Copyright © 2015年 ihotdo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AHDCollectionControlModel.h"
#import "AHDModelProtocol.h"

@interface AHDBaseControlModel : NSObject<AHDModelProtocol>

@property (nonatomic, weak)AHDCollectionControlModel * controlModel;

@end
