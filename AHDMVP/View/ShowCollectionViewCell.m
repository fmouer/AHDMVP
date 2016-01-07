//
//  ShowCollectionViewCell.m
//  MVPDemo
//
//  Created by ihotdo on 15/12/31.
//  Copyright © 2015年 ihotdo. All rights reserved.
//

#import "ShowCollectionViewCell.h"
#import "AHDShowModel.h"

@interface ShowCollectionViewCell ()
{
    NSArray * widths ;
}
@property (nonatomic,copy)CellSizeBlock sizeBlock;
@property (nonatomic,assign)CGSize cellSize;

@property (nonatomic, assign)float width;

@end

@implementation ShowCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        widths = @[@"100",@"110",@"90",@"150",@"120"];
//        float width = rand()%100 + 50;
        NSInteger index = rand() % 5;
        self.width =[widths[index] floatValue];
        
        [self initLabel];
    }
    return self;
}

- (void)initLabel
{
    _titleLabel = [[UILabel alloc] initWithFrame:(CGRect){20,20,100,20}];
    [self addSubview:_titleLabel];
    _titleLabel.text = @"showCell";
}

-(void)setCellModel:(id<AHDModelProtocol>)model
{
    AHDShowModel * showModel = (AHDShowModel *)model;
    _titleLabel.text = [NSString stringWithFormat:@"%ld", (long)showModel.indexPath.row];
    self.backgroundColor = [UIColor colorWithRed:random()%255 / 255.0 green:random()%255 /255.0 blue:random()%255 / 255.0 alpha:1];
    NSLog(@"title is %@",_titleLabel.text);
}

-(void)setCellSize:(CGSize)size getActualSize:(CellSizeBlock)sizeBlock
{
    _cellSize = size;
    self.sizeBlock = sizeBlock;
}

- (UICollectionViewLayoutAttributes *)preferredLayoutAttributesFittingAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes
{
    UICollectionViewLayoutAttributes  * attributes = [super preferredLayoutAttributesFittingAttributes:layoutAttributes];
    
    
    //默认会给_cellSize.width 传collectionView的width
    if (_cellSize.height != 0.0) {
        attributes.size = _cellSize;
    }else{
        CGRect rect = attributes.frame;
        rect.size = CGSizeMake(layoutAttributes.size.width, 70);
        
        attributes.frame = rect;
        if (self.sizeBlock) {
            self.sizeBlock(rect.size);
        }
    }

    return attributes;
}

-(void)updatePartOfCell:(AHDBaseDataAction *)actionModel result:(NSDictionary *)result
{
    NSLog(@"%s",__func__);
    NSLog(@"局部更新 ：actionType is %@",actionModel.actionType);
}

@end
