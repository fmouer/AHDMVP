//
//  ShowCollectionHeaderView.m
//  AHDMVP
//
//  Created by ihotdo on 16/1/5.
//  Copyright © 2016年 fmouer. All rights reserved.
//

#import "ShowCollectionHeaderView.h"
#import "AHDHeaderModel.h"

@implementation ShowCollectionHeaderView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
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
    AHDHeaderModel * showModel = (AHDHeaderModel *)model;
    _titleLabel.text = [NSString stringWithFormat:@"header %@",showModel.content];
    NSLog(@"title is %@",_titleLabel.text);
}
@end
