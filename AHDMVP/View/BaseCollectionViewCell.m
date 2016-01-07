//
//  BaseCollectionViewCell.m
//  AHDMVP
//
//  Created by ihotdo on 16/1/5.
//  Copyright © 2016年 fmouer. All rights reserved.
//

#import "BaseCollectionViewCell.h"

@implementation BaseCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initLabel];
    }
    return self;
}
-(void)setCellSize:(CGSize)size getActualSize:(CellSizeBlock)sizeBlock
{
    _cellSize = size;
    self.sizeBlock = sizeBlock;
}
-(void)setCellModel:(id<AHDModelProtocol>)model
{
    
}

- (void)initLabel
{
    _titleLabel = [[UILabel alloc] initWithFrame:(CGRect){20,20,100,20}];
    [self addSubview:_titleLabel];
    _titleLabel.text = @"showCell";
}
@end
