//
//  AHDActivityCell.h
//  AHDMVP
//
//  Created by ihotdo on 16/1/5.
//  Copyright © 2016年 fmouer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AHDCellProtocol.h"

@interface AHDActivityCell : UICollectionViewCell<AHDCellProtocol>

@property (nonatomic, strong)UILabel    * titleLabel;

@property (nonatomic, strong)UILabel    * dateLabel;

@property (nonatomic, strong)UILabel    * peopleLabel;

@end
