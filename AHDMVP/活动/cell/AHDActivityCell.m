//
//  AHDActivityCell.m
//  AHDMVP
//
//  Created by ihotdo on 16/1/5.
//  Copyright © 2016年 fmouer. All rights reserved.
//

#import "AHDActivityCell.h"
#import "AHDActivityModel.h"

@implementation AHDActivityCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initLabel];
        self.backgroundColor = [UIColor colorWithRed:random()%255 / 255.0 green:random()%255 /255.0 blue:random()%255 / 255.0 alpha:1];

    }
    return self;
}
- (void)initLabel
{
    _titleLabel = [[UILabel alloc] initWithFrame:(CGRect){20,20,100,20}];
    [self addSubview:_titleLabel];
    
    _dateLabel = [[UILabel alloc] initWithFrame:(CGRect){20,50,150,20}];
    [self addSubview:_dateLabel];

    _peopleLabel = [[UILabel alloc] initWithFrame:(CGRect){20,80,150,20}];
    [self addSubview:_peopleLabel];

}

-(void)setCellModel:(id<AHDModelProtocol>)model
{
    AHDActivityModel * actModel = (AHDActivityModel *)model;
    _titleLabel.text = actModel.title;
    
//    _dateLabel.text = actModel.date;

//    _peopleLabel.text = actModel.peopleNumber;
}


@end
