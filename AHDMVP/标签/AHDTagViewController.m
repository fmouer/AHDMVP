//
//  AHDTagViewController.m
//  AHDMVP
//
//  Created by ihotdo on 16/1/7.
//  Copyright © 2016年 fmouer. All rights reserved.
//

#import "AHDTagViewController.h"
#import "AHDCollectionControl.h"
#import "AHDTagHelper.h"
#import "AHDTagModel.h"
#import "AHDTagAction.h"

@interface AHDTagViewController ()<AHDCollectionControlDelegate>
{
    AHDCollectionControl    *   _collectionControl;
    NSInteger                   _selectedCount;
}

@end

@implementation AHDTagViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    CGRect rect = self.view.bounds;
    rect.origin.y = 64;
    rect.size.height -= 64;
    
    _collectionControl = [[AHDCollectionControl alloc] initWithFrame:rect helperModel:[[AHDTagHelper alloc] init]];
    _collectionControl.delegate =  self;
    //cell 左右最小间距
    _collectionControl.minimumLineSpacing = 5;
    //cell 上下最小间距
    _collectionControl.minimumInteritemSpacing = 5;
    _collectionControl.collectionEdgeInsets = UIEdgeInsetsMake(5, 15, 5, 15);

    [self.view addSubview:_collectionControl];
}

-(void)viewDidAppear:(BOOL)animated
{
    [_collectionControl setControlData:[self getData] page:0];
}


- (NSArray * )getData
{
    NSMutableArray * data = [[NSMutableArray alloc] init];
    NSString * string = @"My father was a self-taught mandolin player. He was one of the best string instrument players in our town. He could not read music, but if he heard a tune a few times, he could play it. When he was younger, he was a member of a small country music band. They would play at local dances and on a few occasions would play for the local radio station. He often told us how he had auditioned and earned a position in a band that featured Patsy Cline as their lead singer. ";
    NSArray * datas = [string componentsSeparatedByString:@" "];
    for (NSString * name in datas) {
        [data addObject:@{@"tagName":name}];
    }
    return data;
}

#pragma mark AHDCollectionControlDelegate
-(void)collectionControl:(AHDCollectionControl *)collectionControl didDataAction:(AHDBaseDataAction *)dataAction
{
    AHDTagModel * tagModel = (AHDTagModel *)dataAction.model;
    NSLog(@"tagName is \"%@\" ,selected: %@ ",tagModel.tagName,tagModel.isSelected?@"选中":@"取消");
    if (tagModel.isSelected) {
        _selectedCount ++;
    }else{
        _selectedCount --;
    }
}

-(BOOL)shouldCollectionControl:(AHDCollectionControl *)collectionControl willDataAction:(AHDBaseDataAction *)dataAction
{
    AHDTagModel * tagModel = (AHDTagModel *)dataAction.model;
    if (tagModel.isSelected) {
        return YES;
    }

    BOOL canSelected = _selectedCount < 5;
    if (!canSelected) {
        UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"最多可选5个标签" delegate:nil cancelButtonTitle:@"好的" otherButtonTitles:nil, nil];
        [alertView show];
    }
    return canSelected;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
