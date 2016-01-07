//
//  AHDTagModel.h
//  AHDMVP
//
//  Created by ihotdo on 16/1/7.
//  Copyright © 2016年 fmouer. All rights reserved.
//

#import "AHDBaseControlModel.h"
#import "AHDActionProtocol.h"

@interface AHDTagModel : AHDBaseControlModel<AHDActionProtocol>

@property (nonatomic, strong)NSString * tagName;

@property (nonatomic, assign)BOOL isSelected;

@end
