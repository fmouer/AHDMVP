//
//  AHDMiniActivityCell.m
//  AHDMVP
//
//  Created by ihotdo on 16/1/5.
//  Copyright © 2016年 fmouer. All rights reserved.
//

#import "AHDMiniActivityCell.h"
#import "AHDMiniActivityModel.h"
#import "AHDMiniActivityHeader.h"
#import "VerticalLabel.h"

@interface AHDMiniActivityCell ()
{
    VerticalLabel   * _addressLabel;
    VerticalLabel   * _timeLabel;
    VerticalLabel   * _feeTypeLabel;
    VerticalLabel   * _numberLabel;
    
    UIButton        * _userHeaderButton;
    
    VerticalLabel   * _activityTagLabel;
    VerticalLabel   * _titleLabel;
    
}

@end

@implementation AHDMiniActivityCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithRed:random()%255 / 255.0 green:random()%255 /255.0 blue:random()%255 / 255.0 alpha:1];

        _userHeaderButton.frame = CGRectMake(0, 0, 50, 50);
        _userHeaderButton.backgroundColor = [UIColor blackColor];
        [self addSubview:_userHeaderButton];
        
      
        
        
        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button addTarget:self action:@selector(clickButtonEvent) forControlEvents:UIControlEventTouchUpInside];
        button.backgroundColor = [UIColor redColor];
        [button setTitle:@"button" forState:UIControlStateNormal];
        button.frame = CGRectMake(30, 300, 100, 40);
        [self addSubview:button];
    }
    return self;
}
- (void)initialization
{
    _userHeaderButton = [UIButton buttonWithType:UIButtonTypeCustom];

    _activityTagLabel = [VerticalLabel verticalLabel:[UIFont boldSystemFontOfSize:20] color:[UIColor blackColor]];
    _titleLabel = [VerticalLabel verticalLabel:[UIFont systemFontOfSize:15] color:[UIColor blackColor]];
    _addressLabel = [VerticalLabel verticalLabel:[UIFont systemFontOfSize:15] color:[UIColor blackColor]];
    _timeLabel = [VerticalLabel verticalLabel:[UIFont systemFontOfSize:15] color:[UIColor blackColor]];
    _feeTypeLabel = [VerticalLabel verticalLabel:[UIFont systemFontOfSize:15] color:[UIColor blackColor]];
    _numberLabel = [VerticalLabel verticalLabel:[UIFont systemFontOfSize:15] color:[UIColor blackColor]];
    
}

- (void)toLayoutSubViews
{
    _userHeaderButton.frame = CGRectMake(0, 40, 50, 50);
    
    _activityTagLabel.frame = CGRectMake(120, 15, 30, 100);
    _timeLabel.frame = CGRectMake(95, 15, 30, 100);
    
    _numberLabel.frame = CGRectMake(15, CGRectGetMaxY(_userHeaderButton.frame) + 25, 30, 100);
    _feeTypeLabel.frame = CGRectMake(46, CGRectGetMaxY(_userHeaderButton.frame) + 25, 30, 100);
    _timeLabel.frame = CGRectMake(77, CGRectGetMaxY(_userHeaderButton.frame) + 25, 30, 100);
    _addressLabel.frame = CGRectMake(108, CGRectGetMaxY(_userHeaderButton.frame) + 25, 30, 100);
}

- (void)loadSubView
{
    [self addSubview:_userHeaderButton];
    [self addSubview:_activityTagLabel];
    [self addSubview:_titleLabel];
    [self addSubview:_addressLabel];
    [self addSubview:_timeLabel];
    [self addSubview:_feeTypeLabel];
    [self addSubview:_numberLabel];
    
}

-(void)setCellModel:(id<AHDModelProtocol>)model
{
    AHDMiniActivityModel * miniActModel = (AHDMiniActivityModel *)model;
    self.titleLabel.text = miniActModel.content;
}

- (void)clickButtonEvent
{
    self.cellOpeationBlock(MiniActivityActionTypeClick);
}

-(void)updatePartOfCell:(AHDBaseDataAction *)actionModel result:(NSDictionary *)result
{
    if ([actionModel.actionType isEqualToString: MiniActivityActionTypeClick]) {
        NSString * message = [NSString stringWithFormat:@"type:%@ 事件响应之后处理",actionModel.actionType];
        NSLog(@"%@",message);
        UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"cell 局部更新" message:message delegate:nil cancelButtonTitle:@"好的" otherButtonTitles:nil, nil];
        [alertView show];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
