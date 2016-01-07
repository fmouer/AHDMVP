//
//  ShowCollectionHeaderView.h
//  AHDMVP
//
//  Created by ihotdo on 16/1/5.
//  Copyright © 2016年 fmouer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AHDModelProtocol.h"

@interface ShowCollectionHeaderView : UICollectionReusableView<AHDModelProtocol>

@property (nonatomic, strong)UILabel * titleLabel;
@end
