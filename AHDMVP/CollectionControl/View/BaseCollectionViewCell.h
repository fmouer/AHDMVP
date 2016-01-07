//
//  BaseCollectionViewCell.h
//  AHDMVP
//
//  Created by ihotdo on 16/1/5.
//  Copyright © 2016年 fmouer. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "AHDCellProtocol.h"

@interface BaseCollectionViewCell : UICollectionViewCell<AHDCellProtocol>

@property (nonatomic, copy)CellOperationBlock cellOpeationBlock;


@property (nonatomic, strong)UILabel * titleLabel;

/*
 @property (nonatomic, assign)CGSize cellSize;
 
 @property (nonatomic,copy)CellSizeBlock sizeBlock;
 */
@end
