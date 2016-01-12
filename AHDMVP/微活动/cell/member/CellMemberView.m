//
//  CellMemberView.m
//  AHDMVP
//
//  Created by ihotdo on 16/1/11.
//  Copyright © 2016年 fmouer. All rights reserved.
//

#import "CellMemberView.h"

@interface MemberCell : UITableViewCell

@property (nonatomic, strong)UIImageView  * cellImageView;

@end

@implementation CellMemberView

-(void)layoutSubviews
{
    [self loadSubView];
}

- (void)loadSubView
{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:self.bounds];
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        [_tableView registerClass:[MemberCell class] forCellReuseIdentifier:@"memberCell"];
        [self addSubview:_tableView];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        
    }
}

-(void)setMembers:(NSArray *)members
{
    _members = members;
    
    [_tableView reloadData];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MemberCell * cell = [tableView dequeueReusableCellWithIdentifier:@"memberCell"];
    
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return self.frame.size.height/5.0;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    _selectedMemberBlock(nil);
}

@end


@implementation MemberCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.cellImageView = [[UIImageView alloc] init];
        [self.contentView addSubview:self.imageView];
        self.imageView.backgroundColor = [UIColor colorWithRed:random()%255 / 255.0 green:random()%255 /255.0 blue:random()%255 / 255.0 alpha:1];

    }
    return self;
}

-(void)layoutSubviews
{
    self.imageView.frame = self.frame;
}

@end
