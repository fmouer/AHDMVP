//
//  AHDShowModel.h
//  MVPDemo
//
//  Created by ihotdo on 15/12/28.
//  Copyright © 2015年 ihotdo. All rights reserved.
//

#import "AHDBaseControlModel.h"
#import "AHDModelProtocol.h"
#import "AHDActionProtocol.h"

@interface AHDShowModel : AHDBaseControlModel<AHDModelProtocol,AHDActionProtocol>

@property (nonatomic, strong)NSString * content;

@property (nonatomic, strong)NSIndexPath * indexPath;

@property (nonatomic, assign)BOOL update;

@property (nonatomic, assign)NSInteger height;

@end
