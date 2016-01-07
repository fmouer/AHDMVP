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

@implementation AHDMiniActivityCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithRed:random()%255 / 255.0 green:random()%255 /255.0 blue:random()%255 / 255.0 alpha:1];

        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button addTarget:self action:@selector(clickButtonEvent) forControlEvents:UIControlEventTouchUpInside];
        button.backgroundColor = [UIColor redColor];
        [button setTitle:@"button" forState:UIControlStateNormal];
        button.frame = CGRectMake(30, 100, 100, 40);
        [self addSubview:button];
    }
    return self;
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
