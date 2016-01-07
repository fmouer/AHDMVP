//
//  ShowCollectionViewCell.h
//  MVPDemo
//
//  Created by ihotdo on 15/12/31.
//  Copyright © 2015年 ihotdo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AHDCellProtocol.h"

@interface ShowCollectionViewCell : UICollectionViewCell<AHDCellProtocol>
{

}
@property (nonatomic, strong)UILabel * titleLabel;

@property (nonatomic, copy)CellOperationBlock cellOpeationBlock;

@end
