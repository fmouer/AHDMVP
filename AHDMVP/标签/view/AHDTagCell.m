//
//  AHDTagCell.m
//  AHDMVP
//
//  Created by ihotdo on 16/1/7.
//  Copyright © 2016年 fmouer. All rights reserved.
//

#import "AHDTagCell.h"
#import "AHDTagModel.h"

@implementation AHDTagCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _labelButton = [[UIButton alloc] init];
        _labelButton.titleLabel.font = [UIFont boldSystemFontOfSize:18];
        _labelButton.layer.borderColor = [[UIColor redColor] CGColor];
        _labelButton.layer.borderWidth = 0.8;
        _labelButton.layer.cornerRadius = 10;
        [_labelButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        [_labelButton addTarget:self action:@selector(labelButtonSelect)  forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:_labelButton];
        
//        self.backgroundColor = [UIColor colorWithRed:random()%255 / 255.0 green:random()%255 /255.0 blue:random()%255 / 255.0 alpha:1];

    }
    return self;
}
-(void)setCellModel:(id<AHDModelProtocol>)model
{
    AHDTagModel * tagModel = (AHDTagModel *)model;
    [_labelButton setTitle:tagModel.tagName forState:UIControlStateNormal];
    [self updateSelected:model];
}

-(void)layoutSubviews
{
    _labelButton.frame = self.bounds;
}

- (void)labelButtonSelect
{
    self.cellOpeationBlock(@"buttonSelect");
}

-(void)updatePartOfCell:(AHDBaseDataAction *)actionModel result:(NSDictionary *)result
{
    _labelButton.selected = !_labelButton.selected;
    [self updateSelected:actionModel.model];
   
}

- (void)updateSelected:(id<AHDModelProtocol>)model
{
    AHDTagModel * tagModel = (AHDTagModel *)model;
    if (tagModel.isSelected) {
        _labelButton.backgroundColor = [UIColor orangeColor];
    }else{
        _labelButton.backgroundColor = [UIColor clearColor];
    }
}

+(CGSize)getCellSizeWith:(id<AHDModelProtocol>)model cellWidth:(float)width
{
    AHDTagModel * tagModel = (AHDTagModel *)model;
    CGSize size = [tagModel.tagName boundingRectWithSize:(CGSize){MAXFLOAT,20} options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:20]} context:nil].size;
    return CGSizeMake(size.width + 20, size.height + 2);
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
