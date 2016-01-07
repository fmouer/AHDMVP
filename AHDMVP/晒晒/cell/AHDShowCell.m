//
//  AHDShowCell.m
//  AHDMVP
//
//  Created by ihotdo on 16/1/5.
//  Copyright © 2016年 fmouer. All rights reserved.
//

#import "AHDShowCell.h"
#import "AHDShowModel.h"
#import "AHDShowHeader.h"

@interface AHDShowCell()

@property (nonatomic, strong)AHDShowModel * model;

@end

@implementation AHDShowCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self loadSubView];
    }
    return self;
}

-(void)awakeFromNib
{
    [super awakeFromNib];
    [self loadSubView];
}

- (void)loadSubView
{
    self.backgroundColor = [UIColor colorWithRed:random()%255 / 255.0 green:random()%255 /255.0 blue:random()%255 / 255.0 alpha:1];
    
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button addTarget:self action:@selector(clickButtonEvent) forControlEvents:UIControlEventTouchUpInside];
    button.backgroundColor = [UIColor redColor];
    [button setTitle:@"cell 高度改变" forState:UIControlStateNormal];
    button.frame = CGRectMake(100, 60, 200, 40);
    [self addSubview:button];
    
    UIButton * button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [button1 addTarget:self action:@selector(clickButtonEvent1) forControlEvents:UIControlEventTouchUpInside];
    button1.backgroundColor = [UIColor redColor];
    [button1 setTitle:@"转发插入" forState:UIControlStateNormal];
    button1.frame = CGRectMake(100, 105, 200, 40);
    [self addSubview:button1];
    
    UIButton * button2 = [UIButton buttonWithType:UIButtonTypeCustom];
    [button2 addTarget:self action:@selector(clickButtonEvent2) forControlEvents:UIControlEventTouchUpInside];
    button2.backgroundColor = [UIColor redColor];
    [button2 setTitle:@"删除" forState:UIControlStateNormal];
    button2.frame = CGRectMake(100, 150, 200, 40);
    [self addSubview:button2];

}
- (void)clickButtonEvent2
{
    self.cellOpeationBlock(ShowDeleteActionType);
}

- (void)clickButtonEvent1
{
    self.cellOpeationBlock(ShowInsertActionType);
}

- (void)clickButtonEvent
{
    self.cellOpeationBlock(ShowUpdateActionType);
}

-(void)setCellModel:(id<AHDModelProtocol>)model
{
    AHDShowModel * showModel = (AHDShowModel *)model;
    self.titleLabel.text = [NSString stringWithFormat:@"%@ %ld" ,showModel.content,(long)showModel.indexPath.row];
    self.model = (AHDShowModel *)model;
}

-(CGSize)getCellSize
{
    return CGSizeMake(CGRectGetWidth(self.frame), 500);
}




//+ (CGSize)getCellSizeWith:(id<AHDModelProtocol>)model cellWidth:(float)width
//{
//    return CGSizeMake(375, 501);
//}

//- (UICollectionViewLayoutAttributes *)preferredLayoutAttributesFittingAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes
//{
//    UICollectionViewLayoutAttributes  * attributes = [super preferredLayoutAttributesFittingAttributes:layoutAttributes];
//    
//    //默认会给_cellSize.width 传collectionView的width
//    NSLog(@"attri index is %d",self.model.indexPath.row);
////    if (self.cellSize.height != 0.0) {
////        attributes.size = self.cellSize;
////    }
////    else{
////        float height = [self.model height];
//    
//        if (self.model.update) {
//            self.model.height += 100;
//            self.model.update = NO;
//        }
//        
//        attributes.size =  CGSizeMake(layoutAttributes.size.width, self.model.height);
//        
//        if (self.sizeBlock) {
//            self.sizeBlock(attributes.size);
//        }
////    }
//    
//    return attributes;
//}

@end
