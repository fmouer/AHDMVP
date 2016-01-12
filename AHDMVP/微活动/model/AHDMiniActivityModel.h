//
//  AHDMiniActivityModel.h
//  AHDMVP
//
//  Created by ihotdo on 16/1/5.
//  Copyright © 2016年 fmouer. All rights reserved.
//

#import "AHDActivityModel.h"
#import "AHDActionProtocol.h"
#import "AHDUserModel.h"

@interface AHDMiniActivityModel : AHDActivityModel<AHDActionProtocol>

@property (nonatomic, strong)AHDUserModel * userModel;

@property (nonatomic, strong)NSString * tag;

@property (nonatomic, strong)NSString * time;


@property (nonatomic, assign)NSInteger fee;

@property (nonatomic, strong)NSString * numberPersonRequest;

@property (nonatomic, strong)NSString * distance;

@property (nonatomic, strong)NSArray * member;



@property (nonatomic, strong)NSString * timeString;

@property (nonatomic, strong)NSString * distanceString;

- (NSString *)getFeeTypeString;

@end
