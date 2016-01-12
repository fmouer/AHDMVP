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
#import "CellMemberView.h"

@interface AHDMiniActivityCell ()
{
    VerticalLabel   * _addressLabel;
    VerticalLabel   * _timeLabel;
    VerticalLabel   * _feeTypeLabel;
    VerticalLabel   * _numberLabel;
    
    UIButton        * _userHeaderButton;
    
    VerticalLabel   * _activityTagLabel;
    VerticalLabel   * _titleLabel;
    
    UILabel         * _distanceLabel;
    
    CellMemberView  * _memberView;
    
    UIButton        * _applyButton;
    
    UILabel         * _sexLabel;
    
    UIButton        * _numberMemberView;
}

@end

@implementation AHDMiniActivityCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithRed:random()%255 / 255.0 green:random()%255 /255.0 blue:random()%255 / 255.0 alpha:1];
        
        [self initialization];
        [self toLayoutSubViews];
        [self loadSubView];
        
        
    }
    return self;
}

/**
 *  初始化views
 */
- (void)initialization
{
    //头像
    _userHeaderButton = [UIButton buttonWithType:UIButtonTypeCustom];

    //竖直label
    _activityTagLabel = [VerticalLabel verticalLabel:[UIFont boldSystemFontOfSize:20] color:[UIColor blackColor]];
    _titleLabel = [VerticalLabel verticalLabel:[UIFont systemFontOfSize:15] color:[UIColor blackColor]];
    
    _addressLabel = [VerticalLabel verticalLabel:[UIFont systemFontOfSize:15] color:[UIColor blackColor]];
    _timeLabel = [VerticalLabel verticalLabel:[UIFont systemFontOfSize:15] color:[UIColor blackColor]];
    _feeTypeLabel = [VerticalLabel verticalLabel:[UIFont systemFontOfSize:15] color:[UIColor blackColor]];
    _numberLabel = [VerticalLabel verticalLabel:[UIFont systemFontOfSize:15] color:[UIColor blackColor]];
 
    //竖直label的 图标
    [_addressLabel setTitleImageName:@""];
    [_timeLabel setTitleImageName:@""];
    [_feeTypeLabel setTitleImageName:@""];
    [_numberLabel setTitleImageName:@""];
    
    //距离
    _distanceLabel = [[UILabel alloc] init];
    _distanceLabel.font = [UIFont systemFontOfSize:13];
    
    //成员
    _memberView = [[CellMemberView alloc] init];
    
    __weak typeof(AHDMiniActivityCell *)wSelf = self;
    _memberView.selectedMemberBlock = ^(AHDUserModel * userModel){
        [wSelf selectedUser:userModel];
    };
    
    //感兴趣等按钮
    _applyButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_applyButton addTarget:self action:@selector(clickButtonEvent) forControlEvents:UIControlEventTouchUpInside];
    [_applyButton setTitle:@"button" forState:UIControlStateNormal];

    //性别
    _sexLabel = [[UILabel alloc] init];
    _sexLabel.font = [UIFont systemFontOfSize:15];
    _sexLabel.textColor = [UIColor whiteColor];
    _sexLabel.backgroundColor = [UIColor redColor];
    _sexLabel.layer.borderColor = [UIColor whiteColor].CGColor;
    _sexLabel.layer.borderWidth = 0.6;
    _sexLabel.layer.cornerRadius = 10;
    _sexLabel.layer.masksToBounds = YES;
    _sexLabel.textAlignment = NSTextAlignmentCenter;
    
    //成员数量
    _numberMemberView = [UIButton buttonWithType:UIButtonTypeCustom ];
    
    
    _applyButton.backgroundColor = [UIColor redColor];
    
    _numberMemberView.backgroundColor = [UIColor blackColor];
    [_numberMemberView setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _numberMemberView.titleLabel.font = [UIFont systemFontOfSize:12];
}

/**
 *  子View布局
 */
- (void)toLayoutSubViews
{
    _userHeaderButton.frame = CGRectMake(20, 40, 50, 50);
    _userHeaderButton.backgroundColor = [UIColor grayColor];
    
    _activityTagLabel.frame = CGRectMake(130, 15, 30, 100);
    _titleLabel.frame = CGRectMake(95, 15, 30, 100);
    
    float height = 150;
    float y = CGRectGetMaxY(_userHeaderButton.frame) + 25;
    _numberLabel.frame = CGRectMake(15, y, 30, height);
    _feeTypeLabel.frame = CGRectMake(46, y, 30, height);
    _timeLabel.frame = CGRectMake(77, y, 30, height);
    _addressLabel.frame = CGRectMake(108, y, 30, height);
    
    _distanceLabel.frame = CGRectMake(90, 300, 80, 20);
    
    
    _applyButton.frame = CGRectMake(30, 300, 60, 40);
    
    _sexLabel.frame = CGRectMake(10, 20, 20, 20);
    
    _numberMemberView.frame = CGRectMake(CGRectGetMaxX(_addressLabel.frame) + 5, y, 30, 25);
    _memberView.frame = CGRectMake(CGRectGetMaxX(_addressLabel.frame) + 5, CGRectGetMaxY(_numberMemberView.frame) + 3, 35, 150);

}
/**
 *  加载view
 */
- (void)loadSubView
{
    [self addSubview:_userHeaderButton];
    [self addSubview:_activityTagLabel];
    [self addSubview:_titleLabel];
    [self addSubview:_addressLabel];
    [self addSubview:_timeLabel];
    [self addSubview:_feeTypeLabel];
    [self addSubview:_numberLabel];
    [self addSubview:_distanceLabel];
    [self addSubview:_memberView];
    [self addSubview:_applyButton];
    [self addSubview:_sexLabel];
    [self addSubview:_numberMemberView];
}

-(void)setCellModel:(id<AHDModelProtocol>)model
{
    AHDMiniActivityModel * miniActModel = (AHDMiniActivityModel *)model;
    _addressLabel.labelText = miniActModel.address;
    _timeLabel.labelText = miniActModel.timeString;
    _titleLabel.labelText = miniActModel.title;
    _feeTypeLabel.labelText = [miniActModel getFeeTypeString];
    _activityTagLabel.labelText = miniActModel.tag;
    
    _numberLabel.labelText = miniActModel.numberPersonRequest;
    _distanceLabel.text = miniActModel.distanceString;
    _memberView.members = nil;
    _sexLabel.text = @"G";
    
    [_numberMemberView setTitle:@"1人" forState:UIControlStateNormal];
}

- (void)clickButtonEvent
{
    self.cellOpeationBlock(MiniActivityActionTypeClick);
}

- (void)selectedUser:(AHDUserModel *)userModel
{
    self.cellOpeationBlock(userModel);
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
