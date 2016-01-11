//
//  AHDMiniActivityModel.h
//  AHDMVP
//
//  Created by ihotdo on 16/1/5.
//  Copyright © 2016年 fmouer. All rights reserved.
//

#import "AHDBaseControlModel.h"
#import "AHDActionProtocol.h"
#import "AHDUserModel.h"

@interface AHDMiniActivityModel : AHDBaseControlModel<AHDActionProtocol>

@property (nonatomic, strong)NSString * content;

@property (nonatomic, strong)AHDUserModel * userModel;

@property (nonatomic, strong)NSString * timeString;

@end
